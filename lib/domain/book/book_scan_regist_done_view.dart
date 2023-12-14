import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class BookScanRegistDoneView extends StatefulWidget {
  final String image;
  const BookScanRegistDoneView({
    super.key,
    required this.image,
  });

  @override
  State<BookScanRegistDoneView> createState() => _BookScanRegistDoneViewState();
}

class _BookScanRegistDoneViewState extends State<BookScanRegistDoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          const Text("신청 및 결제 완료",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          SizedBox(
              height: ScreenUtil().screenHeight * .5,
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        image: widget.image != ""
                            ? DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover)
                            : null),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 0),
                        child:
                            Container(color: Colors.white.withOpacity(0.5)))),
                Positioned(
                    child: Center(
                  child: widget.image != ""
                      ? CachedNetworkImage(
                          imageUrl: widget.image ?? "", fit: BoxFit.cover)
                      : Container(
                          color: Colors.grey,
                        ),
                ))
              ])),
          const SizedBox(height: 30),
          const Center(
            child: Text("북스캔을 위해 도서를 발송해주세요\n수령일 기준 10일 후에 정식 파일로 업로드 됩니다.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 20),
          Center(
              child: Text(
                  "07995\n서울시 양천구 목동서로 225 대한민국예술인센터 9층\n운영사무국 (02-2608-2800)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red[400])))
        ]),
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 16)),
            onPressed: context.router.popUntilRoot,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text("확인 완료",
                    style:
                        TextStyle(fontSize: 20.spMin, color: Colors.white)))));
  }
}
