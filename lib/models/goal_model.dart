import 'package:cloud_firestore/cloud_firestore.dart';

class GoalModel {
  final String id;
  final String nome;
  final double valorAlvo;
  final double valorAtual;
  final String? imageUrl;

  GoalModel({
    required this.id,
    required this.nome,
    required this.valorAlvo,
    this.valorAtual = 0.0,
    this.imageUrl,
  });

   Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'valorAlvo': valorAlvo,
      'valorAtual': valorAtual,
      'imageUrl': imageUrl,
    };
  }

  factory GoalModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return GoalModel(
      id: doc.id,
      nome: data['nome'],
      valorAlvo: (data['valorAlvo'] as num).toDouble(),
      valorAtual: (data['valorAtual'] as num).toDouble(),
      imageUrl: data['imageUrl'],
    );
  }
}