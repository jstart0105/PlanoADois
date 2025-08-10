import 'package:flutter/material.dart';

class InvestmentsCard extends StatelessWidget {
  final bool isCoupleView;

  const InvestmentsCard({super.key, required this.isCoupleView});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo
    final String totalInvested =
        isCoupleView ? 'R\$ 25.000,00' : 'R\$ 10.000,00';
    final String currentPortfolio =
        isCoupleView ? 'R\$ 25.700,00' : 'R\$ 10.280,00';
    final String performance = '+2.8%';

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
              'Resumo de Investimentos',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0f172a)), // slate-900
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInvestmentInfo('Total Investido', totalInvested),
                _buildInvestmentInfo('Carteira Atual', currentPortfolio),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Performance Geral',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1e293b)), // slate-800
                ),
                Text(
                  performance,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff14b8a6)), // teal-500
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentInfo(String title, String value) {
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
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff0f172a)), // slate-900
        ),
      ],
    );
  }
}