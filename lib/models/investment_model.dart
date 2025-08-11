import 'package:cloud_firestore/cloud_firestore.dart';

class InvestmentModel {
  final String id;
  final String nomeAtivo;
  final double quantidade;
  final double precoMedio;
  final String userId;

  InvestmentModel({
    required this.id,
    required this.nomeAtivo,
    required this.quantidade,
    required this.precoMedio,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomeAtivo': nomeAtivo,
      'quantidade': quantidade,
      'precoMedio': precoMedio,
      'userId': userId,
    };
  }

  factory InvestmentModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return InvestmentModel(
      id: doc.id,
      nomeAtivo: data['nomeAtivo'],
      quantidade: (data['quantidade'] as num).toDouble(),
      precoMedio: (data['precoMedio'] as num).toDouble(),
      userId: data['userId'],
    );
  }
}