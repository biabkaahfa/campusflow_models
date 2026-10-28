# campusflow_models

Modèles de données en **Dart pur** pour l'application **CampusFlow** (Master 1 Informatique — Programmation Mobile, U-AUBEN).

## Contenu du projet

1. **Projet Dart & Git** (`campusflow_models`)
2. **Trois modèles immuables** (`lib/models/`) :
   - `Task` : attributs `final`, constructeur `const`, `copyWith`, `fromJson` / `toJson`, et fonction `resume(Task t)` garantie sans opérateur `!` (null safety).
   - `Course` : attributs `final`, constructeur `const`, `copyWith`, `fromJson` / `toJson`.
   - `User` : attributs `final`, constructeur `const`, `copyWith`, `fromJson` / `toJson`.
3. **JSON et Future** (`lib/repositories/campusflow_repository.dart`) :
   - Interface `TaskRepository` et implémentation `SimulatedTaskRepository` utilisant `Future.delayed` pour simuler le chargement asynchrone et les erreurs réseau.
4. **Tests unitaires** (`test/campusflow_models_test.dart`) :
   - Test `copyWith` (immuabilité des 3 modèles)
   - Test `fromJson` + chargement simulé avec `Future.delayed`
   - Test d'erreur attendue (`CampusFlowException` et `FormatException`)

## Commandes utiles

```bash
# Exécuter la démonstration en console
dart run

# Lancer les tests unitaires
dart test

# Vérifier l'analyse statique du code
dart analyze
```
