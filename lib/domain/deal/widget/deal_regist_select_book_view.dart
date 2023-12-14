import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/book/provider/book_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class DealRegistSelectBookView extends ConsumerStatefulWidget {
  const DealRegistSelectBookView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DealRegistSelectBookViewState();
}

class _DealRegistSelectBookViewState
    extends ConsumerState<DealRegistSelectBookView> {
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

  Future<List<Book>> getBooks() async {
    return await ref.read(bookProvider).getUserBooks();
  }

  Book? selectBook;
  void setSelectBook(Book book) {
    setState(() {
      selectBook = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("거래할 책을 선택해주세요")),
        body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: getBooks(),
                builder: (_, snapshot) {
                  List<Book> books = snapshot.data ?? [];

                  return Column(children: [
                    TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onTapOutside: (_) =>
                            _focusNode.hasFocus ? _focusNode.unfocus() : null,
                        decoration: const InputDecoration(
                            labelText: "제목, 저자, 출판사 검색",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            isDense: true)),
                    Expanded(
                        child: ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (_, index) {
                              final book = books[index];

                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setSelectBook(book);
                                },
                                child: Row(children: [
                                  Checkbox(
                                      value: book == selectBook,
                                      onChanged: (_) {
                                        setSelectBook(book);
                                      }),
                                  Expanded(
                                      child: Row(children: [
                                    SizedBox(
                                        width: 100,
                                        height: 140,
                                        child: book.B_COVER_IMG != "" &&
                                                book.B_COVER_IMG != null
                                            ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    book.B_COVER_IMG ?? "",
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget: (context, url, error) =>
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    5)),
                                                        child: Center(
                                                            child: Text(books[index].B_TITLE ?? ""))))
                                            : Container(decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(5)), child: Center(child: Text(books[index].B_TITLE ?? "")))),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text(book.B_TITLE ?? ""),
                                          Text(book.B_AUTHOR ?? "",
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis))
                                        ])),
                                  ]))
                                ]),
                              );
                            }))
                  ]);
                }),
          ),
          GestureDetector(
            onTap: () {
              if (selectBook != null) {
                context.router.push(DealRegistViewRoute(book: selectBook!));
              }
            },
            child: Container(
                width: double.infinity,
                height: 80,
                color: Colors.blue[400],
                child: const Center(
                    child: Text("대여거래 등록",
                        style: TextStyle(color: Colors.white, fontSize: 20)))),
          )
        ]));
  }
}
