class UserModel {
  final String uid;
  final String email;
  final String nome;
  final String? partnerId;
  final String? inviteCode;

  UserModel({
    required this.uid,
    required this.email,
    required this.nome,
    this.partnerId,
    this.inviteCode,
  });

  // Converte um UserModel para um Map<String, dynamic> para o Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nome': nome,
      'partnerId': partnerId,
      'inviteCode': inviteCode,
    };
  }

  // Cria um UserModel a partir de um Map<String, dynamic> vindo do Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nome: map['nome'],
      partnerId: map['partnerId'],
      inviteCode: map['inviteCode'],
    );
  }
}