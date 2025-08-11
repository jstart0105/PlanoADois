import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  final String category;
  final String description;
  final double value;
  final String owner;
  final String date;

  const TransactionListItem({
    super.key,
    required this.category,
    required this.description,
    required this.value,
    required this.owner,
    required this.date,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Alimentação':
        return Icons.restaurant;
      case 'Salário':
        return Icons.attach_money;
      case 'Lazer':
        return Icons.sports_esports;
      default:
        return Icons.circle;
    }
  }

  Widget _getOwnerIcon() {
    switch (owner) {
      case 'me':
        return const CircleAvatar(radius: 12, child: Text('Eu', style: TextStyle(fontSize: 10)));
      case 'partner':
        return const CircleAvatar(radius: 12, child: Text('El', style: TextStyle(fontSize: 10)));
      case 'couple':
        return const Icon(Icons.people, size: 24);
      default:
        return const Icon(Icons.person, size: 24);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xffe2e8f0), // slate-200
          child: Icon(_getCategoryIcon(category), color: const Color(0xff4f46e5)),
        ),
        title: Text(description, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff1e293b))),
        subtitle: Text(date, style: const TextStyle(color: Color(0xff64748b))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'R\$ ${value.toStringAsFixed(2)}',
              style: TextStyle(
                color: value > 0 ? const Color(0xff14b8a6) : const Color(0xffef4444),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            _getOwnerIcon(),
          ],
        ),
      ),
    );
  }
}