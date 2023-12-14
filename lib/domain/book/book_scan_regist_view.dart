import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:bookbox/domain/book/provider/book_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

const TIME_LIMIT = 10;

@RoutePage()
class BookScanRegistView extends ConsumerStatefulWidget {
  const BookScanRegistView({super.key});

  @override
  ConsumerState<BookScanRegistView> createState() => _BookScanRegistViewState();
}

class _BookScanRegistViewState extends ConsumerState<BookScanRegistView> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  List<SearchBook> searchedBooks = [];
  Future<void> searchBooks() async {
    Timer timer;
    int seconds = 0;
    CancelToken cancelToken = CancelToken();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > TIME_LIMIT) {
        cancelToken.cancel();
        timer.cancel();
        setState(() {
          searchedBooks = [];
        });
        context.router.pop();
      }
      seconds++;
    });
    String kwd = _controller.text;
    if (kwd == "" || kwd.isEmpty || kwd.length < 2) {
      Fluttertoast.showToast(
          msg: "검색어를 2글자 이상 입력해주세요", gravity: ToastGravity.CENTER);
      return;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));

    final books =
        await ref.read(bookProvider).searchBooks(kwd, cancelToken, "isbnCode");
    setState(() {
      searchedBooks = books;
    });
    timer.cancel();
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("북스캔 도서검색"), centerTitle: false),
        body: Column(children: [
          TextField(
              controller: _controller,
              focusNode: _focusNode,
              onTapOutside: (_) =>
                  _focusNode.hasFocus ? _focusNode.unfocus() : null,
              onSubmitted: (value) async {
                await searchBooks();
              },
              decoration: const InputDecoration(
                  labelText: "제목, 저자, 출판사 검색",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  isDense: true)),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: searchedBooks.isEmpty
                      ? const Center(child: Text("검색 결과가 없습니다"))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemCount: searchedBooks.length,
                          itemBuilder: (_, index) => _row(searchedBooks[index]),
                          separatorBuilder: (_, __) =>
                              const Divider(thickness: 0))))
        ]));
  }

  Widget _row(SearchBook book) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.router.push(BookScanDetailViewRoute(book: book)),
        child: Row(children: [
          SizedBox(
            width: 100,
            height: 160,
            child: book.imageUrl != "" && book.imageUrl != null
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "https://cover.nl.go.kr/${book.imageUrl}",
                    placeholder: (_, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text(book.titleInfo ?? ""))),
                  )
                : Container(
                    child: Center(child: Text(book.titleInfo ?? "")),
                  ),
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints:
                      const BoxConstraints(minHeight: 160, maxHeight: 160),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.titleInfo ?? "",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis)),
                        Text("${book.authorInfo}",
                            style: const TextStyle(
                                fontSize: 18, overflow: TextOverflow.ellipsis)),
                        Text("${book.pubInfo}",
                            style: const TextStyle(
                                fontSize: 18, overflow: TextOverflow.ellipsis)),
                        Text("${book.pubYearInfo}",
                            style: const TextStyle(
                                fontSize: 18, overflow: TextOverflow.ellipsis)),
                      ])))
        ]));
  }
}
