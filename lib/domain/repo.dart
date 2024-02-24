import 'package:github_api_project/domain/hive_repo.dart';

class Repo {
  final String name;
  final bool isFavorite;

  Repo(this.name, [this.isFavorite = false]);

  RepoEntity get toEntityModel => RepoEntity(name, isFavorite);
}
