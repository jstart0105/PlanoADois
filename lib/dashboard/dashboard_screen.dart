import 'package:flutter/material.dart';
import 'package:plano_a_dois/dashboard/widgets/balance_card.dart';
import 'package:plano_a_dois/dashboard/widgets/expenses_chart.dart';
import 'package:plano_a_dois/dashboard/widgets/investments_card.dart';
import 'package:plano_a_dois/dashboard/widgets/goals_card.dart';
import 'package:plano_a_dois/models/transaction_model.dart';
import 'package:plano_a_dois/models/user_model.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/firestore_service.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isCoupleView = true;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Por favor, faça login.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isCoupleView ? 'Visão do Casal' : 'Minha Visão'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Switch(
              value: _isCoupleView,
              onChanged: (value) {
                setState(() {
                  _isCoupleView = value;
                });
              },
              activeTrackColor: const Color(0xff8b5cf6),
              activeColor: const Color(0xff4f46e5),
            ),
          )
        ],
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: FutureBuilder<UserModel?>(
        future: _firestoreService.getUser(user.uid),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnapshot.hasData) {
            return const Center(child: Text("Usuário não encontrado."));
          }

          final partnerId = userSnapshot.data?.partnerId;
          
          return StreamBuilder<List<TransactionModel>>(
            stream: _firestoreService.getTransactions(user.uid, _isCoupleView ? partnerId : null),
            builder: (context, transactionSnapshot) {
              if (transactionSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!transactionSnapshot.hasData || transactionSnapshot.data!.isEmpty) {
                // Se não houver dados, exibe os cards com valores zerados
                 return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const BalanceCard(transactions: []),
                      const SizedBox(height: 24),
                      const ExpensesChart(transactions: []),
                      const SizedBox(height: 24),
                      InvestmentsCard(isCoupleView: _isCoupleView),
                      const SizedBox(height: 24),
                      const GoalsCard(),
                    ],
                  ),
                );
              }
              
              final allTransactions = transactionSnapshot.data!;
              final transactions = _isCoupleView
                  ? allTransactions
                  : allTransactions.where((t) => t.userId == user.uid && t.owner != 'Nosso').toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BalanceCard(transactions: transactions),
                    const SizedBox(height: 24),
                    ExpensesChart(transactions: transactions),
                    const SizedBox(height: 24),
                    InvestmentsCard(isCoupleView: _isCoupleView),
                    const SizedBox(height: 24),
                    const GoalsCard(),
                  ],
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}