import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userBookRegistProvider =
    ChangeNotifierProvider((ref) => UserBookRegistProvider(ref));

class UserBookRegistProvider extends ChangeNotifier {
  UserBookRegistProvider(this._ref) : super();

  final Ref _ref;

  List<SearchBook> selectedBooks = [];

  // ignore: non_constant_identifier_names
  void setSelectedBook(SearchBook book) {
    if (selectedBooks.contains(book)) {
      selectedBooks.remove(book);
    } else {
      selectedBooks = [...selectedBooks, book];
    }
    notifyListeners();
  }

  void clear() {
    selectedBooks.clear();
    notifyListeners();
  }
}
