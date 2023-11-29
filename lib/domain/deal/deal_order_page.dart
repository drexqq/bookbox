import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DealOrderPage extends StatefulWidget {
  final int fee;
  final int day;
  const DealOrderPage({
    super.key,
    required this.fee,
    required this.day,
  });

  @override
  State<DealOrderPage> createState() => _DealOrderPageState();
}

class _DealOrderPageState extends State<DealOrderPage> {
  List<DateTime?> date = [];
  void setDates(List<DateTime?> selectedDate) {
    date = selectedDate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("날짜제안")),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("최대 ${widget.day}일")])),
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
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              padding: const EdgeInsets.all(20)),
          onPressed: () async {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("${widget.fee * widget.day}원 (${widget.day}일) 대여 요청하기",
                style: TextStyle(fontSize: 20.spMin, color: Colors.white)),
          )),
    );
  }
}
