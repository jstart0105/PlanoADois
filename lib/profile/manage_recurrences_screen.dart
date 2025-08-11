import 'package:flutter/material.dart';

class ManageRecurrencesScreen extends StatelessWidget {
  const ManageRecurrencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Recorrências'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sync, size: 64, color: Color(0xffcbd5e1)), // slate-300
              const SizedBox(height: 16),
              const Text(
                'Nenhuma transação recorrente encontrada.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color(0xff64748b)), // slate-500
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}