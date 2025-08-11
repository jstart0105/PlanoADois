import 'package:flutter/material.dart';
import 'package:plano_a_dois/transactions/widgets/transaction_list_item.dart';
import 'package:plano_a_dois/transactions/widgets/filters_modal.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extrato e Transações'),
        backgroundColor: const Color(0xfff1f5f9), // slate-100
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const FiltersModal(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          TransactionListItem(
            category: 'Alimentação',
            description: 'Supermercado',
            value: -250.00,
            owner: 'couple', // 'me', 'partner', 'couple'
            date: '10/08/2025',
          ),
          TransactionListItem(
            category: 'Salário',
            description: 'Adiantamento',
            value: 2000.00,
            owner: 'me',
            date: '05/08/2025',
          ),
          TransactionListItem(
            category: 'Lazer',
            description: 'Cinema',
            value: -80.00,
            owner: 'partner',
            date: '03/08/2025',
          ),
        ],
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}