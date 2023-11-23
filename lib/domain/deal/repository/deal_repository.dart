import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DealRepositoryProtocol {
  Future<List<BookDeal>> getDeals();
  Future<dynamic> registDeal(FormData data);
}

final dealRepositoryProvider = Provider(DealRepository.new);

class DealRepository implements DealRepositoryProtocol {
  DealRepository(this._ref);
  final Ref _ref;

  late final _api = _ref.read(apiProvider);
  late final _tokenRepository = _ref.read(tokenRepositoryProvider);

  @override
  Future<List<BookDeal>> getDeals() async {
    final response =
        await _api.post("book_deals", FormData.fromMap({"pageSize": 10000}));
    return response.when(success: (data) {
      final dealList = jsonDecode(data.toString())["rows"] as List<dynamic>;
      print(dealList.length);
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

  @override
  Future<dynamic> registDeal(FormData data) async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post("rental_deal_rgst_prss", data,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      return null;
    }, error: (e) {
      throw HttpException("Get Book Deals Error", uri: Uri(path: "book_deals"));
    });
  }
}
