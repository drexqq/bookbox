import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/book/model/search_book.dart';
import 'package:bookbox/domain/book/provider/book_provider.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/domain/user/provider/user_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class BookScanDetailView extends ConsumerStatefulWidget {
  final SearchBook book;
  const BookScanDetailView({
    super.key,
    required this.book,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookScanDetailViewState();
}

class _BookScanDetailViewState extends ConsumerState<BookScanDetailView> {
  bool isColor = false;
  void setIsColor(bool val) {
    isColor = val;
    setState(() {});
  }

  bool isAgree = false;
  void setIsAgree(bool val) {
    isAgree = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final image = "https://cover.nl.go.kr/${widget.book.imageUrl}";
    return Scaffold(
      appBar: AppBar(title: const Text("검색 결과"), centerTitle: false),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          Column(children: [
            _image(image),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                    child: Text(
                        "${widget.book.typeName} | ${widget.book.kdcName1s}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )))),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(widget.book.titleInfo ?? "",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 8),
                    const Row(children: [
                      Icon(Icons.star),
                      Text("2.1",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ])
                  ])),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("${widget.book.authorInfo}"),
                    Text("${widget.book.pubInfo}"),
                    Text("${widget.book.pubYearInfo}")
                  ]))
            ]),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Expanded(
                  child: Text("정가 : 7,000원",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ))),
              Expanded(
                  child: Column(children: [
                Row(children: [
                  Row(children: [
                    Checkbox(
                        value: !isColor,
                        onChanged: (value) {
                          setIsColor(false);
                        }),
                    const Text("흑백")
                  ]),
                  const SizedBox(width: 12),
                  const Text("14,000p",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                ]),
                Row(children: [
                  Row(children: [
                    Checkbox(
                        value: isColor,
                        onChanged: (value) {
                          setIsColor(true);
                        }),
                    const Text("컬러")
                  ]),
                  const SizedBox(width: 12),
                  const Text("21,000p",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                ])
              ]))
            ]),
            const Divider(),
            const Text(
                "북스캔 서비스는 실물 책을 파일로 스캔하는 유료형 서비스입니다. 이용자는 회사로 신청도서를 배송하여 저작권 법에 의해 실물 책은 파기되는 것에 대하여 동의합니다.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("(필수) 이용주의사항을 확인하였습니다"),
              Checkbox(
                  value: isAgree,
                  onChanged: (value) {
                    setIsAgree(!isAgree);
                  })
            ])
          ])
        ]),
      ))),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              padding: const EdgeInsets.symmetric(vertical: 16)),
          onPressed: () async {
            if (!isAgree) {
              Fluttertoast.showToast(
                  msg: "이용주의사항에 확인해주세요", toastLength: Toast.LENGTH_SHORT);
              return;
            } else {
              final point = await ref.read(userProvider).getPoint();
              final totalFee = isColor ? 21000 : 14000;

              if (int.parse(point) < totalFee) {
                showChargePointDialog();
              } else {
                print("Request");
                showRequestOrderDialog((totalFee).toString());
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("신 청",
                style: TextStyle(fontSize: 20.spMin, color: Colors.white)),
          )),
    );
  }

  Widget _image(String image) {
    return SizedBox(
        height: ScreenUtil().screenHeight * .3,
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  image: image != ""
                      ? DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)
                      : null),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 0),
                  child: Container(color: Colors.white.withOpacity(0.5)))),
          Positioned(
              child: Center(
            child: image != ""
                ? CachedNetworkImage(imageUrl: image ?? "", fit: BoxFit.cover)
                : Container(
                    color: Colors.grey,
                  ),
          ))
        ]));
  }

  void showChargePointDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text("포인트 잔액이 부족합니다"),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          onPressed: () {},
                          child: const Text("충전하기",
                              style: TextStyle(color: Colors.blue)))
                    ])
                  ])));
        });
  }

  void showRequestOrderDialog(String point) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("$point포인트를 사용합니다"),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          onPressed: context.router.pop,
                          child: const Text("취소",
                              style: TextStyle(color: Colors.red))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          onPressed: () async {
                            await ref
                                .read(bookProvider)
                                .registScan(widget.book, point, "7000")
                                .then((value) {
                              if (value) {
                                final image =
                                    "https://cover.nl.go.kr/${widget.book.imageUrl}";
                                context.router.popTop().then((_) {
                                  context.router.push(
                                      BookScanRegistDoneViewRoute(
                                          image: image));
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "스캔 신청에 실패했습니다",
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                            });
                          },
                          child: const Text("요청",
                              style: TextStyle(color: Colors.blue)))
                    ])
                  ])));
        });
  }
}
