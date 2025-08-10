import 'package:flutter/material.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo
    const String goalTitle = 'Viagem para a Europa';
    const double currentAmount = 12000.0;
    const double targetAmount = 20000.0;
    final double progress = currentAmount / targetAmount;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias, // Para a imagem respeitar as bordas
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1528181304800-259b08848526', // Imagem de exemplo
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meta Principal',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff64748b)), // slate-500
                ),
                const SizedBox(height: 8),
                Text(
                  goalTitle,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0f172a)), // slate-900
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 16,
                    backgroundColor: const Color(0xffe2e8f0), // slate-200
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xff8b5cf6)), // violet-500
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'R\$ ${currentAmount.toStringAsFixed(2)} / R\$ ${targetAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1e293b)), // slate-800
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}