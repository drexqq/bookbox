import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _Initial;

  const factory AppState.authenticated() = _Authenticated;

  const factory AppState.unauthenticated() = _Unauthenticated;

  const factory AppState.error(error) = _Error;
}
