import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:bookbox/domain/book/provider/book_provider.dart';
import 'package:bookbox/domain/user/provider/user_book_regist_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

const TIME_LIMIT = 10;

@RoutePage()
class UserBookRegistView extends ConsumerStatefulWidget {
  final String? code;
  const UserBookRegistView({
    super.key,
    this.code,
  });

  @override
  ConsumerState<UserBookRegistView> createState() => _UserBookRegistViewState();
}

class _UserBookRegistViewState extends ConsumerState<UserBookRegistView> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    if (widget.code != null && widget.code != "") {
      searchBooks();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  List<SearchBook> searchedBooks = [];
  Future<void> searchBooks() async {
    String? target = widget.code;
    Timer timer;
    int seconds = 0;
    CancelToken cancelToken = CancelToken();

    if (target != null && target != "") {
      final books = await ref
          .read(bookProvider)
          .searchBooks(widget.code!, cancelToken, "isbnCode");
      setState(() {
        searchedBooks = books;
      });
      return;
    }

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
        await ref.read(bookProvider).searchBooks(kwd, cancelToken, target);
    setState(() {
      searchedBooks = books;
    });
    timer.cancel();
    context.router.pop();
  }

  Future<bool> registBooks(List<SearchBook> books) async {
    return await ref.read(bookProvider).registBooks(books);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          ref.read(userBookRegistProvider).clear();
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
                title: const Text("소장 책 등록"),
                surfaceTintColor: Colors.transparent),
            body: Column(children: [
              TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onTapOutside: (_) =>
                      _focusNode.hasFocus ? _focusNode.unfocus() : null,
                  onSubmitted: (value) async {
                    await searchBooks();
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            if (_focusNode.hasFocus) {
                              _focusNode.unfocus();
                            }
                            await searchBooks();
                          },
                          icon: const Icon(Icons.search)),
                      labelText: "제목",
                      counterText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.spMin))),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: searchedBooks.isEmpty
                          ? const Center(child: Text("검색 결과가 없습니다"))
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              itemCount: searchedBooks.length,
                              itemBuilder: (_, index) =>
                                  _row(searchedBooks[index]),
                              separatorBuilder: (_, __) =>
                                  const Divider(thickness: 0)))),
              GestureDetector(
                onTap: () async {
                  final books = ref.read(userBookRegistProvider).selectedBooks;
                  showDialog(
                      context: context,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()));
                  await registBooks(books).then((_) {
                    context.router.pop().then((_) {
                      Fluttertoast.showToast(
                              msg: "소장 책 등록 완료",
                              backgroundColor: Colors.black,
                              gravity: ToastGravity.CENTER)
                          .then((_) {
                        context.router.pop();
                      });
                    });
                  });
                },
                child: Container(
                    width: double.infinity,
                    height: 80,
                    color: Colors.blue[400],
                    child: const Center(
                        child: Text("추가",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
              )
            ])));
  }

  Widget _row(SearchBook book) {
    return Consumer(builder: (_, ref, __) {
      bool isSelected =
          ref.watch(userBookRegistProvider).selectedBooks.contains(book);
      return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ref.read(userBookRegistProvider).setSelectedBook(book);
          },
          child: Stack(children: [
            Row(children: [
              SizedBox(
                width: 100,
                height: 160,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "https://cover.nl.go.kr/${book.imageUrl}",
                  placeholder: (_, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text(book.titleInfo ?? ""))),
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
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis)),
                            Text("${book.pubInfo}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis)),
                            Text("${book.pubYearInfo}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis)),
                          ])))
            ]),
            Positioned(
                right: 2,
                top: 0,
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(isSelected
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank)))
          ]));
    });
  }
}
