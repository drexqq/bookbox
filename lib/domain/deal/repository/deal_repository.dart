import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DealRepositoryProtocol {
  Future<List<BookDeal>> getDeals();
}

final dealRepositoryProvider = Provider(DealRepository.new);

class DealRepository implements DealRepositoryProtocol {
  DealRepository(this._ref);
  final Ref _ref;

  late final _api = _ref.read(apiProvider);

  @override
  Future<List<BookDeal>> getDeals() async {
    final response = await _api.post("book_deals", {});
    return response.when(success: (data) {
      final dealList = jsonDecode(data.toString())["rows"] as List<dynamic>;
      return dealList.map((item) {
        try {
          return BookDeal.fromJson(item);
        } catch (e) {
          throw Exception("BookDeals ERROR");
        }
      }).toList();
    }, error: (e) {
      throw HttpException("Get Book Deals Error", uri: Uri(path: "book_deals"));
    });
  }
}
