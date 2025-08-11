import 'package:flutter/material.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/local_auth_service.dart';

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

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final user = await _authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no login. Verifique suas credenciais.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
    }
     setState(() {
      _isLoading = false;
    });
  }

  void _biometricLogin() async {
    final isAuthenticated = await LocalAuthService.authenticate();
    if(isAuthenticated){
       // Aqui você pode adicionar uma lógica para pegar o último e-mail logado
       // e fazer o login ou simplesmente levar para a tela principal se o token
       // do firebase ainda for válido. Por simplicidade, vamos assumir que
       // a validação do token é gerenciada pelo AuthWrapper.
       // Se o usuário já está logado no Firebase, o AuthWrapper o redirecionará.
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Autenticado com sucesso! Redirecionando...'),
          backgroundColor: Colors.green,
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
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!) {
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