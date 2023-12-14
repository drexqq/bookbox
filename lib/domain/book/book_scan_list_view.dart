import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/user/provider/user_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookScanListView extends ConsumerStatefulWidget {
  const BookScanListView({super.key});

  @override
  ConsumerState<BookScanListView> createState() => _BookScanListViewState();
}

class _BookScanListViewState extends ConsumerState<BookScanListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("북스캔 서재"), centerTitle: false, actions: [
        TextButton(
            onPressed: () {
              context.router.push(const BookScanHistoryViewRoute());
            },
            child: const Text("신청내역"))
      ]),
      body: FutureBuilder(
          future: ref.read(userProvider).getScanLibrary(),
          builder: (_, snapshot) {
            List data = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            data.add({
              "B_COVER_IMG": "",
              "B_TITLE": "The House on Mango Street",
              "path": "assets/books/book2.pdf",
              "filename": "book2.pdf",
            });
            data.add({
              "B_COVER_IMG": "",
              "B_TITLE": "잭나이프",
              "path": "assets/books/book9.pdf",
              "filename": "book9.pdf",
            });
            data.add({
              "B_COVER_IMG": "",
              "B_TITLE": "깊은곳에 우물을 드리우라",
              "path": "assets/books/book19.pdf",
              "filename": "book19.pdf",
            });
            data.add({
              "B_COVER_IMG": "",
              "B_TITLE": "어느 게으름뱅이의 책읽기",
              "path": "assets/books/book11.pdf",
              "filename": "book11.pdf",
            });
            data.add({
              "B_COVER_IMG": "",
              "B_TITLE": "단숨에 읽는 홍루몽 1",
              "path": "assets/books/book17.pdf",
              "filename": "book17.pdf",
            });
            // data = [...data, ...snapshot.data];

            final len = data.length;
            if (len == 0) {
              return const Center(child: Text("북스캔 내역이 없습니다."));
            }
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                    itemCount: len,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / 1.3,
                            crossAxisCount: 3),
                    itemBuilder: (_, index) {
                      final info = data[index];
                      return GestureDetector(
                        onTap: () {
                          context.router.push(BookScanPdfViewRoute(
                              title: info["B_TITLE"],
                              path: info["path"],
                              filename: info["filename"]));
                        },
                        child: Stack(children: [
                          Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: info["B_COVER_IMG"] != "" &&
                                      info["B_COVER_IMG"] != null
                                  ? CachedNetworkImage(
                                      imageUrl: info["B_COVER_IMG"])
                                  : Center(child: Text(info["B_TITLE"]))),
                          const Positioned(
                              right: 0, bottom: 0, child: Icon(Icons.download))
                        ]),
                      );
                    }));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: () => context.router.push(const BookScanRegistViewRoute()),
          child:
              const Text("북스캔 도서 신청", style: TextStyle(color: Colors.white))),
    );
  }
}
