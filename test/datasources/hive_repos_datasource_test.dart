import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/domain/hive_constants.dart';
import 'package:github_api_project/domain/hive_repo.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  group("Hive repo", () {
    late Box<RepoEntity> reposBox;
    late HiveReposDatasource datasource;

    setUp(() async {
      await setUpTestHive();
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(RepoEntityAdapter());
      }
      reposBox = await Hive.openBox<RepoEntity>(reposBoxKey);
      datasource = HiveReposDatasource(reposBox);
    });

    tearDown(() async {
      await tearDownTestHive();
    });

    test('saving repo', () async {
      //arrange
      final repos = [Repo('1', 'name_1', 1000000), Repo('2', 'name_2', 2000000)];

      //act
      await datasource.saveRepos(repos);

      //assert
      final savedRepos = reposBox.values.toList();
      expect(savedRepos.length, repos.length);
      expect(savedRepos[0].name, repos[0].name);
      expect(savedRepos[1].dateOfAdding, repos[1].dateOfAdding);
    });

    test('clearing no liked repos', () async {
      //arrange
      final repos = [Repo('1', 'name_1', 1000000, true), Repo('2', 'name_2', 2000000)];
      await datasource.saveRepos(repos);

      //act
      datasource.clearNotLiked();

      //assert
      final savedRepos = reposBox.values.toList();
      expect(savedRepos.length, 1);
      expect(savedRepos[0].name, repos[0].name);
    });

    //here must be another tests
    //

    test('favoritesStream testing', () async {
      //arrange
      final repo1 = Repo('1', 'name_1', 1000000, true);
      final repo2 = Repo('2', 'name_2', 2000000, false);
      reposBox.put(repo1.id, repo1.toEntityModel);
      reposBox.put(repo2.id, repo2.toEntityModel);
      final repo3 = Repo('3', 'name_3', 3000000, true);

      //act 1
      final favoriteReposStream = datasource.favoritesStream;
      final List<List<Repo>> streamValues = [];
      final subscriprion = favoriteReposStream.listen((event) {
        streamValues.add(event);
      });
      await Future.delayed(const Duration(milliseconds: 600));

      //assert 1
      expect(streamValues.length, equals(1));
      expect(streamValues[0].length, equals(1));
      expect(streamValues[0][0].id, equals('1'));

      //act 2
      reposBox.put(repo3.id, repo3.toEntityModel);
      await Future.delayed(const Duration(milliseconds: 600));

      //assert 2
      expect(streamValues.length, equals(2));
      expect(streamValues[1].length, equals(2));
      expect(streamValues[1].any((element) => element.id == "3"), isTrue);

      //act 3
      final updatedRepo2 = repo2.copyWith(isFavorite: true);
      reposBox.put(repo2.id, updatedRepo2.toEntityModel);
      await Future.delayed(const Duration(milliseconds: 600));

      //assert 3
      expect(streamValues.length, equals(3));
      expect(streamValues[2].length, equals(3));
      expect(streamValues[2].any((element) => element.id == "2"), isTrue);

      await subscriprion.cancel();
    });
  });
}
