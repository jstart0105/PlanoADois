import 'package:flutter/material.dart';
import 'package:plano_a_dois/investments/widgets/market_tab.dart';
import 'package:plano_a_dois/investments/widgets/my_portfolio_tab.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Investimentos'),
          backgroundColor: const Color(0xfff1f5f9),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Minha Carteira'),
              Tab(text: 'Mercado'),
            ],
            indicatorColor: Color(0xff4f46e5),
            labelColor: Color(0xff4f46e5),
            unselectedLabelColor: Color(0xff64748b),
          ),
        ),
        body: const TabBarView(
          children: [
            MyPortfolioTab(),
            MarketTab(),
          ],
        ),
        backgroundColor: const Color(0xfff1f5f9),
      ),
    );
  }
}