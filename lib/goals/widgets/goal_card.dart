import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final double currentAmount;
  final double targetAmount;
  final String imageUrl;

  const GoalCard({
    super.key,
    required this.title,
    required this.currentAmount,
    required this.targetAmount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentAmount / targetAmount).clamp(0.0, 1.0);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 160,
                width: double.infinity,
                color: const Color(0xffe2e8f0), // slate-200
                child: const Icon(
                  Icons.image_not_supported,
                  color: Color(0xff64748b), // slate-500
                  size: 48,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0f172a), // slate-900
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 16,
                    backgroundColor: const Color(0xffe2e8f0), // slate-200
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xff8b5cf6)), // violet-500
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'R\$ ${currentAmount.toStringAsFixed(2)} / R\$ ${targetAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1e293b), // slate-800
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}