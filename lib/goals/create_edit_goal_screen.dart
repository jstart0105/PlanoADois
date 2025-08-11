import 'package:flutter/material.dart';

class CreateEditGoalScreen extends StatefulWidget {
  const CreateEditGoalScreen({super.key});

  @override
  _CreateEditGoalScreenState createState() => _CreateEditGoalScreenState();
}

class _CreateEditGoalScreenState extends State<CreateEditGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetValueController = TextEditingController();
  DateTime? _targetDate;
  // Simulação de upload de imagem
  String? _imageUrl;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _targetDate) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Nova Meta'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Meta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome para a meta.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _targetValueController,
                decoration: const InputDecoration(
                  labelText: 'Valor Alvo (R\$)',
                  border: OutlineInputBorder(),
                  prefixText: 'R\$ ',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor alvo.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ListTile(
                title: Text(_targetDate == null
                    ? 'Selecionar Data Alvo'
                    : 'Data Alvo: ${MaterialLocalizations.of(context).formatShortDate(_targetDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(height: 24),
               // Botão de Upload de Imagem
              OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Carregar Imagem Inspiradora'),
                onPressed: () {
                  // Lógica para upload de imagem
                  setState(() {
                    _imageUrl = 'https://picsum.photos/seed/newgoal/800/600'; // URL CORRIGIDA
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(_imageUrl!, height: 150, fit: BoxFit.cover),
                  ),
                ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica para salvar a meta no Firestore
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Meta salva com sucesso!')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4f46e5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Salvar Meta', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}