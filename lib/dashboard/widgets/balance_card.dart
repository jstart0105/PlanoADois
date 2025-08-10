import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final bool isCoupleView;

  const BalanceCard({super.key, required this.isCoupleView});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo
    final String totalBalance = isCoupleView ? 'R\$ 15.250,00' : 'R\$ 8.100,00';
    final String monthlyIncome = isCoupleView ? 'R\$ 7.500,00' : 'R\$ 4.000,00';
    final String monthlyExpenses = isCoupleView ? 'R\$ 3.800,00' : 'R\$ 1.900,00';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo Total',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0f172a)), // slate-900
            ),
            const SizedBox(height: 8),
            Text(
              totalBalance,
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4f46e5)), // indigo-600
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIncomeExpenses(
                    'Receitas do Mês', monthlyIncome, const Color(0xff14b8a6)), // teal-500
                _buildIncomeExpenses(
                    'Despesas do Mês', monthlyExpenses, const Color(0xffef4444)), // red-500
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeExpenses(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xff64748b)), // slate-500
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}