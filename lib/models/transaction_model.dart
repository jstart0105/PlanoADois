import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final double valor;
  final String descricao;
  final DateTime data;
  final String categoria;
  final String userId;
  final bool isCoupleTransaction;

  TransactionModel({
    required this.id,
    required this.valor,
    required this.descricao,
    required this.data,
    required this.categoria,
    required this.userId,
    required this.isCoupleTransaction,
  });

  Map<String, dynamic> toMap() {
    return {
      'valor': valor,
      'descricao': descricao,
      'data': Timestamp.fromDate(data),
      'categoria': categoria,
      'userId': userId,
      'isCoupleTransaction': isCoupleTransaction,
    };
  }

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      valor: (data['valor'] as num).toDouble(),
      descricao: data['descricao'],
      data: (data['data'] as Timestamp).toDate(),
      categoria: data['categoria'],
      userId: data['userId'],
      isCoupleTransaction: data['isCoupleTransaction'],
    );
  }
}