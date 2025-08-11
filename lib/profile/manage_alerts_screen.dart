import 'package:flutter/material.dart';

class ManageAlertsScreen extends StatelessWidget {
  const ManageAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Alertas'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.notifications_active, size: 64, color: Color(0xffcbd5e1)), // slate-300
              const SizedBox(height: 16),
              const Text(
                'Nenhum alerta configurado.',
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