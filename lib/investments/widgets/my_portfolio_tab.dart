import 'package:flutter/material.dart';
import 'package:plano_a_dois/investments/investment_details_screen.dart';
import 'package:plano_a_dois/models/investment_model.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/firestore_service.dart';
import 'package:provider/provider.dart';

class MyPortfolioTab extends StatefulWidget {
  const MyPortfolioTab({super.key});

  @override
  State<MyPortfolioTab> createState() => _MyPortfolioTabState();
}

class _MyPortfolioTabState extends State<MyPortfolioTab> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return const Center(child: Text("Faça login para ver seus investimentos."));
    }

    return StreamBuilder<List<InvestmentModel>>(
      stream: _firestoreService.getInvestments(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text("Você ainda não possui investimentos cadastrados."));
        }

        final investments = snapshot.data!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
                      // Lógica de resumo pode ser adicionada aqui
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: investments.length,
                itemBuilder: (context, index) {
                  final investment = investments[index];
                  return _buildAssetItem(
                    context,
                    investment,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAssetItem(BuildContext context, InvestmentModel investment) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xffd1fae5),
          child: Icon(
            Icons.show_chart,
            color: Color(0xff059669),
            size: 20,
          ),
        ),
        title: Text(investment.nomeAtivo,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xff1e293b))),
        subtitle: Text('Preço Médio: R\$ ${investment.precoMedio.toStringAsFixed(2)}',
            style: const TextStyle(color: Color(0xff64748b))),
        trailing: Text(
          '${investment.quantidade.toStringAsFixed(2)} Cotas',
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff1e293b)),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  InvestmentDetailsScreen(investment: investment),
            ),
          );
        },
      ),
    );
  }
}