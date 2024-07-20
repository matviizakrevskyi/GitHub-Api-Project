import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_project/domain/repo.dart';

void main() {
  group('repo', () {
    test('creating repo', () {
      //arrange
      const id = "1";
      const name = "name";
      const dateOfAdding = 1721489163;
      const isFavourite = false;
      const isFromHistory = true;

      //act
      final repo = Repo(id, name, dateOfAdding, isFavourite, isFromHistory);

      //assert
      expect(repo.id, id);
      expect(repo.name, name);
      expect(repo.dateOfAdding, dateOfAdding);
      expect(repo.isFavorite, isFavourite);
      expect(repo.isFromHistory, isFromHistory);
    });

    test('toEntityModel method', () {
      //arrange
      final repo = Repo("1", "name", 1721489163);

      //act
      final entity = repo.toEntityModel;

      //assert
      expect(entity.id, repo.id);
      expect(entity.name, repo.name);
      expect(entity.dateOfAdding, repo.dateOfAdding);
      expect(entity.isFavorite, repo.isFavorite);
      expect(entity.isFromHistory, repo.isFromHistory);
    });

    test('copyWith method', () {
      //arrange
      final repo = Repo("1", "name", 1721489163);

      //act
      final newRepo = repo.copyWith();

      //assert
      expect(newRepo.id, repo.id);
      expect(newRepo.name, repo.name);
      expect(newRepo.dateOfAdding, repo.dateOfAdding);
      expect(newRepo.isFavorite, repo.isFavorite);
      expect(newRepo.isFromHistory, repo.isFromHistory);
    });

    test('copyWith method should not mutate original object', () {
      //arrange
      final repo = Repo("1", "name", 1721489163, false);

      //act
      final newRepo = repo.copyWith(isFavorite: true);

      //assert
      expect(repo.isFavorite, false);
      expect(newRepo.isFavorite, true);
    });
  });
}
