import 'package:bookbox/domain/auth/repository/auth_repository.dart';
import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/auth/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _repository = ref.read(authRepositoryProvider);
  late final TokenRepository _tokenRepository =
      ref.read(tokenRepositoryProvider);

  @override
  AuthState build() {
    ref.onDispose(() {});

    return const AuthState.initial();
  }

  Future<void> login(String phone) async {
    await _repository.login(phone).then((ret) {
      if (ret) {
        state = const AuthState.loggedIn();
      } else {
        state = const AuthState.loggedOut();
      }
    }).catchError((e, _) {
      state = const AuthState.loggedOut();
    });
  }

  Future<void> logout() async {
    await _tokenRepository.removeSeq();
    state = const AuthState.loggedOut();
  }

  Future<String?> sendSms(String phone) async {
    return await _repository.sendSms(phone).then((code) {
      return code;
    }).catchError((e, s) {
      state = const AuthState.loggedOut();
    });
  }

  Future<bool> authSms(String phone) async {
    return await _repository.login(phone).then((ret) async {
      if (ret) {
        await _repository.verifyAuthCode(phone);
        state = const AuthState.loggedIn();
        return true;
      } else {
        state = const AuthState.loggedOut();
        return false;
      }
    }).catchError((e, _) {
      state = const AuthState.loggedOut();
    });
  }
}
