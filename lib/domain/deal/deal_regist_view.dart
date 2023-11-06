import 'package:auto_route/annotations.dart';
import 'package:bookbox/domain/book/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    print(widget.book);
    return Scaffold(
        appBar: AppBar(title: const Text("대여 등록")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.book.B_COVER_IMG ?? "",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child:
                                  Center(child: Text(widget.book.B_TITLE))))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(widget.book.B_TITLE),
                        Text(widget.book.B_AUTHOR ?? "",
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis))
                      ])),
                ])),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Text("품질 상태"),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Container(child: const Text("책 정보")),
            const SizedBox(height: 10),
            Container(child: const Text("책 정보")),
          ])),
        ));
  }
}
