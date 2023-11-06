import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/deal/deal_detail_view.dart';
import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:bookbox/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class DealWidget extends StatefulWidget {
  final BookDeal deal;
  const DealWidget({
    super.key,
    required this.deal,
  });

  @override
  State<DealWidget> createState() => _DealWidgetState();
}

class _DealWidgetState extends State<DealWidget> {
  @override
  Widget build(BuildContext context) {
    final rating = widget.deal.B_RATING
            .split(";;")
            .map((e) => int.parse(e))
            .reduce((a, b) => a + b) /
        6;
    return GestureDetector(
      onTap: () {
        context.router
            .push(DealDetailViewRoute(id: widget.deal.B_DEAL_SEQ.toString()));
      },
      child: Container(
          height: 162.spMin,
          padding: EdgeInsets.symmetric(vertical: 16.spMin),
          margin: EdgeInsets.symmetric(horizontal: 16.spMin),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black38))),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 90.spMin,
                    child: Image.network(widget.deal.B_COVER_IMG ?? "",
                        height: double.infinity, fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                      return Text(widget.deal.B_TITLE,
                          overflow: TextOverflow.ellipsis);
                    })),
                SizedBox(width: 16.spMin),
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("${widget.deal.B_BOOKSELF_NAME}책장의",
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(widget.deal.B_TITLE,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      Text(
                          "${widget.deal.B_AUTHOR.split(";").first} / ${widget.deal.B_PUBLISHER} / ${DateUtil.formatDate(widget.deal.B_ISSUE_DATE, format: "yyyy년 MM월")}"),
                      Text(
                          "${widget.deal.B_QULITY} | ${(int.parse(widget.deal.B_RENTAL_FEE) * int.parse(widget.deal.B_RENTAL_DAY))}원 (${widget.deal.B_RENTAL_DAY}일기준)",
                          style: TextStyle(color: Colors.blue[500])),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: rating.floor().toDouble(),
                                size: 20.0,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star,
                                color: Colors.yellow,
                                borderColor: Colors.yellow,
                                spacing: 0.0),
                            SizedBox(width: 8.spMin),
                            Text("(${rating.toStringAsFixed(1)})")
                          ])
                    ])),
                SizedBox(width: 16.spMin),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(DateUtil.beforeDate(widget.deal.B_REG_DATE))
                    ])
              ])),
    );
  }
}
