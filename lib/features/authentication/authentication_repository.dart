import 'package:dio/dio.dart';
import 'package:flutter_project/core/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticaionRepository = Provider(AuthenticaionRepository.new);

class AuthenticaionRepository {
  AuthenticaionRepository(this._ref);
  final ProviderRef _ref;
  ApiService get _apiService => _ref.read(apiServiceProvider);
  Future<Response?> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateToken(String token) async {
    _apiService.setToken(token);
  }
}
