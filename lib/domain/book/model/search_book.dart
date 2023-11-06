import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_book.freezed.dart';
part 'search_book.g.dart';

@freezed
class SearchBook with _$SearchBook {
  factory SearchBook({
    required String? titleInfo,
    required String? typeName,
    required String? placeInfo,
    required String? authorInfo,
    required String? pubInfo,
    required String? menuName,
    required String? mediaName,
    required String? manageName,
    required String? pubYearInfo,
    required String? controlNo,
    required String? docYn,
    required String? orgLink,
    required String? id,
    required String? typeCode,
    required String? licYn,
    required String? licText,
    required String? regDate,
    required String? detailLink,
    required String? isbn,
    required String? callNo,
    required String? kdcCode1s,
    required String? kdcName1s,
    required String? classNo,
    required String? imageUrl,
    required String? typeOfRes,
  }) = _SearchBook;

  factory SearchBook.fromJson(Map<String, dynamic> json) =>
      _$SearchBookFromJson(json);
}
