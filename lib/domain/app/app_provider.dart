import 'package:bookbox/domain/app/app_state.dart';
import 'package:bookbox/domain/auth/provider/auth_provider.dart';
import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/auth/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  late final TokenRepository _tokenRepository =
      ref.read(tokenRepositoryProvider);

  @override
  FutureOr<AppState> build() async {
    print("AppNotifier Build");
    ref.onDispose(() {
      print("dispose app");
    });

    final authState = ref.watch(authNotifierProvider);
    if (authState is AuthStateLoggedOut) {
      return const AppState.unauthenticated();
    }

    final session = await _tokenRepository.getSession();
    if (session == null) {
      return const AppState.unauthenticated();
    }

    return const AppState.authenticated();
  }
}
