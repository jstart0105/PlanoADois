import 'package:flutter/material.dart';
import 'package:plano_a_dois/investments/widgets/asset_card.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/firestore_service.dart';
import 'package:plano_a_dois/models/investment_model.dart';
import 'package:provider/provider.dart';

class AddInvestmentScreen extends StatefulWidget {
  const AddInvestmentScreen({super.key});

  @override
  _AddInvestmentScreenState createState() => _AddInvestmentScreenState();
}

class _AddInvestmentScreenState extends State<AddInvestmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _assetNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _averagePriceController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;

  void _saveInvestment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUser = authService.currentUser;

      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Usuário não autenticado.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final newInvestment = InvestmentModel(
        id: '', // O Firestore irá gerar
        nomeAtivo: _assetNameController.text.trim().toUpperCase(),
        quantidade: double.parse(_quantityController.text.trim()),
        precoMedio: double.parse(_averagePriceController.text.trim()),
        userId: currentUser.uid,
      );

      try {
        await _firestoreService.addInvestment(newInvestment);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Investimento salvo com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao salvar o investimento: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showAddInvestmentForm(String assetType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Adicionar $assetType',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _assetNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Ativo (ex: PETR4)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantidade',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _averagePriceController,
                  decoration: const InputDecoration(
                    labelText: 'Preço Médio de Compra (R\$)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 32),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _saveInvestment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4f46e5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Salvar Investimento',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Investimento'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AssetCard(
              assetType: 'Ações',
              description: 'Negocie ações de empresas listadas na bolsa.',
              icon: Icons.show_chart,
              onTap: () => _showAddInvestmentForm('Ação'),
            ),
            const SizedBox(height: 16),
            AssetCard(
              assetType: 'Tesouro Direto',
              description:
                  'Invista em títulos públicos com segurança e boa rentabilidade.',
              icon: Icons.account_balance,
              onTap: () => _showAddInvestmentForm('Título do Tesouro'),
            ),
            const SizedBox(height: 16),
            AssetCard(
              assetType: 'Fundos Imobiliários',
              description:
                  'Receba aluguéis de grandes empreendimentos imobiliários.',
              icon: Icons.house,
              onTap: () => _showAddInvestmentForm('Fundo Imobiliário'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}