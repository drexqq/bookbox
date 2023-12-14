import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class BookScanHistoryView extends ConsumerStatefulWidget {
  const BookScanHistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookScanHistoryViewState();
}

class _BookScanHistoryViewState extends ConsumerState<BookScanHistoryView> {
// http://bookbox.oneidlab.kr/api/my_scan_orders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("북스캔 신청 내역"), centerTitle: false),
        body: FutureBuilder(
            future: ref.read(userProvider).getScanOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              final data = snapshot.data;
              final len = data.length;

              if (len == 0) {
                return const Center(child: Text("북스캔 내역이 없습니다."));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 12);
                    },
                    itemCount: len,
                    itemBuilder: (_, index) {
                      final info = data[index];
                      print(info["S_STATUS"]);
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getStatus(info["S_STATUS"])),
                            const SizedBox(height: 6),
                            Text(info["B_TITLE"] ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 6),
                            Text(
                                "${info["B_AUTHOR"] ?? ""} / ${info["B_PUBLISHER"] ?? ""} / ${info["B_ISSUE_DATE"] ?? ""}"),
                            const SizedBox(height: 6),
                            Text("${info["B_POINT"] ?? ""}P"),
                          ],
                        ),
                      );
                    }),
              );
            }));
  }

  String getStatus(String status) {
    switch (status) {
      case "P":
        return "제공완료";
      case "S":
        return "신청완료";
      case "W":
        return "처리중";
      default:
        return "";
    }
  }
}
