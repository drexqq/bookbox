import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/auth/provider/auth_provider.dart';
import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/book/provider/book_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserMyPageView extends ConsumerStatefulWidget {
  const UserMyPageView({super.key});

  @override
  ConsumerState<UserMyPageView> createState() => _UserMyPageViewState();
}

class _UserMyPageViewState extends ConsumerState<UserMyPageView> {
  void callback() {
    print("CALLBACK");
    setState(() {});
  }

  String userName = "";
  Future<void> setUserName() async {
    final session = await ref.read(tokenRepositoryProvider).getSession();
    setState(() {
      userName = jsonDecode(session!)["b_name"];
    });
  }

  Future<List<Book>> getUserBooks() async {
    return await ref.read(bookProvider).getUserBooks();
  }

  @override
  void initState() {
    super.initState();
    setUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.spMin),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.spMin, color: Colors.black54))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            const CircleAvatar(),
            SizedBox(width: 8.spMin),
            Text("$userName의 책장"),
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                  onPressed: () async {
                    await ref.watch(authNotifierProvider.notifier).logout();
                  },
                  child: const Text("Logout"));
            }),
          ]),
          IconButton(
              onPressed: () =>
                  context.router.push(const UserSettingViewRoute()),
              icon: const Icon(Icons.settings))
        ]),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.spMin),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text.rich(TextSpan(children: [
            WidgetSpan(child: Icon(Icons.checklist_outlined)),
            TextSpan(text: "내 책장")
          ])),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.black54),
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                context.router
                    .push(UserBookRegistViewRoute(notifyParent: callback));
              },
              child: const Text("소장 책 등록"))
        ]),
      ),
      Expanded(
          child: FutureBuilder(
              future: getUserBooks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text("등록된 책이 없습니다."));
                }
                final books = snapshot.data as List<Book>;
                if (books.isEmpty) {
                  return const Center(child: Text("등록된 책이 없습니다."));
                }
                return GridView.builder(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.all(16.spMin),
                    itemCount: books.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 160,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16),
                    itemBuilder: (_, index) {
                      return Stack(clipBehavior: Clip.none, children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: books[index].B_COVER_IMG ?? "",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(books[index].B_TITLE ?? ""))),
                          ),
                        ),
                        Positioned(
                            left: 4,
                            top: 4,
                            width: 20,
                            height: 20,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)))),
                        Positioned(
                            right: 4,
                            top: 4,
                            child: GestureDetector(
                                onTap: () async {
                                  await ref
                                      .read(bookProvider)
                                      .deleteBook(books[index].B_BOOK_SEQ!)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: "도서가 삭제되었습니다",
                                        gravity: ToastGravity.CENTER);
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(),
                                    ),
                                    child: Icon(Icons.delete_outline_rounded,
                                        size: 14.sp))))
                      ]);
                    });
              }))
    ]);
  }
}
