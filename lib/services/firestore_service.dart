import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../models/goal_model.dart';
import '../models/investment_model.dart';
import '../models/alert_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Operações com Usuários ---
  Future<void> createUser(UserModel user) {
    return _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  // NOVO: Encontra um usuário pelo seu código de convite
  Future<UserModel?> getUserByInviteCode(String code) async {
    final querySnapshot = await _db
        .collection('users')
        .where('inviteCode', isEqualTo: code)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return UserModel.fromMap(querySnapshot.docs.first.data());
    }
    return null;
  }

  // NOVO: Vincula as contas dos dois usuários
  Future<void> linkPartners(String userIdA, String userIdB) async {
    await _db.collection('users').doc(userIdA).update({'partnerId': userIdB});
    await _db.collection('users').doc(userIdB).update({'partnerId': userIdA});
  }


  // --- Operações com Transações ---
  Future<void> addTransaction(TransactionModel transaction) {
    return _db.collection('transactions').add(transaction.toMap());
  }

  Stream<List<TransactionModel>> getTransactions(String userId, String? partnerId) {
    // Busca transações do usuário e, se houver parceiro, as transações dele e as do casal.
    var query = _db.collection('transactions').where('userId', whereIn: [userId, partnerId, '${userId}_${partnerId}']);

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList());
  }

  // --- Operações com Metas ---
  Future<void> addGoal(GoalModel goal) {
    return _db.collection('goals').add(goal.toMap());
  }

  Stream<List<GoalModel>> getGoals() {
    return _db.collection('goals').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => GoalModel.fromFirestore(doc)).toList());
  }

   // --- Operações com Investimentos ---
  Future<void> addInvestment(InvestmentModel investment) {
    return _db.collection('investments').add(investment.toMap());
  }

  Stream<List<InvestmentModel>> getInvestments(String userId) {
     return _db.collection('investments').where('userId', isEqualTo: userId).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => InvestmentModel.fromFirestore(doc)).toList());
  }

  // --- Operações com Alertas ---
   Future<void> addAlert(AlertModel alert) {
    return _db.collection('alerts').add(alert.toMap());
  }

   Stream<List<AlertModel>> getAlerts(String userId) {
     return _db.collection('alerts').where('userId', isEqualTo: userId).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => AlertModel.fromFirestore(doc)).toList());
  }

}