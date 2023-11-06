import 'package:auto_route/annotations.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_index.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_meta.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_preview.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_rating.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_recommend.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DealDetailView extends StatefulWidget {
  final String id;
  const DealDetailView({
    super.key,
    required this.id,
  });

  @override
  State<DealDetailView> createState() => _DealDetailViewState();
}

class _DealDetailViewState extends State<DealDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0),
      body: SafeArea(
          top: false,
          child: FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                return const SingleChildScrollView(
                    child: Column(children: [
                  DealDetailMeta(),
                  Column(children: [
                    DealDetailRecommend(
                        recommend: "asdasdlkasjdlkasjdlkasjdasdasd"),
                    DealDetailPreview(
                        preview:
                            "lskdfjalksdjflkasdjflkajefalkdsfjlkzjxclvkjzpijwerolkwejr;wklerjlkj"),
                    DealDetailIndex(index: "asdasdasdasd"),
                    DealDetailRating(rateText: "보통이에요"),
                    DealDetailReview(),
                  ])
                ]));
              })),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[400],
              padding: const EdgeInsets.all(20)),
          onPressed: () {},
          child: Text("3,000원 (2일) 대여 요청하기",
              style: TextStyle(fontSize: 20.spMin, color: Colors.white))),
    );
  }
}
