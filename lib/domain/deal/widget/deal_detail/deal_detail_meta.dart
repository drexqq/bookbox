import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealDetailMeta extends StatelessWidget {
  const DealDetailMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO 슬라이드 기능 들어가야함
        Container(height: ScreenUtil().screenHeight * .4, color: Colors.brown),
        Padding(
            padding: EdgeInsets.all(16.spMin),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    const CircleAvatar(),
                    SizedBox(width: 8.spMin),
                    Text("유저이름 책장",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.spMin))
                  ]),
                  const Text("지역명")
                ])),
        Text("책 상태(책 상태에 대한 설명)",
            style: TextStyle(fontSize: 16.spMin, color: Colors.blue[600])),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.spMin),
            child: Text("책 제목",
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18.spMin))),
        const Text("작가 / 출판사 / 출판일",
            maxLines: 1, overflow: TextOverflow.ellipsis),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.spMin),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Text("장르",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.spMin)),
                    const Text("책 장르")
                  ]),
                  Column(children: [
                    Text("언어",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.spMin)),
                    const Text("책 언어")
                  ]),
                  Column(children: [
                    Text("대여수",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.spMin)),
                    const Text("1.234K")
                  ]),
                  Column(children: [
                    Text("페이지",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.spMin)),
                    const Text("123124p")
                  ]),
                ])),
      ],
    );
  }
}
