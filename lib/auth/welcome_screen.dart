import 'package:flutter/material.dart';
import 'package:plano_a_dois/auth/login_screen.dart';
import 'package:plano_a_dois/auth/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f5f9), // slate-100
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                Icons.favorite,
                color: Color(0xff4f46e5), // indigo-600
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Bem-vindo(a) ao Plano a Dois',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0f172a), // slate-900
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'O seu app para planejar a vida financeira em casal, com simplicidade e transparência.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff64748b), // slate-500
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4f46e5), // indigo-600
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                   side: const BorderSide(color: Color(0xff4f46e5)), // indigo-600
                ),
                child: const Text('Criar Conta', style: TextStyle(fontSize: 16, color: Color(0xff4f46e5))),
              ),
               const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}