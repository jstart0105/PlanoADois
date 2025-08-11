import 'package:flutter/material.dart';

class FiltersModal extends StatelessWidget {
  const FiltersModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filtrar Transações',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0f172a),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildFilterSection(context, 'Período', ['Este Mês', 'Mês Passado', 'Últimos 90 dias']),
          const SizedBox(height: 16),
          _buildFilterSection(context, 'Pessoa', ['Meus', 'Dele(a)', 'Nossos']),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4f46e5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Aplicar Filtros', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xff1e293b),
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: options
              .map(
                (option) => FilterChip(
                  label: Text(option),
                  onSelected: (selected) {},
                  backgroundColor: const Color(0xffe2e8f0),
                  selectedColor: const Color(0xff8b5cf6),
                  labelStyle: const TextStyle(color: Color(0xff1e293b)),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}