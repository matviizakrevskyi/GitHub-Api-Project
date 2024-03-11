import 'package:dio/dio.dart';
import 'package:github_api_project/domain/repo_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GithubApi {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.github.com';

  Future<List<RepoResponse>> fetchRepositories(String searchText) async {
    try {
      final response = await _dio.get(
        '$baseUrl/search/repositories',
        queryParameters: {
          'q': searchText,
          'per_page': 15, // Limit to 15 items
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> items = response.data['items'];
        List<RepoResponse> repositoryNames = items.map((item) {
          return RepoResponse.fromJson(item);
        }).toList();
        return repositoryNames;
      } else {
        throw Exception('Failed to fetch repositories');
      }
    } catch (e) {
      throw Exception('Failed to fetch repositories: $e');
    }
  }
}
