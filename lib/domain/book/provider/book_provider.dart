import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:bookbox/domain/book/repository/book_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookProvider = ChangeNotifierProvider((ref) => BookNotifier(ref));

class BookNotifier extends ChangeNotifier {
  BookNotifier(this._ref) : super();
  final Ref _ref;

  late final BookRepository _repository = _ref.read(bookRepositoryProvider);

  Future<List<Book>> getUserBooks() async {
    return await _repository.getUserBooks();
  }

  Future<List<SearchBook>> searchBooks(String kwd) async {
    return await _repository.searchBooks(kwd);
  }

  Future<bool> registBooks(List<SearchBook> books) async {
    return await _repository.registBooks(books);
  }

  Future<bool> deleteBook(String bbs) async {
    return await _repository.deleteBook(bbs);
  }
}
