import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plano_a_dois/auth/welcome_screen.dart';
import 'package:plano_a_dois/home/home_screen.dart'; // Importe a nova tela
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      // Redireciona para a HomeScreen com o menu de navegação
      return const HomeScreen();
    }
    return const WelcomeScreen();
  }
}