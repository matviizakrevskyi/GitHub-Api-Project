import 'package:equatable/equatable.dart';
import 'package:github_api_project/domain/hive_repo.dart';

class Repo extends Equatable {
  final String id;
  final String name;
  final int dateOfAdding;
  final bool isFavorite;
  final bool isFromHistory;

  Repo(this.id, this.name, this.dateOfAdding, [this.isFavorite = false, this.isFromHistory = true]);

  RepoEntity get toEntityModel => RepoEntity(id, name, dateOfAdding, isFavorite, isFromHistory);

  Repo copyWith({bool? isFavorite, bool? isFromHistory}) => Repo(
      id, name, dateOfAdding, isFavorite ?? this.isFavorite, isFromHistory ?? this.isFromHistory);

  @override
  List<Object?> get props => [id, name, dateOfAdding, isFavorite, isFromHistory];
}
