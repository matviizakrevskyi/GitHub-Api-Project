import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/usecases/get_favorites_stream.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveReposDataSource extends Mock implements HiveReposDatasource {}

void main() {
  group("getFavoritesStream UseCase", () {
    late MockHiveReposDataSource mockDataSource;
    late GetFavoritesStreamUseCase useCase;

    setUp(() {
      mockDataSource = MockHiveReposDataSource();
      useCase = GetFavoritesStreamUseCase(mockDataSource);
    });

    test('should return the same stream as from HiveReposDatasource', () {
      // Arrange
      final repo = Repo('1', 'Repo 1', 20230720, true, true);
      final repoStream = Stream.value([repo]);

      when(() => mockDataSource.favoritesStream).thenAnswer((_) => repoStream);

      // Act
      final result = useCase.execute();

      // Assert
      expect(result, emitsInOrder([[repo]]));
      verify(() => mockDataSource.favoritesStream).called(1);
    });
  });
}