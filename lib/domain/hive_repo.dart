import 'package:github_api_project/domain/repo.dart';
import 'package:hive/hive.dart';

part 'hive_repo.g.dart';

@HiveType(typeId: 1)
class RepoEntity extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isFavorite;

  RepoEntity(this.name, this.isFavorite);

  Repo get toDomainModel => Repo(name, isFavorite);
}
