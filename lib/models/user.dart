/// Modèle représentant un utilisateur (étudiant) dans CampusFlow.
class User {
  final String id;
  final String nom;
  final String email;
  final String niveau;
  final String? telephone;

  const User({
    this.id = '',
    required this.nom,
    required this.email,
    this.niveau = 'Master 1 Informatique',
    this.telephone,
  });

  /// Crée une copie de cet utilisateur avec certains champs modifiés (immuabilité).
  User copyWith({
    String? id,
    String? nom,
    String? email,
    String? niveau,
    String? telephone,
  }) =>
      User(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        email: email ?? this.email,
        niveau: niveau ?? this.niveau,
        telephone: telephone ?? this.telephone,
      );

  /// Désérialise une instance de [User] depuis une Map JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    final nom = json['nom'];
    final email = json['email'];

    if (nom is! String || nom.trim().isEmpty) {
      throw const FormatException('Le champ "nom" de l\'utilisateur est obligatoire.');
    }
    if (email is! String || !email.contains('@')) {
      throw const FormatException('Le champ "email" est obligatoire et doit être valide.');
    }

    return User(
      id: (json['id'] as String?) ?? '',
      nom: nom,
      email: email,
      niveau: (json['niveau'] as String?) ?? 'Master 1 Informatique',
      telephone: json['telephone'] as String?,
    );
  }

  /// Sérialise l'instance en Map JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'email': email,
        'niveau': niveau,
        'telephone': telephone,
      };

  @override
  String toString() =>
      'User(id: $id, nom: $nom, email: $email, niveau: $niveau)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nom == other.nom &&
          email == other.email &&
          niveau == other.niveau &&
          telephone == other.telephone;

  @override
  int get hashCode => Object.hash(id, nom, email, niveau, telephone);
}
