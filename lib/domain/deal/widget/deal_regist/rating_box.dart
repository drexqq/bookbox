import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingBox extends ConsumerStatefulWidget {
  const RatingBox({super.key});

  @override
  ConsumerState<RatingBox> createState() => _RatingBoxState();
}

class _RatingBoxState extends ConsumerState<RatingBox> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(dealRegistProvider).clearRating();
        return true;
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("재밌어요"),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  ref.read(dealRegistProvider).setRating(0, value.toInt());
                },
                itemSize: 30,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
              )
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("몰입되요"),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  ref.read(dealRegistProvider).setRating(1, value.toInt());
                },
                itemSize: 30,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
              )
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("유익해요"),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  ref.read(dealRegistProvider).setRating(2, value.toInt());
                },
                itemSize: 30,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
              )
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("기발해요"),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  ref.read(dealRegistProvider).setRating(3, value.toInt());
                },
                itemSize: 30,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
              )
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("감동적이에요"),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  ref.read(dealRegistProvider).setRating(4, value.toInt());
                },
                itemSize: 30,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
              )
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("스릴넘쳐요"),
              RatingBar.builder(
                onRatingUpdate: (value) {
                  ref.read(dealRegistProvider).setRating(5, value.toInt());
                },
                itemSize: 30,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
              )
            ]),
            // const SizedBox(height: 10),
            // const Text("총 평점 0.0점",
            //     style: TextStyle(fontWeight: FontWeight.bold))
          ]),
    );
  }
}
