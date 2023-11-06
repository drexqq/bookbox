import 'package:bookbox/http/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
// Project imports:
part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T value) = ApiSuccess<T>;
  const factory ApiResponse.error(AppException exception) = ApiError;
}
