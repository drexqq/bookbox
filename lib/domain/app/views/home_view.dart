import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/app/app_root.dart';
import 'package:bookbox/domain/auth/provider/auth_provider.dart';
import 'package:bookbox/domain/book/book_scan_view.dart';
import 'package:bookbox/domain/chat/chat_list_view.dart';
import 'package:bookbox/domain/chat/chat_view.dart';
import 'package:bookbox/domain/deal/deal_list_view.dart';
import 'package:bookbox/domain/user/user_my_page_view.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final List<Widget> pages = [
    const DealListView(),
    const BookScanView(),
    const ChatListView(),
    const UserMyPageView(),
  ];

  int tabIndex = 0;
  void setPage(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  List<String> locations = ["야탑동", "판교동"];
  int storeID = 0;
  void setStoreID(int value) {
    if (value != storeID) {
      setState(() {
        storeID = value;
      });
    }
  }

  String order = "latest"; // popularity

  void setOrder(String value) {
    if (value != order) {
      setState(() {
        order = value;
      });
    }
  }

  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: tabIndex == 0
          ? AppBar(
              elevation: 0,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              leadingWidth: 80,
              leading: Center(
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  title: const Text("지역 선택"),
                                  content: Wrap(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            locations.asMap().entries.map((e) {
                                          return TextButton(
                                            onPressed: () {
                                              setStoreID(e.key);
                                              context.router.pop();
                                            },
                                            child: SizedBox(
                                                width: double.infinity,
                                                child: Text(e.value)),
                                          );
                                        }).toList())
                                  ]));
                            });
                      },
                      child: Text(locations[storeID],
                          style: TextStyle(
                              fontSize: 18.spMin,
                              fontWeight: FontWeight.w700)))),
              actions: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(
                        width: 150.spMin,
                        height: 40.spMin,
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _controller,
                          onTapOutside: (e) =>
                              _focusNode.hasFocus ? _focusNode.unfocus() : null,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 6.spMin),
                            border: const OutlineInputBorder(),
                          ),
                        )),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ])
                ])
          : null,
      body: SafeArea(child: pages[tabIndex]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: const Color(0xFF607d8b),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          onTap: setPage,
          items: const [
            BottomNavigationBarItem(
                label: "거래목록", icon: Icon(Icons.menu_book_outlined)),
            BottomNavigationBarItem(
                label: "북스캔", icon: Icon(Icons.document_scanner_outlined)),
            BottomNavigationBarItem(
                label: "채팅", icon: Icon(Icons.chat_outlined)),
            BottomNavigationBarItem(
                label: "My책장", icon: Icon(Icons.person_outline_outlined)),
          ]),
      floatingActionButton: tabIndex == 3
          ? ElevatedButton(
              onPressed: () {
                context.router.push(const DealRegistSelectBookViewRoute());
              },
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("대여거래 등록"),
                    SizedBox(width: 8.spMin),
                    const Icon(Icons.add_circle_outline_outlined)
                  ]))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
