import 'package:campusflow_models/campusflow_models.dart';

Future<void> main() async {
  print('=== CampusFlow Models (Dart pur) ===\n');

  final repo = const SimulatedTaskRepository(
    delai: Duration(milliseconds: 500),
  );

  // 1. Chargement asynchrone simulé (succès)
  try {
    final user = await repo.chargerUtilisateur();
    final cours = await repo.chargerCours();
    final taches = await repo.chargerTaches();

    print('Utilisateur connecté : ${user.nom} (${user.niveau}) - ${user.email}');
    print('Cours inscrits (${cours.length}) : ${cours.map((c) => c.nom).join(', ')}\n');

    print('Liste des tâches (${taches.length}) :');
    for (final t in taches) {
      print(' - ${resume(t)} [Terminée : ${t.terminee}]');
    }

    // 2. Démonstration de copyWith (immuabilité)
    final premiereTache = taches.first;
    final tacheTerminee = premiereTache.copyWith(terminee: true);
    print('\nAprès copyWith(terminee: true) :');
    print(' - Originale : ${premiereTache.titre} -> terminee = ${premiereTache.terminee}');
    print(' - Copie     : ${tacheTerminee.titre} -> terminee = ${tacheTerminee.terminee}');
  } catch (e) {
    print('Erreur : $e');
  } finally {
    print('\nFin du premier chargement.\n');
  }

  // 3. Démonstration de gestion d'erreur asynchrone avec try/catch/finally
  print('Simulation d\'une erreur réseau...');
  try {
    await repo.chargerTaches(simulerErreur: true);
  } catch (e) {
    print('Erreur interceptée proprement : $e');
  } finally {
    print('Fin de la démonstration.');
  }
}
