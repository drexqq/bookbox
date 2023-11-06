import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealDetailRecommend extends StatelessWidget {
  final String? recommend;
  const DealDetailRecommend({
    super.key,
    this.recommend,
  });

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                      const TextSpan(children: [
                        WidgetSpan(child: Icon(Icons.attachment)),
                        WidgetSpan(child: SizedBox(width: 8)),
                        TextSpan(text: "xxx의 추천서"),
                      ]),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18.spMin)),
                  if (recommend != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(recommend ?? ""),
                    ),
                ],
              ))
        ]));
  }
}
