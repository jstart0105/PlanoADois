import 'package:cloud_firestore/cloud_firestore.dart';

class AlertModel {
  final String id;
  final String ativo;
  final String condicao; // "maior_que" ou "menor_que"
  final double valor;
  final String userId;

  AlertModel({
    required this.id,
    required this.ativo,
    required this.condicao,
    required this.valor,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'ativo': ativo,
      'condicao': condicao,
      'valor': valor,
      'userId': userId,
    };
  }

  factory AlertModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return AlertModel(
      id: doc.id,
      ativo: data['ativo'],
      condicao: data['condicao'],
      valor: (data['valor'] as num).toDouble(),
      userId: data['userId'],
    );
  }
}