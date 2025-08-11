import 'package:flutter/material.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/firestore_service.dart';
import 'package:plano_a_dois/models/user_model.dart';
import 'dart:math';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  bool _isLoading = false;

  String _generateInviteCode() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length)))).toUpperCase();
  }

  void _signUp() async {
    // Validações básicas
    if(_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }


    setState(() {
      _isLoading = true;
    });

    // 1. Cria o usuário no Firebase Auth
    final userCredential = await _authService.signUpWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (userCredential != null) {
      // 2. Cria o modelo do novo usuário com um código de convite
      final inviteCode = _generateInviteCode();
      final newUser = UserModel(
          uid: userCredential.uid,
          email: _emailController.text.trim(),
          nome: _nameController.text.trim(),
          inviteCode: inviteCode
          // partnerId será nulo inicialmente
      );

      // 3. Salva o novo usuário no Firestore
      await _firestoreService.createUser(newUser);

      // 4. Lógica de Conexão com Parceiro(a)
      final partnerInviteCode = _inviteCodeController.text.trim();
      if (partnerInviteCode.isNotEmpty) {
        // Busca o parceiro pelo código
        final partner = await _firestoreService.getUserByInviteCode(partnerInviteCode);
        if (partner != null) {
          // Se encontrou, vincula as contas
          await _firestoreService.linkPartners(newUser.uid, partner.uid);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Conectado com sucesso a ${partner.nome}!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // Se não encontrou, avisa o usuário
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Código de convite inválido. A conta foi criada, mas não foi vinculada.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }

      // 5. Navega para a tela principal
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

    } else {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no cadastro. Verifique os dados e tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
     setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua Conta'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
             const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
             const SizedBox(height: 16),
            TextFormField(
              controller: _inviteCodeController,
              decoration: const InputDecoration(labelText: 'Código do Parceiro(a) (Opcional)'),
            ),
            const SizedBox(height: 32),
             _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Cadastrar'),
                  ),
          ],
        ),
      ),
    );
  }
}