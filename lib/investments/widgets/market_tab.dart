import 'package:flutter/material.dart';

class MarketTab extends StatelessWidget {
  const MarketTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar ativo (ex: PETR4)',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xffe2e8f0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xffe2e8f0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xff4f46e5)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildMarketIndexItem(context, 'Ibovespa', '120.516,34 pts', '+1,23%'),
                _buildMarketIndexItem(context, 'Dólar', 'R\$ 4,98', '-0,50%'),
                _buildMarketIndexItem(context, 'IFIX', '2.850,12 pts', '+0,15%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndexItem(BuildContext context, String title, String value, String variation) {
    final isPositive = !variation.startsWith('-');
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff1e293b))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff1e293b)),
            ),
            const SizedBox(width: 16),
            Text(
              variation,
              style: TextStyle(
                color: isPositive ? const Color(0xff14b8a6) : const Color(0xffef4444),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}