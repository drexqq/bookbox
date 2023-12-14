import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/book/provider/book_provider.dart';
import 'package:bookbox/domain/chat/repository/chat_repository.dart';
import 'package:bookbox/domain/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class UserSettingView extends ConsumerStatefulWidget {
  const UserSettingView({super.key});

  @override
  ConsumerState<UserSettingView> createState() => _UserSettingViewState();
}

class _UserSettingViewState extends ConsumerState<UserSettingView> {
  String userName = "";
  Future<void> setUserName() async {
    final session = await ref.read(tokenRepositoryProvider).getSession();
    setState(() {
      userName = jsonDecode(session!)["b_name"];
    });
  }

  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    setUserName();
    _fetch();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  int myBooks = 0;
  int supplyBooks = 0;
  int rentalBooks = 0;

  int typeA = 0;
  int typeB = 0;
  int typeC = 0;
  int typeD = 0;
  int typeE = 0;
  int typeF = 0;
  Future<void> _fetch() async {
    final ChatRepository repository = ref.read(chatRepositoryProvider);
    final supply = await repository.getSupplies();
    print("supply.length: ${supply.length}");
    supplyBooks = supply.length;

    final rental = await repository.getRentals();
    print("rental.length: ${rental.length}");
    print(rental);
    for (final a in rental) {
      print(a);
    }
    rentalBooks = supply.length;

    final my = await ref.read(bookProvider).getUserBooks();
    print("myBooks: ${my.length}");
    myBooks = supply.length;
    // final ret = isMySupplies
    //     ? await repository.getSupplies()
    //     : await repository.getRentals();
    // rows = ret["rows"];

    // rows.removeWhere((e) => e["B_RENTAL_SEQ"] == "0");
    // rows.sort((a, b) => (b['B_REG_DATE']).compareTo(a['B_REG_DATE']));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: FutureBuilder(
                future: ref.read(userProvider).getUserInfo(),
                builder: (_, snapshot) {
                  final data = snapshot.data;

                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.spMin),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Row(children: [
                                const CircleAvatar(),
                                SizedBox(width: 16.spMin),
                                Text("$userName님 책장")
                              ]),
                              SizedBox(height: 16.spMin),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black26,
                                  ),
                                  child: Column(children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                            minHeight: 40, maxHeight: 40),
                                        child: const IntrinsicHeight(
                                            child: Row(children: [
                                          Expanded(
                                              child: Center(
                                                  child: Text("내 책장도서"))),
                                          VerticalDivider(
                                              color: Colors.white,
                                              width: 1,
                                              thickness: 2),
                                          Expanded(
                                              child:
                                                  Center(child: Text("독서기록")))
                                        ]))),
                                    const Divider(
                                        color: Colors.white,
                                        height: 1,
                                        thickness: 2),
                                    Container(
                                        constraints: const BoxConstraints(
                                            minHeight: 70, maxHeight: 70),
                                        child: IntrinsicHeight(
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                              Expanded(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              myBooks
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20
                                                                      .spMin)),
                                                          const Text("거래가능"),
                                                        ]),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              myBooks
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20
                                                                      .spMin)),
                                                          const Text("소장도서"),
                                                        ])
                                                  ])),
                                              const VerticalDivider(
                                                  color: Colors.white,
                                                  width: 1,
                                                  thickness: 2),
                                              Expanded(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              rentalBooks
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20
                                                                      .spMin)),
                                                          const Text("대여중"),
                                                        ]),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("0",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20
                                                                      .spMin)),
                                                          const Text("독서완료"),
                                                        ])
                                                  ]))
                                            ])))
                                  ])),
                              SizedBox(height: 16.spMin),
                              Column(children: [
                                const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("거래현황"),
                                      // Text("내 게시글보기"),
                                    ]),
                                SizedBox(height: 16.spMin),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(children: [
                                        const Text("예약"),
                                        Text(typeA.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.spMin))
                                      ]),
                                      Column(children: [
                                        const Text("입고"),
                                        Text(typeB.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.spMin))
                                      ]),
                                      Column(children: [
                                        const Text("대여"),
                                        Text(typeC.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.spMin))
                                      ]),
                                      Column(children: [
                                        const Text("반납"),
                                        Text(typeD.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.spMin))
                                      ]),
                                      Column(children: [
                                        const Text("회수"),
                                        Text(typeE.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.spMin))
                                      ]),
                                      Column(children: [
                                        const Text("평가"),
                                        Text(typeF.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.spMin))
                                      ])
                                    ])
                              ])
                            ]),
                            Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.spMin),
                                child: Column(children: [
                                  Container(
                                      height: 40,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.spMin),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.black26),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("P 포인트"),
                                            Text("${data?["B_POINT"]}원")
                                          ])),
                                  SizedBox(height: 16.spMin),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                                backgroundColor: Colors.white,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Wrap(children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text("충전하기"),
                                                            TextField(
                                                                focusNode:
                                                                    _focusNode,
                                                                controller:
                                                                    _controller,
                                                                onTapOutside: (e) => _focusNode
                                                                        .hasFocus
                                                                    ? _focusNode
                                                                        .unfocus()
                                                                    : null,
                                                                decoration: InputDecoration(
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                            horizontal: 6
                                                                                .spMin),
                                                                    border:
                                                                        const OutlineInputBorder())),
                                                            const SizedBox(
                                                                height: 16),
                                                            Container(
                                                                width: double
                                                                    .infinity,
                                                                color: Colors
                                                                    .red[400],
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors.red[
                                                                                400]),
                                                                        onPressed:
                                                                            () async {
                                                                          await ref
                                                                              .read(userProvider)
                                                                              .rechargePoint(_controller.text)
                                                                              .then((value) {
                                                                            context.router.pop();
                                                                            setState(() {});
                                                                            _controller.text =
                                                                                "";
                                                                            if (value) {
                                                                              Fluttertoast.showToast(msg: "성공", gravity: ToastGravity.CENTER);
                                                                            }
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "충전",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )))
                                                          ])
                                                    ])));
                                          });
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.spMin),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.red[400]),
                                      child: const Center(
                                          child: Text(
                                        "충전하기",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                  SizedBox(height: 16.spMin),
                                  Container(
                                      height: 100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.spMin),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.red[400]),
                                      child: Column(children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("북박스 구독중",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: const Text("해지"))
                                            ]),
                                        const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("사용가능 매장쿠폰",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text("0장",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ]),
                                        const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("사용완료 매장쿠폰",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text("0장",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ])
                                      ]))
                                ]))
                          ]));
                })));
  }
}
