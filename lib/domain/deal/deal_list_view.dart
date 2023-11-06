import 'package:auto_route/annotations.dart';
import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/domain/deal/widget/deal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    return Column(children: [
      Container(
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(width: 1, color: Colors.black38))),
          child: Row(children: [
            TextButton(
                onPressed: () => setOrder("latest"),
                child: Text(
                  "최신순",
                  style: order == "latest"
                      ? const TextStyle(fontWeight: FontWeight.w700)
                      : null,
                )),
            TextButton(
                onPressed: () => setOrder("popularity"),
                child: Text("인기순",
                    style: order == "popularity"
                        ? const TextStyle(fontWeight: FontWeight.w700)
                        : null))
          ])),
      Container(
          width: double.infinity,
          height: 50,
          color: Colors.blue,
          child: const Text("AD Banner")),
      Expanded(
          child: FutureBuilder(
              future: ref.read(dealNotifierProvider).getDeals(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                final dealList = snapshot.data as List<BookDeal>;
                return ListView.builder(
                    itemCount: dealList.length,
                    itemBuilder: (context, index) {
                      return DealWidget(deal: dealList[index]);
                    });
              }))
    ]);
  }
}
