import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  group('CampusFlow Models - Tests unitaires', () {
    test('1. copyWith crée une copie modifiée sans altérer l\'objet original (Task, Course, User)', () {
      // Task
      final echeance = DateTime(2026, 10, 30, 17, 0);
      final tache = Task(
        id: 't1',
        titre: 'Rendu TP Dart',
        echeance: echeance,
        terminee: false,
      );
      final tacheTerminee = tache.copyWith(
        terminee: true,
        description: 'Terminé avec tests',
      );

      expect(tache.terminee, isFalse);
      expect(tache.description, isNull);
      expect(tacheTerminee.terminee, isTrue);
      expect(tacheTerminee.titre, equals('Rendu TP Dart'));
      expect(tacheTerminee.echeance, equals(echeance));
      expect(tacheTerminee.description, equals('Terminé avec tests'));

      // Course
      const cours = Course(
        id: 'c1',
        nom: 'Programmation Mobile',
        enseignant: 'Moctar COMPAORE',
        credits: 4,
      );
      final coursModifie = cours.copyWith(salle: 'Amphi A', credits: 5);
      expect(cours.salle, isNull);
      expect(cours.credits, equals(4));
      expect(coursModifie.salle, equals('Amphi A'));
      expect(coursModifie.credits, equals(5));
      expect(coursModifie.nom, equals('Programmation Mobile'));

      // User
      const user = User(
        id: 'u1',
        nom: 'Amina',
        email: 'amina@u-auben.bf',
      );
      final userModifie = user.copyWith(niveau: 'Master 2 Informatique');
      expect(user.niveau, equals('Master 1 Informatique'));
      expect(userModifie.niveau, equals('Master 2 Informatique'));
      expect(userModifie.nom, equals('Amina'));
    });

    test('2. fromJson désérialise correctement chaque modèle et le chargement Future.delayed fonctionne', () async {
      // Task.fromJson
      final taskJson = {
        'id': 'task-1',
        'titre': 'Projet Flutter',
        'echeance': '2026-10-30T17:00:00.000',
        'terminee': false,
        'description': '  Modèles en Dart pur  ',
        'coursId': 'cours-1',
      };
      final task = Task.fromJson(taskJson);
      expect(task.id, equals('task-1'));
      expect(task.titre, equals('Projet Flutter'));
      expect(task.echeance, equals(DateTime.parse('2026-10-30T17:00:00.000')));
      expect(task.terminee, isFalse);
      expect(resume(task), equals('Projet Flutter : Modèles en Dart pur'));

      // Vérification null-safety sans « ! » quand description est null
      final taskSansDesc = task.copyWith();
      final taskNullDesc = Task(titre: taskSansDesc.titre, echeance: taskSansDesc.echeance);
      expect(resume(taskNullDesc), equals('Projet Flutter : Aucune'));

      // Course.fromJson
      final courseJson = {
        'id': 'cours-1',
        'nom': 'Programmation Mobile',
        'enseignant': 'Moctar COMPAORE',
        'credits': 4,
      };
      final course = Course.fromJson(courseJson);
      expect(course.nom, equals('Programmation Mobile'));
      expect(course.enseignant, equals('Moctar COMPAORE'));
      expect(course.credits, equals(4));

      // User.fromJson
      final userJson = {
        'id': 'user-1',
        'nom': 'Amina',
        'email': 'amina@u-auben.bf',
        'niveau': 'Master 1 Informatique',
      };
      final user = User.fromJson(userJson);
      expect(user.nom, equals('Amina'));
      expect(user.email, equals('amina@u-auben.bf'));

      // Chargement simulé avec Future.delayed
      const repo = SimulatedTaskRepository(delai: Duration(milliseconds: 50));
      final tachesChargees = await repo.chargerTaches();
      expect(tachesChargees, hasLength(3));
      expect(tachesChargees.first.titre, equals('Rendu TP Dart'));
    });

    test('3. erreur attendue : levée d\'exception lors d\'un chargement en échec ou JSON invalide', () async {
      const repo = SimulatedTaskRepository(delai: Duration(milliseconds: 50));

      // Erreur asynchrone attendue sur Future.delayed
      await expectLater(
        repo.chargerTaches(simulerErreur: true),
        throwsA(isA<CampusFlowException>()),
      );

      // Erreur de format attendue sur JSON invalide
      expect(
        () => Task.fromJson({'titre': '', 'echeance': 'date-invalide'}),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => Course.fromJson({'nom': 'Mobile'}), // enseignant manquant
        throwsA(isA<FormatException>()),
      );
      expect(
        () => User.fromJson({'nom': 'Amina', 'email': 'email_invalide'}),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
