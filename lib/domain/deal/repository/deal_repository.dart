import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DealRepositoryProtocol {
  Future<List<BookDeal>> getDeals();
  Future<List<BookDeal>> searchDeals(String kwd);
  Future<BookDeal?> getDealDetail(int seq);
  Future<bool> registDeal(FormData data);
  Future<bool> requestDeal(FormData data);
}

final dealRepositoryProvider = Provider(DealRepository.new);

class DealRepository implements DealRepositoryProtocol {
  DealRepository(this._ref);
  final Ref _ref;

  late final _api = _ref.read(apiProvider);
  late final _tokenRepository = _ref.read(tokenRepositoryProvider);

  @override
  Future<List<BookDeal>> getDeals() async {
    final session = await _tokenRepository.getSession();

    final response = await _api.post(
        "book_deals", FormData.fromMap({"pageSize": 10000}),
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final dealList = jsonDecode(data.toString())["rows"] as List<dynamic>;
      final ret = dealList.map((item) {
        try {
          return BookDeal.fromJson(item);
        } catch (e) {
          throw Exception("BookDeals ERROR");
        }
      }).toList();
      ret.sort((a, b) => b.B_REG_DATE!.compareTo(a.B_REG_DATE!));
      return ret;
    }, error: (e) {
      throw HttpException("Get Book Deals Error", uri: Uri(path: "book_deals"));
    });
  }

  @override
  Future<List<BookDeal>> searchDeals(String kwd) async {
    final session = await _tokenRepository.getSession();

    final response = await _api.post("book_deals",
        FormData.fromMap({"b_store": 1, "kwd": kwd, "pageSize": 10000}),
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final dealList = jsonDecode(data.toString())["rows"] as List<dynamic>;
      final ret = dealList.map((item) {
        try {
          return BookDeal.fromJson(item);
        } catch (e) {
          throw Exception("BookDeals ERROR");
        }
      }).toList();
      ret.sort((a, b) => b.B_REG_DATE!.compareTo(a.B_REG_DATE!));
      return ret;
    }, error: (e) {
      throw HttpException("Get Book Deals Error", uri: Uri(path: "book_deals"));
    });
  }

  @override
  Future<BookDeal?> getDealDetail(int seq) async {
    final session = await _tokenRepository.getSession();

    final response = await _api.post(
        "deal_book_info", FormData.fromMap({"dseq": seq}),
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      return BookDeal.fromJson(jsonDecode(data.data)["row"]);
    }, error: (e) {
      throw HttpException("Get Book Deals Error", uri: Uri(path: "book_deals"));
    });
  }

  @override
  Future<bool> registDeal(FormData data) async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post("rental_deal_rgst_prss", data,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      return resp["status"];
    }, error: (e) {
      throw HttpException("Get Book Deals Error", uri: Uri(path: "book_deals"));
    });
  }

  @override
  Future<bool> requestDeal(FormData data) async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post("rental_order_rgst_prss", data,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      return resp["status"];
    }, error: (e) {
      throw HttpException("Request Deal Error",
          uri: Uri(path: "rental_order_rgst_prss"));
    });
  }
}
