import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BookRepositoryProtocol {
  Future<List<Book>> getUserBooks();
  Future<List<SearchBook>> searchBooks(
    String kwd,
    CancelToken cancelToken,
    String? target,
  );
  Future<bool> registBooks(List<SearchBook> books);
  Future<bool> deleteBook(String bbs);
  Future<bool> registScan(SearchBook book, String fee, String price);
}

final bookRepositoryProvider = Provider(BookRepository.new);

class BookRepository extends BookRepositoryProtocol {
  BookRepository(this._ref);
  final Ref _ref;

  late final _api = _ref.read(apiProvider);
  late final _tokenRepository = _ref.read(tokenRepositoryProvider);

  @override
  Future<List<Book>> getUserBooks() async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post(
        "my_bookself", FormData.fromMap({"pageSize": 10000}),
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      final books = resp["rows"];
      try {
        return (books as List<dynamic>)
            .map((e) => Book.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return [];
      }
    }, error: (e) {
      throw HttpException("Get User Books Error",
          uri: Uri(path: "my_bookself"));
    });
  }

  @override
  Future<List<SearchBook>> searchBooks(
    String kwd,
    CancelToken cancelToken,
    String? target,
  ) async {
    final session = await _tokenRepository.getSession();

    FormData data = FormData.fromMap({
      "kwd": kwd,
      "srchTarget": "isbnCode",
    });
    final response = await _api.post("search_books", data,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      print(resp);

      final books = resp["result"];
      return (books as List<dynamic>)
          .map((e) => SearchBook.fromJson(e as Map<String, dynamic>))
          .toList();
    }, error: (e) {
      throw HttpException("Search Books Error", uri: Uri(path: "search_books"));
    });
  }

  @override
  Future<bool> registBooks(List<SearchBook> books) async {
    final booksData = books.map((e) => jsonEncode(e.toJson())).toList();
    final session = await _tokenRepository.getSession();
    FormData data = FormData.fromMap({"books[]": booksData});
    final response = await _api.post("book_rgst_prss", data,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      return resp["status"];
    }, error: (e) {
      throw HttpException("Regist User Book Error",
          uri: Uri(path: "book_rgst_prss"));
    });
  }

  @override
  Future<bool> deleteBook(String bbs) async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post("del_book", FormData.fromMap({"bbs": bbs}),
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      return resp["status"];
    }, error: (e) {
      throw HttpException("Delete User Books Error",
          uri: Uri(path: "del_book"));
    });
  }

  @override
  Future<bool> registScan(SearchBook book, String fee, String price) async {
    print("RegistScan1");
    final bookData = jsonEncode(book);
    print(bookData);
    final session = await _tokenRepository.getSession();
    FormData data = FormData.fromMap({
      "book": bookData,
      "book_price": price,
      "scan_fee": fee,
      "s_color": "N",
      "agree": "Y"
    });
    print("RegistScan2");
    final response = await _api.post("scan_book_rgst_prss", data,
        options: Options(headers: {"session": session}));
    print("RegistScan3");
    return response.when(success: (data) {
      print(data.data);
      final resp = jsonDecode(data.data);
      print(resp);
      return resp["status"];
    }, error: (e) {
      throw HttpException("Regist Book Scan Error",
          uri: Uri(path: "registScan"));
    });
  }
}
