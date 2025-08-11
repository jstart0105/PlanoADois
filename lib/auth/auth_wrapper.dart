import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plano_a_dois/dashboard/dashboard_screen.dart';
import 'package:plano_a_dois/transactions/transactions_screen.dart';
import 'package:plano_a_dois/auth/welcome_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const TransactionsScreen();
    }
    return const WelcomeScreen();
  }
}