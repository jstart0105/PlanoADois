import 'package:flutter/material.dart';

class FiltersModal extends StatefulWidget {
  final String? initialOwner;
  final String? initialPeriod;

  const FiltersModal({super.key, this.initialOwner, this.initialPeriod});

  @override
  State<FiltersModal> createState() => _FiltersModalState();
}

class _FiltersModalState extends State<FiltersModal> {
  String? _selectedOwner;
  String? _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _selectedOwner = widget.initialOwner;
    _selectedPeriod = widget.initialPeriod;
  }

  void _onApplyFilters() {
    Navigator.of(context).pop({
      'owner': _selectedOwner,
      'period': _selectedPeriod,
    });
  }

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
          _buildFilterSection(
            context,
            'Período',
            ['Este Mês', 'Mês Passado'],
            _selectedPeriod,
            (newValue) {
              setState(() {
                _selectedPeriod = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildFilterSection(
            context,
            'Pessoa',
            ['Todos', 'Meu', 'Dele(a)', 'Nosso'],
            _selectedOwner,
            (newValue) {
              setState(() {
                _selectedOwner = newValue;
              });
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onApplyFilters,
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

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    List<String> options,
    String? currentSelection,
    Function(String?) onSelected,
  ) {
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
                  selected: currentSelection == option,
                  onSelected: (selected) {
                    if (selected) {
                      onSelected(option);
                    } else {
                      // Permite desmarcar
                      onSelected(null);
                    }
                  },
                  backgroundColor: const Color(0xfff1f5f9),
                  selectedColor: const Color(0xffc7d2fe),
                  labelStyle: const TextStyle(color: Color(0xff1e293b)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: currentSelection == option ? const Color(0xff4f46e5) : const Color(0xffcbd5e1),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}