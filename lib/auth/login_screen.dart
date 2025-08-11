import 'package:flutter/material.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/local_auth_service.dart';
import 'package:plano_a_dois/services/storage_service.dart'; // Importe o novo serviço

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Preenche o campo de e-mail com o último e-mail salvo, se houver
    StorageService.getLastEmail().then((email) {
      if (email != null) {
        setState(() {
          _emailController.text = email;
        });
      }
    });
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await _authService.signInWithEmailAndPassword(
      email,
      password,
    );

    if (user != null) {
      // Salva o e-mail em caso de sucesso
      await StorageService.saveLastEmail(email);
      if (mounted) {
         Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } else {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha no login. Verifique suas credenciais.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    if (mounted) {
       setState(() {
        _isLoading = false;
      });
    }
  }

  void _biometricLogin() async {
    final lastEmail = await StorageService.getLastEmail();
    if (lastEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhum login anterior salvo para usar a biometria.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final isAuthenticated = await LocalAuthService.authenticate();
    if (isAuthenticated) {
      // O AuthWrapper irá redirecionar automaticamente se o usuário já estiver
      // logado no Firebase. Apenas mostramos uma confirmação.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Autenticado como $lastEmail! Redirecionando...'),
          backgroundColor: Colors.green,
        ),
      );
       // A lógica do AuthWrapper cuidará do redirecionamento
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha na autenticação biométrica.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            const SizedBox(height: 32),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Entrar'),
                  ),
            const SizedBox(height: 16),
            FutureBuilder<bool>(
              future: LocalAuthService.canAuthenticate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!) {
                  return TextButton.icon(
                    onPressed: _biometricLogin,
                    icon: const Icon(Icons.fingerprint),
                    label: const Text('Usar Biometria'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}