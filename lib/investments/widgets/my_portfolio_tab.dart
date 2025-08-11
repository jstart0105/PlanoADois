import 'package:flutter/material.dart';

class MyPortfolioTab extends StatelessWidget {
  const MyPortfolioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo da Carteira',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0f172a)),
                  ),
                  const SizedBox(height: 16),
                  _buildPortfolioInfo('Valor Total Investido', 'R\$ 25.000,00'),
                  const SizedBox(height: 16),
                  _buildPortfolioInfo('Valor Atual da Carteira', 'R\$ 25.700,00'),
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
                            color: Color(0xff1e293b)),
                      ),
                      const Text(
                        '+2.8%',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff14b8a6)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Meus Ativos',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0f172a),
                ),
          ),
          const SizedBox(height: 16),
          _buildAssetItem('ITSA4', '+1.25%', '+5.8%', 'R\$ 5.250,00'),
          _buildAssetItem('MXRF11', '-0.50%', '+12.3%', 'R\$ 3.120,00'),
          _buildAssetItem('BOVA11', '+2.10%', '+8.1%', 'R\$ 2.570,00'),
        ],
      ),
    );
  }

  Widget _buildPortfolioInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xff64748b)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff0f172a)),
        ),
      ],
    );
  }

  Widget _buildAssetItem(String asset, String dayVariation, String personalYield, String totalValue) {
    final isPositive = !dayVariation.startsWith('-');
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isPositive ? const Color(0xffd1fae5) : const Color(0xfffee2e2),
          child: Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            color: isPositive ? const Color(0xff059669) : const Color(0xffef4444),
            size: 20,
          ),
        ),
        title: Text(asset, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff1e293b))),
        subtitle: Text('Rendimento: $personalYield', style: const TextStyle(color: Color(0xff64748b))),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayVariation,
              style: TextStyle(
                color: isPositive ? const Color(0xff14b8a6) : const Color(0xffef4444),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              totalValue,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff1e293b)),
            ),
          ],
        ),
      ),
    );
  }
}