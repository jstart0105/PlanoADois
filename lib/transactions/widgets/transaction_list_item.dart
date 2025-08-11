import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  final String category;
  final String description;
  final double value;
  final String owner;
  final String date;
  final VoidCallback onTap; // Adiciona o callback para o clique

  const TransactionListItem({
    super.key,
    required this.category,
    required this.description,
    required this.value,
    required this.owner,
    required this.date,
    required this.onTap, // Torna o callback obrigatório
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Alimentação':
        return Icons.restaurant;
      case 'Salário':
        return Icons.attach_money;
      case 'Lazer':
        return Icons.sports_esports;
      case 'Transporte':
        return Icons.directions_car;
      case 'Moradia':
        return Icons.home;
      case 'Saúde':
        return Icons.favorite;
      case 'Educação':
        return Icons.school;
      default:
        return Icons.circle;
    }
  }

  Widget _getOwnerIcon() {
    switch (owner) {
      case 'Meu':
        return const CircleAvatar(radius: 12, child: Text('Eu', style: TextStyle(fontSize: 10)));
      case 'Dele(a)':
        return const CircleAvatar(radius: 12, child: Text('El', style: TextStyle(fontSize: 10)));
      case 'Nosso':
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
      child: InkWell( // Adiciona o efeito de clique
        onTap: onTap, // Executa a função passada
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xffe2e8f0),
            child: Icon(_getCategoryIcon(category), color: const Color(0xff4f46e5)),
          ),
          title: Text(description, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff1e293b))),
          subtitle: Text(date, style: const TextStyle(color: Color(0xff64748b))),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'R\$ ${value.abs().toStringAsFixed(2)}', // Usa o valor absoluto
                style: TextStyle(
                  color: value >= 0 ? const Color(0xff14b8a6) : const Color(0xffef4444),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              _getOwnerIcon(),
            ],
          ),
        ),
      ),
    );
  }
}