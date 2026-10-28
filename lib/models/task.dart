/// Modèle représentant une tâche / échéance académique dans CampusFlow.
class Task {
  final String id;
  final String titre;
  final DateTime echeance;
  final bool terminee;
  final String? description;
  final String? coursId;

  const Task({
    this.id = '',
    required this.titre,
    required this.echeance,
    this.terminee = false,
    this.description,
    this.coursId,
  });

  /// Crée une copie de cette tâche avec certains champs modifiés (immuabilité).
  Task copyWith({
    String? id,
    String? titre,
    DateTime? echeance,
    bool? terminee,
    String? description,
    String? coursId,
  }) =>
      Task(
        id: id ?? this.id,
        titre: titre ?? this.titre,
        echeance: echeance ?? this.echeance,
        terminee: terminee ?? this.terminee,
        description: description ?? this.description,
        coursId: coursId ?? this.coursId,
      );

  /// Désérialise une instance de [Task] depuis une Map JSON.
  factory Task.fromJson(Map<String, dynamic> json) {
    final titre = json['titre'];
    final echeanceRaw = json['echeance'];

    if (titre is! String || titre.trim().isEmpty) {
      throw const FormatException('Le champ "titre" est obligatoire et doit être une chaîne non vide.');
    }
    if (echeanceRaw is! String) {
      throw const FormatException('Le champ "echeance" est obligatoire et doit être une date ISO-8601.');
    }

    return Task(
      id: (json['id'] as String?) ?? '',
      titre: titre,
      echeance: DateTime.parse(echeanceRaw),
      terminee: (json['terminee'] as bool?) ?? false,
      description: json['description'] as String?,
      coursId: json['coursId'] as String?,
    );
  }

  /// Sérialise l'instance en Map JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'titre': titre,
        'echeance': echeance.toIso8601String(),
        'terminee': terminee,
        'description': description,
        'coursId': coursId,
      };

  /// Indique si la tâche est en retard par rapport à la date actuelle.
  bool get estEnRetard => !terminee && echeance.isBefore(DateTime.now());

  @override
  String toString() =>
      'Task(id: $id, titre: $titre, echeance: ${echeance.toIso8601String()}, terminee: $terminee, description: ${description ?? "Aucune"})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          titre == other.titre &&
          echeance == other.echeance &&
          terminee == other.terminee &&
          description == other.description &&
          coursId == other.coursId;

  @override
  int get hashCode => Object.hash(id, titre, echeance, terminee, description, coursId);
}

/// Retourne le résumé d'une tâche sans utiliser l'opérateur « ! » (null safety).
String resume(Task t) {
  return '${t.titre} : ${(t.description ?? 'Aucune').trim()}';
}
