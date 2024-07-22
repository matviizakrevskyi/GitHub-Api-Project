import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/screens/home/home_cubit.dart';
import 'package:github_api_project/usecases/get_history_stream.dart';
import 'package:github_api_project/usecases/put_delete_favorites.dart';
import 'package:github_api_project/usecases/search_repos.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchReposUseCase extends Mock implements SearchReposUseCase {}

class MockPutOrDeleteFavoriteRepoUseCase extends Mock implements PutOrDeleteFavoriteRepoUseCase {}

class MockGetHistoryStreamUseCase extends Mock implements GetHistoryStreamUseCase {}

void main() {
  group('Home Cubit', () {
    late MockSearchReposUseCase mockSearchReposUseCase;
    late MockPutOrDeleteFavoriteRepoUseCase mockPutOrDeleteFavoriteRepoUseCase;
    late MockGetHistoryStreamUseCase mockGetHistoryStreamUseCase;
    late HomeCubit homeCubit;

    setUp(() {
      mockSearchReposUseCase = MockSearchReposUseCase();
      mockPutOrDeleteFavoriteRepoUseCase = MockPutOrDeleteFavoriteRepoUseCase();
      mockGetHistoryStreamUseCase = MockGetHistoryStreamUseCase();

      when(() => mockGetHistoryStreamUseCase.execute()).thenAnswer((_) => Stream.value([]));

      homeCubit = HomeCubit(
          mockSearchReposUseCase, mockPutOrDeleteFavoriteRepoUseCase, mockGetHistoryStreamUseCase);
    });

    test('initial state is correct', () {
      expect(homeCubit.state.items, []);
      expect(homeCubit.state.isFocused, false);
      expect(homeCubit.state.isLoading, false);
      expect(homeCubit.state.isHistory, true);
    });

    blocTest<HomeCubit, HomeState>(
      'emitting test',
      build: () {
        when(() => mockGetHistoryStreamUseCase.execute())
            .thenAnswer((_) => Stream.value([Repo("id", "name", 10)]));
        return homeCubit;
      },
      act: (cubit) {
        return cubit.initializeHistoryStream();
      },
      expect: () => <HomeState>[
        HomeState([Repo("id", "name", 10)], false, false, true)
      ],
    );

    tearDown(() {
      homeCubit.close();
    });
  });
}
