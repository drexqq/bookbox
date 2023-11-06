// Package imports:
import 'package:bookbox/http/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loggedIn() = AuthStateLoggedIn;

  const factory AuthState.loggedOut() = AuthStateLoggedOut;

  const factory AuthState.error(AppException error) = _Error;
}
