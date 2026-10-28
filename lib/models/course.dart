/// Modèle représentant un cours universitaire dans CampusFlow.
class Course {
  final String id;
  final String nom;
  final String enseignant;
  final int credits;
  final String? salle;

  const Course({
    this.id = '',
    required this.nom,
    required this.enseignant,
    this.credits = 3,
    this.salle,
  });

  /// Crée une copie de ce cours avec certains champs modifiés (immuabilité).
  Course copyWith({
    String? id,
    String? nom,
    String? enseignant,
    int? credits,
    String? salle,
  }) =>
      Course(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        enseignant: enseignant ?? this.enseignant,
        credits: credits ?? this.credits,
        salle: salle ?? this.salle,
      );

  /// Désérialise une instance de [Course] depuis une Map JSON.
  factory Course.fromJson(Map<String, dynamic> json) {
    final nom = json['nom'];
    final enseignant = json['enseignant'];

    if (nom is! String || nom.trim().isEmpty) {
      throw const FormatException('Le champ "nom" du cours est obligatoire.');
    }
    if (enseignant is! String || enseignant.trim().isEmpty) {
      throw const FormatException('Le champ "enseignant" du cours est obligatoire.');
    }

    return Course(
      id: (json['id'] as String?) ?? '',
      nom: nom,
      enseignant: enseignant,
      credits: (json['credits'] as int?) ?? 3,
      salle: json['salle'] as String?,
    );
  }

  /// Sérialise l'instance en Map JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'enseignant': enseignant,
        'credits': credits,
        'salle': salle,
      };

  @override
  String toString() =>
      'Course(id: $id, nom: $nom, enseignant: $enseignant, credits: $credits, salle: ${salle ?? "Non spécifiée"})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nom == other.nom &&
          enseignant == other.enseignant &&
          credits == other.credits &&
          salle == other.salle;

  @override
  int get hashCode => Object.hash(id, nom, enseignant, credits, salle);
}
