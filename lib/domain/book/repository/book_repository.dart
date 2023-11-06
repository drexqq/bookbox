import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BookRepositoryProtocol {
  Future<List<Book>> getUserBooks();
  Future<List<SearchBook>> searchBooks(String kwd);
  Future<bool> registBooks(List<SearchBook> books);
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
    final response = await _api.post("my_bookself", null,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      final books = resp["rows"];
      return (books as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList();
    }, error: (e) {
      throw HttpException("Get User Books Error",
          uri: Uri(path: "my_bookself"));
    });
  }

  @override
  Future<List<SearchBook>> searchBooks(String kwd, {int page = 1}) async {
    FormData data =
        FormData.fromMap({"srchTarget": "title", "kwd": kwd, "pageNum": 1});
    final response = await _api.post("search_books", data);
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
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
}
