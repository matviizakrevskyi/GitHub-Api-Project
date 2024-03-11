import 'package:github_api_project/domain/repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repo_response.g.dart';

@JsonSerializable()
class RepoResponse {
  final int id;
  final String name;

  RepoResponse(this.id, this.name);

  factory RepoResponse.fromJson(Map<String, dynamic> json) => _$RepoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepoResponseToJson(this);

  Repo get toDomainModel => Repo(id.toString(), name, DateTime.now().millisecondsSinceEpoch);
}
