import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plano_a_dois/models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isExpense = transaction.valor < 0;
    final DateFormat formatter = DateFormat('dd/MM/yyyy \'às\' HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Transação'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  transaction.descricao,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0f172a),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'R\$ ${transaction.valor.abs().toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isExpense ? const Color(0xffef4444) : const Color(0xff14b8a6),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isExpense ? 'Despesa' : 'Receita',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const Divider(height: 48),
                _buildDetailRow('Categoria:', transaction.categoria),
                _buildDetailRow('Data:', formatter.format(transaction.data)),
                _buildDetailRow('Responsável:', transaction.owner),
                _buildDetailRow('ID da Transação:', transaction.id),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff64748b),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff1e293b),
            ),
          ),
        ],
      ),
    );
  }
}