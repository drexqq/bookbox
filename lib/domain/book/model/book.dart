// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  factory Book({
    required String? RN,
    required String? B_BOOK_SEQ,
    required String? B_ISBN,
    required String? B_TITLE,
    required String? B_AUTHOR,
    required String? B_PUBLISHER,
    required String? B_ISSUE_DATE,
    required String? B_MEM_SEQ,
    required String? B_COVER_IMG,
    required String? B_REG_ID,
    required String? B_REG_DATE,
    required String? B_MODIFY_ID,
    required String? B_MODIFY_DATE,
    required String? B_BOOK_ID,
    required String? ISSUE_DATE,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
