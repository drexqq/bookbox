import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealDetailReview extends StatelessWidget {
  const DealDetailReview({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                          const TextSpan(children: [
                            WidgetSpan(child: Icon(Icons.rate_review_outlined)),
                            WidgetSpan(child: SizedBox(width: 8)),
                            TextSpan(text: "최신리뷰")
                          ]),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.spMin)),
                      GestureDetector(
                          onTap: () {},
                          child: const Text.rich(TextSpan(children: [
                            WidgetSpan(child: Center(child: Text("다른 리뷰 보기"))),
                            WidgetSpan(
                                child:
                                    Icon(Icons.keyboard_arrow_right_outlined))
                          ])))
                    ],
                  ),
                  SizedBox(height: 16.spMin),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(),
                                SizedBox(width: 8.spMin),
                                Text("유저이름 책장",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.spMin))
                              ],
                            ),
                            const Text("5일전")
                          ]),
                      SizedBox(height: 10.spMin),
                      const Text("유저 이름"),
                      SizedBox(height: 10.spMin),
                      const Text("리뷰내용"),
                    ],
                  )
                ],
              )),
        ]));
  }
}
