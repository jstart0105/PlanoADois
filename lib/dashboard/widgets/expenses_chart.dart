import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:plano_a_dois/models/transaction_model.dart';

class ExpensesChart extends StatefulWidget {
  final List<TransactionModel> transactions;

  const ExpensesChart({super.key, required this.transactions});

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  int touchedIndex = -1;

  // Mapa de cores para as categorias para consistência
  final Map<String, Color> categoryColors = {
    'Alimentação': const Color(0xff4f46e5),
    'Transporte': const Color(0xff6366f1),
    'Moradia': const Color(0xff818cf8),
    'Lazer': const Color(0xffa5b4fc),
    'Saúde': const Color(0xffc7d2fe),
    'Educação': const Color(0xffa78bfa),
    'Outros': const Color(0xffd8b4fe),
  };

  @override
  Widget build(BuildContext context) {
    // Calcula os totais de despesas
    final Map<String, double> categoryTotals = _calculateCategoryTotals();
    final bool hasData = categoryTotals.isNotEmpty;

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
            // Gráfico
            SizedBox(
              height: 200, // Altura fixa para o gráfico
              child: hasData
                  ? PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 60, // Aumenta o espaço central
                        sections: showingSections(categoryTotals),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Sem despesas no mês.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            // Legenda
            _buildLegend(categoryTotals),
          ],
        ),
      ),
    );
  }

  // Widget que constrói a legenda de forma organizada
  Widget _buildLegend(Map<String, double> categoryTotals) {
    if (categoryTotals.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final double totalExpenses = categoryTotals.values.fold(0.0, (sum, item) => sum + item);
    int index = 0;

    return Wrap(
      spacing: 16.0, // Espaçamento horizontal entre os itens
      runSpacing: 12.0, // Espaçamento vertical entre as linhas
      children: categoryTotals.entries.map((entry) {
        final isTouched = index == touchedIndex;
        final color = categoryColors[entry.key] ?? Colors.grey;
        final percentage = (entry.value / totalExpenses) * 100;
        final currentIndex = index++; // Guarda o índice atual e incrementa para o próximo

        return IntrinsicWidth(
          child: AnimatedContainer( // Adiciona animação suave na legenda
            duration: const Duration(milliseconds: 150),
            padding: isTouched ? const EdgeInsets.all(4.0) : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: isTouched ? color.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: isTouched ? 16 : 14, // Aumenta o tamanho da fonte se tocado
                        fontWeight: isTouched ? FontWeight.bold : FontWeight.w500, // Negrito se tocado
                        color: const Color(0xff374151)),
                    ),
                    Text(
                      'R\$ ${entry.value.toStringAsFixed(2)} (${percentage.toStringAsFixed(1)}%)',
                      style: TextStyle(
                        fontSize: isTouched ? 14 : 12, // Aumenta o tamanho da fonte se tocado
                        color: const Color(0xff6b7280)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Função para calcular os totais
  Map<String, double> _calculateCategoryTotals() {
    final now = DateTime.now();
    final expenses = widget.transactions.where((t) =>
        t.valor < 0 && t.data.month == now.month && t.data.year == now.year);

    final Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals.update(expense.categoria, (value) => value + expense.valor.abs(),
          ifAbsent: () => expense.valor.abs());
    }
    return categoryTotals;
  }

  // Função que gera as seções do gráfico
  List<PieChartSectionData> showingSections(Map<String, double> categoryTotals) {
    int i = 0;
    return categoryTotals.entries.map((entry) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 65.0 : 55.0; // Aumenta o raio no toque
      final color = categoryColors[entry.key] ?? Colors.grey;
      i++;

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '', // Removemos o texto da fatia para um visual mais limpo
        radius: radius,
      );
    }).toList();
  }
}