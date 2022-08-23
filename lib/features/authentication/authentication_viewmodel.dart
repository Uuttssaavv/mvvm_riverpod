import 'package:flutter_project/enums/auth_enums.dart';
import 'package:flutter_project/features/authentication/authentication_repository.dart';
import 'package:flutter_project/models/user_model.dart';
import 'package:flutter_project/services/user_cache_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewmodelProvider = StateNotifierProvider.autoDispose<
    AuthenticationViewmodel, AuthenticationState>(AuthenticationViewmodel.new);

class AuthenticationViewmodel extends StateNotifier<AuthenticationState> {
  final AutoDisposeStateNotifierProviderRef ref;

  AuthenticationViewmodel(this.ref) : super(AuthenticationState());
  AuthenticaionRepository get _repository => ref.read(authenticaionRepository);
  UserCacheService get userCacheService => ref.read(userCacheProvider);

  Future<void> loginUser(
      {required String username, required String password}) async {
    state = state.copyWith(isLoading: true, auth: Auth.idle);
    final responseData =
        await _repository.loginUser(username: username, password: password);
    if (responseData != null) {
      if (responseData.statusCode == 200) {
        final user = User.fromMap(responseData.data);
        await _repository.updateToken(user.token);
        userCacheService.saveUser(user);
        state = state.copyWith(
          isLoading: false,
          auth: Auth.loginSuccess,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: responseData.data['message'],
          auth: Auth.loginError,
        );
      }
    }
  }
}

class AuthenticationState {
  final bool isLoading;
  final String? errorMessage;
  final Auth auth;
  AuthenticationState({
    this.isLoading = false,
    this.errorMessage,
    this.auth = Auth.idle,
  });
  AuthenticationState copyWith({
    bool? isLoading,
    String? errorMessage,
    Auth? auth,
  }) =>
      AuthenticationState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        auth: auth ?? this.auth,
      );
}
