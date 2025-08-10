import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensesChart extends StatelessWidget {
  final bool isCoupleView;

  const ExpensesChart({super.key, required this.isCoupleView});

  @override
  Widget build(BuildContext context) {
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
              'Despesas por Categoria',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0f172a)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                    sections: _getChartSections(),
                    centerSpaceRadius: 40,
                    sectionsSpace: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getChartSections() {
    return [
      PieChartSectionData(
          color: const Color(0xff4f46e5), value: 30, title: '30%', radius: 50),
      PieChartSectionData(
          color: const Color(0xff6366f1), value: 40, title: '40%', radius: 50),
      PieChartSectionData(
          color: const Color(0xff818cf8), value: 15, title: '15%', radius: 50),
      PieChartSectionData(
          color: const Color(0xffa5b4fc), value: 15, title: '15%', radius: 50),
    ];
  }
}