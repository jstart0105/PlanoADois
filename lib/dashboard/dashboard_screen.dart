import 'package:flutter/material.dart';
import 'package:plano_a_dois/dashboard/widgets/balance_card.dart';
import 'package:plano_a_dois/dashboard/widgets/expenses_chart.dart';
import 'package:plano_a_dois/dashboard/widgets/investments_card.dart';
import 'package:plano_a_dois/dashboard/widgets/goals_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isCoupleView = true;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BalanceCard(isCoupleView: _isCoupleView),
            const SizedBox(height: 24),
            ExpensesChart(isCoupleView: _isCoupleView),
            const SizedBox(height: 24),
            InvestmentsCard(isCoupleView: _isCoupleView),
            const SizedBox(height: 24),
            const GoalsCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar Receita ou Despesa
        },
        backgroundColor: const Color(0xff4f46e5),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}