import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plano_a_dois/models/transaction_model.dart';
import 'package:plano_a_dois/models/user_model.dart';
import 'package:plano_a_dois/services/auth_service.dart';
import 'package:plano_a_dois/services/firestore_service.dart';
import 'package:plano_a_dois/transactions/add_edit_transaction_screen.dart';
import 'package:plano_a_dois/transactions/transaction_details_screen.dart';
import 'package:plano_a_dois/transactions/widgets/transaction_list_item.dart';
import 'package:plano_a_dois/transactions/widgets/filters_modal.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String? _ownerFilter;
  String? _periodFilter;

  void _navigateToAddTransaction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddEditTransactionScreen()),
    );
  }

  void _navigateToDetail(TransactionModel transaction) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TransactionDetailScreen(transaction: transaction)),
    );
  }

  void _applyFilters(String? owner, String? period) {
    setState(() {
      _ownerFilter = owner;
      _periodFilter = period;
    });
  }

  // NOVA FUNÇÃO para limpar filtros diretamente da tela
  void _clearFilters() {
    setState(() {
      _ownerFilter = null;
      _periodFilter = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;
    final bool isFilterActive = _ownerFilter != null || _periodFilter != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extrato e Transações'),
        backgroundColor: const Color(0xfff1f5f9),
        actions: [
          if (isFilterActive)
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Limpar Filtros',
              onPressed: _clearFilters,
            ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filtrar',
            onPressed: () async {
              final result = await showModalBottomSheet<Map<String, String?>>(
                context: context,
                isScrollControlled: true,
                builder: (context) => FiltersModal(
                  initialOwner: _ownerFilter,
                  initialPeriod: _periodFilter,
                ),
              );

              if (result != null) {
                _applyFilters(result['owner'], result['period']);
              }
            },
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text("Faça login para ver suas transações."))
          : StreamBuilder<List<TransactionModel>>(
              stream: _firestoreService.getUser(user.uid).asStream().asyncExpand((UserModel? userModel) {
                  return _firestoreService.getTransactions(user.uid, userModel?.partnerId);
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma transação encontrada.'),
                  );
                }

                List<TransactionModel> transactions = snapshot.data!;
                
                if (_ownerFilter != null && _ownerFilter != 'Todos') {
                    transactions = transactions.where((t) => t.owner == _ownerFilter).toList();
                }

                if (_periodFilter != null) {
                    final now = DateTime.now();
                    if (_periodFilter == 'Este Mês') {
                        transactions = transactions.where((t) => t.data.month == now.month && t.data.year == now.year).toList();
                    } else if (_periodFilter == 'Mês Passado') {
                        final lastMonth = DateTime(now.year, now.month - 1, 1);
                        transactions = transactions.where((t) => t.data.month == lastMonth.month && t.data.year == lastMonth.year).toList();
                    }
                }

                // MOSTRA MENSAGEM SE FILTRO NÃO TIVER RESULTADOS
                if (transactions.isEmpty) {
                    return const Center(
                        child: Text(
                            'Nenhuma transação encontrada para os filtros selecionados.',
                            textAlign: TextAlign.center,
                        ),
                    );
                }
                
                transactions.sort((a, b) => b.data.compareTo(a.data));

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return TransactionListItem(
                      category: transaction.categoria,
                      description: transaction.descricao,
                      value: transaction.valor,
                      owner: transaction.owner,
                      date: DateFormat('dd/MM/yyyy').format(transaction.data),
                      onTap: () => _navigateToDetail(transaction),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTransaction,
        backgroundColor: const Color(0xff4f46e5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}