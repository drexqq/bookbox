import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/domain/deal/widget/deal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DealListView extends ConsumerStatefulWidget {
  const DealListView({super.key});

  @override
  ConsumerState<DealListView> createState() => _DealListViewState();
}

class _DealListViewState extends ConsumerState<DealListView> {
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
    fetchDeals();

    super.initState();
  }

  List<BookDeal> deals = [];
  void setDeals(List<BookDeal> dealList) {
    setState(() {
      deals = dealList;
    });
  }

  Future<void> fetchDeals() async {
    final deals = await ref.read(dealNotifierProvider).getDeals();
    setDeals(deals);
  }

  Future<void> searchBooks(String kwd) async {
    final deals = await ref.read(dealNotifierProvider).searchDeals(kwd);
    setDeals(deals);
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
      appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          leadingWidth: 200,
          leading: TextButton(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: locations.asMap().entries.map((e) {
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
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(TextSpan(children: [
                    const WidgetSpan(child: Icon(Icons.pin_drop_outlined)),
                    const WidgetSpan(child: SizedBox(width: 12)),
                    TextSpan(text: locations[storeID])
                  ])))),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
          ]),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: 80,
                color: Colors.blue,
                child: const Text("AD Banners"))),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            focusNode: _focusNode,
            controller: _controller,
            onTapOutside: (e) =>
                _focusNode.hasFocus ? _focusNode.unfocus() : null,
            onSubmitted: (_) async {
              await searchBooks(_controller.text);
            },
            decoration: InputDecoration(
                labelText: "책 제목 검색",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                    onPressed: () async {
                      await searchBooks(_controller.text);
                    },
                    icon: const Icon(Icons.search)),
                contentPadding: EdgeInsets.symmetric(horizontal: 6.spMin),
                border: const UnderlineInputBorder()),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  return DealWidget(deal: deals[index]);
                }))
      ]),
    );
  }
}
