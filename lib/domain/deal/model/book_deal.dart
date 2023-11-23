// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_deal.freezed.dart';
part 'book_deal.g.dart';

@freezed
class BookDeal with _$BookDeal {
  factory BookDeal({
    required String? RN,
    required String? B_DEAL_SEQ,
    required String? B_BOOK_SEQ,
    required String? B_ISBN,
    required String? B_TITLE,
    required String? B_AUTHOR,
    required String? B_PUBLISHER,
    required String? B_ISSUE_DATE,
    required String? B_MEM_SEQ,
    required String? B_COVER_IMG,
    required String? B_QULITY,
    required String? B_MEM_IMGS,
    required String? B_RENTAL_DAY,
    required String? B_RENTAL_FEE,
    required String? B_READ_LEVEL,
    required String? B_RATING,
    required String? B_DESCRIPTION,
    required String? B_REVIEW_SCORE,
    required String? B_REVIEW_CNT,
    required String? B_REG_ID,
    required String? B_REG_DATE,
    required String? B_MODIFY_ID,
    required String? B_MODIFY_DATE,
    required String? B_STORE_SEQ,
    required String? B_STORE_POSITION,
    required String? B_STORE_ADDRESS,
    required String? B_DEAL_STATUS,
    required String? ISSUE_DATE,
    required String? B_BOOKSELF_NAME,
    required String? B_NAME,
    required String? B_AVATA_PIC,
  }) = _BookDeal;

  factory BookDeal.fromJson(Map<String, dynamic> json) =>
      _$BookDealFromJson(json);
}
