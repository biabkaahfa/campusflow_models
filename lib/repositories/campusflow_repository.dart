import '../models/course.dart';
import '../models/task.dart';
import '../models/user.dart';

/// Exception personnalisée pour simuler une erreur réseau ou serveur.
class CampusFlowException implements Exception {
  final String message;
  const CampusFlowException(this.message);

  @override
  String toString() => 'CampusFlowException: $message';
}

/// Contrat (interface) du dépôt de données CampusFlow.
abstract class TaskRepository {
  Future<List<Task>> chargerTaches({bool simulerErreur = false});
  Future<List<Course>> chargerCours({bool simulerErreur = false});
  Future<User> chargerUtilisateur({bool simulerErreur = false});
}

/// Implémentation simulée du dépôt avec [Future.delayed] et données JSON.
class SimulatedTaskRepository implements TaskRepository {
  final Duration delai;

  const SimulatedTaskRepository({
    this.delai = const Duration(milliseconds: 300),
  });

  static const List<Map<String, dynamic>> _tachesJsonSimulees = [
    {
      'id': 'task-1',
      'titre': 'Rendu TP Dart',
      'echeance': '2026-10-29T17:00:00.000',
      'terminee': false,
      'description': 'Créer les modèles Task, Course, User avec copyWith et fromJson',
      'coursId': 'cours-1',
    },
    {
      'id': 'task-2',
      'titre': 'Projet Flutter',
      'echeance': '2026-10-30T17:00:00.000',
      'terminee': false,
      'description': 'Implémenter les écrans Échéances et Détail',
      'coursId': 'cours-1',
    },
    {
      'id': 'task-3',
      'titre': 'Examen UX',
      'echeance': '2026-11-02T10:00:00.000',
      'terminee': false,
      'description': null,
      'coursId': 'cours-2',
    },
  ];

  static const List<Map<String, dynamic>> _coursJsonSimules = [
    {
      'id': 'cours-1',
      'nom': 'Programmation Mobile',
      'enseignant': 'Moctar COMPAORE',
      'credits': 4,
      'salle': 'Salle Master 1',
    },
    {
      'id': 'cours-2',
      'nom': 'Conception UX/UI',
      'enseignant': 'Moctar COMPAORE',
      'credits': 3,
      'salle': 'Labo Info 2',
    },
  ];

  static const Map<String, dynamic> _utilisateurJsonSimule = {
    'id': 'user-1',
    'nom': 'Amina',
    'email': 'amina@u-auben.bf',
    'niveau': 'Master 1 Informatique',
  };

  @override
  Future<List<Task>> chargerTaches({bool simulerErreur = false}) async {
    await Future.delayed(delai);
    if (simulerErreur) {
      throw const CampusFlowException('Échec du chargement des tâches : réseau indisponible.');
    }
    return _tachesJsonSimulees.map(Task.fromJson).toList();
  }

  @override
  Future<List<Course>> chargerCours({bool simulerErreur = false}) async {
    await Future.delayed(delai);
    if (simulerErreur) {
      throw const CampusFlowException('Échec du chargement des cours : réseau indisponible.');
    }
    return _coursJsonSimules.map(Course.fromJson).toList();
  }

  @override
  Future<User> chargerUtilisateur({bool simulerErreur = false}) async {
    await Future.delayed(delai);
    if (simulerErreur) {
      throw const CampusFlowException('Échec du chargement du profil utilisateur.');
    }
    return User.fromJson(_utilisateurJsonSimule);
  }
}
