import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/domain/deal/widget/deal_regist/difficulty_box.dart';
import 'package:bookbox/domain/deal/widget/deal_regist/quality_box.dart';
import 'package:bookbox/domain/deal/widget/deal_regist/rating_box.dart';
import 'package:bookbox/domain/deal/widget/deal_regist/recommend_box.dart';
import 'package:bookbox/domain/deal/widget/deal_regist/rental_fee_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class DealRegistView extends ConsumerStatefulWidget {
  final Book book;
  const DealRegistView({
    super.key,
    required this.book,
  });

  @override
  ConsumerState<DealRegistView> createState() => _DealRegistViewState();
}

class _DealRegistViewState extends ConsumerState<DealRegistView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(dealRegistProvider).setId(null);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("대여 등록"), surfaceTintColor: Colors.transparent),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    SizedBox(
                        width: 100,
                        height: 140,
                        child: widget.book.B_COVER_IMG != "" &&
                                widget.book.B_COVER_IMG != null
                            ? CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.book.B_COVER_IMG ?? "",
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                        child:
                                            Text(widget.book.B_TITLE ?? ""))))
                            : Center(child: Text(widget.book.B_TITLE ?? ""))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(widget.book.B_TITLE ?? ""),
                          Text(widget.book.B_AUTHOR ?? "",
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis))
                        ])),
                  ])),
              const SizedBox(height: 10),
              _box("품질 상태", const QualityBox()),
              const SizedBox(height: 10),
              _box("대여금액 입력", const RentalFeeBox()),
              const SizedBox(height: 10),
              _box("책 난이도를 공유해주세요", const DifficultyBox()),
              const SizedBox(height: 10),
              _box("책 전반적인 평가", const RatingBox()),
              const SizedBox(height: 10),
              _box("활발한 대여를 위해 추천서를 작성해주세요!", const RecommendBox()),
              const SizedBox(height: 20),
            ])),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()));

            ref.read(dealRegistProvider).setId(widget.book.B_BOOK_SEQ!);
            await Future.delayed(Durations.short1);
            await ref.read(dealNotifierProvider).registDeal().then((value) {
              if (value) {
                Fluttertoast.showToast(
                    msg: "대여 등록 완료", gravity: ToastGravity.CENTER);
                context.router.popUntilRoot();
              } else {
                Fluttertoast.showToast(
                    msg: "대여 등록에 실패했습니다", gravity: ToastGravity.CENTER);
                context.router.pop();
              }
            });
          },
          child: Container(
              width: double.infinity,
              height: 80,
              color: Colors.blue[400],
              child: const Center(
                  child: Text("등록",
                      style: TextStyle(color: Colors.white, fontSize: 20)))),
        ),
      ),
    );
  }

  Widget _box(String title, Widget widget) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title),
          const SizedBox(height: 16),
          widget,
        ]));
  }
}
