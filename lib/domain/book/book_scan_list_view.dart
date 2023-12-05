import 'package:bookbox/domain/user/provider/user_provider.dart';
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
      appBar: AppBar(title: const Text("북스캔 서재"), centerTitle: false),
      body: FutureBuilder(
          future: ref.read(userProvider).getScanLibrary(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            final data = snapshot.data;
            // final len = data.length;
            const len = 5;

            if (len == 0) {
              return const Center(child: Text("북스캔 내역이 없습니다."));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                  itemCount: len,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1 / 1.3,
                      crossAxisCount: 3),
                  itemBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.download),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: () {},
        child: const Text("북스캔 도서 신청", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
