import 'package:flutter/material.dart';

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Categorias'),
        backgroundColor: const Color(0xfff1f5f9),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Lógica para adicionar nova categoria
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.category, size: 64, color: Color(0xffcbd5e1)), // slate-300
              const SizedBox(height: 16),
              const Text(
                'Nenhuma categoria personalizada.',
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