import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealDetailMeta extends StatelessWidget {
  final String? cover;
  final String? userName;
  final String? title;
  final String? rate;
  final List<String>? rating;
  final String? author;
  final String? publisher;
  final String? quality;
  final String? issueDate;
  final String? description;
  const DealDetailMeta({
    super.key,
    required this.cover,
    required this.userName,
    required this.title,
    required this.rate,
    required this.rating,
    required this.author,
    required this.publisher,
    required this.quality,
    required this.issueDate,
    required this.description,
  });
  String levelToText(String level) {
    switch (level) {
      case "A":
        return "쉽게 읽혀요";
      case "B":
        return "보통이에요";
      case "C":
        return "여러 번 멈춰서 읽어야해요";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultRate = List.generate(6, (_) => "0");
    final ratingSum = (rating ?? defaultRate).map((e) {
          return int.parse(e);
        }).reduce((a, b) => a + b) /
        6;
    return Column(
      children: [
        SizedBox(
            height: ScreenUtil().screenHeight * .3,
            child: Stack(children: [
              Container(
                  decoration: BoxDecoration(
                      image: cover != null && cover != ""
                          ? DecorationImage(
                              image: NetworkImage(cover!), fit: BoxFit.cover)
                          : null),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 0),
                    child: Container(color: Colors.white.withOpacity(0.5)),
                  )),
              Positioned(
                  child: Center(
                      child: cover != null && cover != ""
                          ? CachedNetworkImage(
                              imageUrl: cover ?? "", fit: BoxFit.cover)
                          : const SizedBox.shrink()))
            ])),
        Container(
          width: double.infinity,
          color: Colors.grey[200],
          padding: EdgeInsets.all(16.spMin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18.spMin)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(TextSpan(children: [
                    const WidgetSpan(child: Icon(Icons.star, size: 20)),
                    const WidgetSpan(child: SizedBox(width: 6)),
                    TextSpan(
                        text: ratingSum.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 20))
                  ])),
                  const SizedBox(width: 20),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(levelToText(rate ?? ""))),
                  // const SizedBox(width: 20),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(),
                  //       borderRadius: BorderRadius.circular(20)),
                  //   child: const Text("유익"),
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bullet(
                    author ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Bullet(
                    publisher ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  if (issueDate != null)
                    Bullet(
                      issueDate!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
              const SizedBox(height: 20),
              Text("추천서",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18.spMin)),
              const SizedBox(height: 20),
              Text(description ?? ""),
              const SizedBox(height: 20),
              Text("책 상태",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18.spMin)),
              Text("$rate급"),
              const SizedBox(height: 20),
              Center(
                child: Text("$userName님의 책장",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18.spMin)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String qualityToText(String quality) {
    switch (quality) {
      case "S":
        return "특급: 새 책과 품질이 같음";
      case "A":
        return "고급: 사용감이 적고 깨끗한 도서";
      case "B":
        return "중급: 사용감이 많고 깨끗한 도서";
      default:
        return "";
    }
  }
}

class Bullet extends Text {
  const Bullet(
    String data, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          '• $data',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
