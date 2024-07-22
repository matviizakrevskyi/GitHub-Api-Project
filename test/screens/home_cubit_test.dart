import 'dart:async';

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
    const String searchText = "search text";
    final Repo defaultRepo = Repo("id", "name", 10);

    setUp(() {
      mockSearchReposUseCase = MockSearchReposUseCase();
      mockPutOrDeleteFavoriteRepoUseCase = MockPutOrDeleteFavoriteRepoUseCase();
      mockGetHistoryStreamUseCase = MockGetHistoryStreamUseCase();

      when(() => mockGetHistoryStreamUseCase.execute()).thenAnswer((_) => Stream.value([]));

      homeCubit = HomeCubit(
          mockSearchReposUseCase, mockPutOrDeleteFavoriteRepoUseCase, mockGetHistoryStreamUseCase);
    });

    test('initial state is correct', () {
      expect(homeCubit.state, const HomeState([], false, false, true));
    });

    blocTest<HomeCubit, HomeState>(
      'initializing stream',
      build: () {
        when(() => mockGetHistoryStreamUseCase.execute())
            .thenAnswer((_) => Stream.value([defaultRepo]));
        return homeCubit;
      },
      act: (cubit) {
        return cubit.initializeHistoryStream();
      },
      expect: () => <HomeState>[
        HomeState([defaultRepo], false, false, true)
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'seach method testing',
      build: () {
        final fakeStreamController = StreamController<List<Repo>>();
        final fakeStream = fakeStreamController.stream;
        when(() => mockGetHistoryStreamUseCase.execute()).thenAnswer((_) => fakeStream);
        when(() => mockSearchReposUseCase.execute(searchText)).thenAnswer((_) async {
          return fakeStreamController.add([defaultRepo]);
        });
        return homeCubit;
      },
      act: (cubit) {
        cubit.initializeHistoryStream();
        cubit.textController.text = searchText;
        cubit.search();
      },
      expect: () => [
        const HomeState([], false, true, true),
        HomeState([defaultRepo], false, true, true),
        HomeState([defaultRepo], false, false, false)
      ],
    );

    blocTest(
      'onFavorite method testing',
      build: () {
        return homeCubit;
      },
      act: (cubit) {
        cubit.onFavorite(defaultRepo);
      },
      verify: (_) {
        verify(() => mockPutOrDeleteFavoriteRepoUseCase.execute(defaultRepo, [])).called(1);
      },
    );

    blocTest(
      'changeFocus testing',
      build: () {
        return homeCubit;
      },
      act: (cubit) {
        cubit.changeFocus(true);
      },
      expect: () => [const HomeState([], true, false, true)],
    );

    tearDown(() {
      homeCubit.close();
    });
  });
}
