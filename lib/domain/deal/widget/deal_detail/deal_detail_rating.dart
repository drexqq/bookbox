import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealDetailRating extends StatelessWidget {
  final String? rate;
  final List<String>? rating;
  const DealDetailRating({
    super.key,
    required this.rate,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final ratingData =
        rating?.map((e) => int.parse(e)).toList() ?? [0, 0, 0, 0, 0, 0];
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.spMin),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.spMin, color: Colors.black45),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                              const TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.attachment)),
                                WidgetSpan(child: SizedBox(width: 8)),
                                TextSpan(text: "평점"),
                              ]),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.spMin)),
                          Text(levelToText(rate ?? ""))
                        ]),
                    SizedBox(height: 8.spMin),
                    Row(children: [
                      Container(
                          width: 100,
                          height: 145.spMin,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8))),
                      SizedBox(width: 16.spMin),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            rateRow("재미", ratingData[0]),
                            SizedBox(height: 5.spMin),
                            rateRow("유익", ratingData[1]),
                            SizedBox(height: 5.spMin),
                            rateRow("감동", ratingData[2]),
                            SizedBox(height: 5.spMin),
                            rateRow("몰입", ratingData[3]),
                            SizedBox(height: 5.spMin),
                            rateRow("스릴", ratingData[4]),
                            SizedBox(height: 5.spMin),
                            rateRow("기발", ratingData[5]),
                          ]))
                    ])
                  ]))
        ]));
  }

  String levelToText(String level) {
    switch (level) {
      case "A":
        return "쉽게 읽혀요";
      case "B":
        return "보통이에요";
      case "C":
        return "여러 번 멈춰서 읽어야해요";
      default:
        return "";
    }
  }

  Widget rateRow(String title, int rate) {
    return Row(children: [
      Text(title),
      SizedBox(width: 8.spMin),
      Expanded(child: LayoutBuilder(builder: (context, constraints) {
        final widthPerRate = constraints.maxWidth / 5;

        return Stack(children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8)),
              height: 15.spMin),
          Positioned(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8)),
            width: widthPerRate * rate,
            height: 15.spMin,
          ))
        ]);
      }))
    ]);
  }
}
