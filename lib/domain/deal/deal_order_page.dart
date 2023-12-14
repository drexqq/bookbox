import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/domain/user/provider/user_provider.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

@RoutePage()
class DealOrderPage extends ConsumerStatefulWidget {
  const DealOrderPage({
    super.key,
  });

  @override
  ConsumerState<DealOrderPage> createState() => _DealOrderPageState();
}

class _DealOrderPageState extends ConsumerState<DealOrderPage> {
  List<DateTime?> date = [];
  String totalDay = "0";
  String totalFee = "0";

  void setDates(List<DateTime?> selectedDate) {
    final day = ref.read(dealRequestProvider).day;
    final fee = ref.read(dealRequestProvider).fee;
    date = selectedDate;
    if (date.length == 1) {
      totalDay = "0";
      totalFee = "0";
      ref.read(dealRequestProvider).setRentalDay(totalDay);
      ref.read(dealRequestProvider).setRentalFee(totalFee);
      setState(() {});
      return;
    }

    if (selectedDate.length == 2) {
      final first = selectedDate.first!;
      final last = selectedDate.last!;
      final days = last.difference(first).inDays;
      if (days > int.parse(day!)) {
        date = [];
        totalDay = "0";
        totalFee = "0";
        ref.read(dealRequestProvider).setRentalDay(null);
        ref.read(dealRequestProvider).setRentalFee(null);
        setState(() {});
        return;
      }
      totalDay = days.toString();
      totalFee = (int.parse(totalDay) * int.parse(fee!)).toString();
      ref.read(dealRequestProvider).setRentalDay(totalDay);
      ref.read(dealRequestProvider).setRentalFee(totalFee);
      ref.read(dealRequestProvider).setStartDate(first.toString());
      ref.read(dealRequestProvider).setEndDate(last.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final day = ref.read(dealRequestProvider).day;

    return Scaffold(
      appBar: AppBar(title: const Text("날짜제안")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("최대 $day일")])),
            CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.range),
                value: date,
                onValueChanged: setDates),
            Padding(
              padding: const EdgeInsets.all(16),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("대여일"),
                            if (date.isNotEmpty)
                              Text(DateFormat("yyyy-MM-dd")
                                  .format(date.first!)
                                  .toString()),
                            const SizedBox(height: 12),
                            const Text("북박스 영업시간"),
                            const Text("10:00 ~ 20:00")
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text("반납일"),
                            if (date.isNotEmpty)
                              Text(DateFormat("yyyy-MM-dd")
                                  .format(date.last!)
                                  .toString()),
                            const SizedBox(height: 12),
                            const Text("북박스 영업시간"),
                            const Text("10:00 ~ 20:00")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.yellow,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              padding: const EdgeInsets.all(20)),
          onPressed: () async {
            final point = await ref.read(userProvider).getPoint();
            if (totalDay == "0" || totalFee == "0") {
              return;
            }

            if (int.parse(point) < int.parse(totalFee)) {
              showChargePointDialog();
              return;
            } else {
              showRequestOrderDialog((totalFee).toString());
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("$totalFee원 ($totalDay일) 대여 요청하기",
                style: TextStyle(fontSize: 20.spMin, color: Colors.white)),
          )),
    );
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("$point포인트를 사용합니다"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                            final userId = ref.read(dealRequestProvider).memSeq;
                            // TODO post make a deal

                            await ref
                                .read(dealNotifierProvider)
                                .requestDeal()
                                .then((value) async {
                              // TODO send push to server
                              print("Request a deal");
                              print(value);
                              print(userId);
                              await Dio().post(
                                "https://bookbox.proxapp.net/bookbox/push",
                                // "http://172.30.1.75:5000/bookbox/push",
                                data: {"userId": userId, "type": "DEAL"},
                              ).then((r) {
                                print(r);
                                if (value) {
                                  Fluttertoast.showToast(msg: "대여 제안에 성공했습니다");
                                } else {
                                  Fluttertoast.showToast(msg: "대여 제안에 실패했습니다");
                                }
                                ref.read(dealRequestProvider).clear();
                                context.router.popUntilRoot();
                              });
                              // await Dio()
                              //     .post("http://172.30.1.44:5000/bookbox/push")
                              //     .then((_) {
                              //   if (value) {
                              //     Fluttertoast.showToast(msg: "대여 제안에 성공했습니다");
                              //   } else {
                              //     Fluttertoast.showToast(msg: "대여 제안에 실패했습니다");
                              //   }
                              //   ref.read(dealRequestProvider).clear();
                              //   context.router.popUntilRoot();
                              // });
                              // ref.read(dealRequestProvider).clear();
                              // context.router.popUntilRoot();
                            }).catchError((e) {});
                          },
                          child: const Text("요청",
                              style: TextStyle(color: Colors.blue))),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
