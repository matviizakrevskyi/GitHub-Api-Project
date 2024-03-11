import 'package:github_api_project/domain/repo.dart';
import 'package:hive/hive.dart';

part 'hive_repo.g.dart';

@HiveType(typeId: 1)
class RepoEntity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int dateOfAdding;

  @HiveField(3)
  bool isFavorite;

  @HiveField(4)
  bool isFromHistory;

  RepoEntity(this.id, this.name, this.dateOfAdding, this.isFavorite, this.isFromHistory);

  Repo get toDomainModel => Repo(id, name, dateOfAdding, isFavorite, isFromHistory);

  RepoEntity update(RepoEntity item) {
    id = item.id;
    name = item.name;
    dateOfAdding = item.dateOfAdding;
    isFavorite = item.isFavorite;
    isFromHistory = item.isFromHistory;
    return this;
  }

  RepoEntity copyWith({bool? isFavorite, bool? isFromHistory}) {
    return RepoEntity(
        id, name, dateOfAdding, isFavorite ?? this.isFavorite, isFromHistory ?? this.isFromHistory);
  }
}
