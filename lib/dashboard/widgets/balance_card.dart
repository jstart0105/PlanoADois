import 'package:flutter/material.dart';
import 'package:plano_a_dois/models/transaction_model.dart';

class BalanceCard extends StatelessWidget {
  final List<TransactionModel> transactions;

  const BalanceCard({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Lógica para calcular os valores a partir das transações
    final double totalBalance = transactions.fold(0.0, (sum, item) => sum + item.valor);
    
    final DateTime now = DateTime.now();
    final double monthlyIncome = transactions
        .where((t) => t.valor > 0 && t.data.month == now.month && t.data.year == now.year)
        .fold(0.0, (sum, item) => sum + item.valor);
        
    final double monthlyExpenses = transactions
        .where((t) => t.valor < 0 && t.data.month == now.month && t.data.year == now.year)
        .fold(0.0, (sum, item) => sum + item.valor);

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
              'R\$ ${totalBalance.toStringAsFixed(2)}',
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
                    'Receitas do Mês', 'R\$ ${monthlyIncome.toStringAsFixed(2)}', const Color(0xff14b8a6)), // teal-500
                _buildIncomeExpenses(
                    'Despesas do Mês', 'R\$ ${monthlyExpenses.abs().toStringAsFixed(2)}', const Color(0xffef4444)), // red-500
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