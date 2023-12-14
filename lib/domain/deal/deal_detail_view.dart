import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/domain/deal/widget/deal_detail/deal_detail_meta.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DealDetailView extends ConsumerStatefulWidget {
  final String id;
  const DealDetailView({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<DealDetailView> createState() => _DealDetailViewState();
}

class _DealDetailViewState extends ConsumerState<DealDetailView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            ref.read(dealNotifierProvider).getDealDetail(int.parse(widget.id)),
        builder: (context, snapshot) {
          final deal = snapshot.data;
          final fee = int.parse(deal?.B_RENTAL_FEE ?? "0");
          final day = int.parse(deal?.B_RENTAL_DAY ?? "0");
          print(deal?.B_MEM_SEQ);
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text("책 상세 정보"),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.report_problem_outlined))
              ],
              automaticallyImplyLeading: true,
              surfaceTintColor: Colors.transparent,
            ),
            backgroundColor: Colors.grey[200],
            body: SafeArea(
                top: false,
                child: SingleChildScrollView(
                    child: Column(children: [
                  DealDetailMeta(
                    cover: deal?.B_COVER_IMG,
                    userName: deal?.B_BOOKSELF_NAME,
                    title: deal?.B_TITLE,
                    rate: deal?.B_READ_LEVEL,
                    rating: deal?.B_RATING?.split(";;"),
                    author: deal?.B_AUTHOR,
                    publisher: deal?.B_PUBLISHER,
                    quality: deal?.B_QULITY,
                    issueDate: deal?.B_ISSUE_DATE,
                    description: deal?.B_DESCRIPTION,
                  ),
                ]))),
            bottomNavigationBar: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.all(20)),
                onPressed: () async {
                  ref.read(dealRequestProvider).setMemSeq(deal?.B_MEM_SEQ);
                  ref.read(dealRequestProvider).setDealSeq(widget.id);
                  ref.read(dealRequestProvider).setFee(fee.toString());
                  ref.read(dealRequestProvider).setDay(day.toString());
                  context.router.pop();
                  context.router.push(const DealStoreSelectViewRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text("${fee * day}원 ($day일) 대여 요청하기",
                      style:
                          TextStyle(fontSize: 20.spMin, color: Colors.white)),
                )),
          );
        });
  }
}
