import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserBookRegistSelectView extends StatelessWidget {
  const UserBookRegistSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("소장 책 등록"), surfaceTintColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  context.router
                      .push(UserBookRegistViewRoute(notifyParent: () {}));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7))
                      ]),
                  child: const Row(
                    children: [
                      Icon(Icons.document_scanner_outlined),
                      SizedBox(width: 12),
                      Text("책 뒷면 바코드 촬영")
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () {
                  context.router
                      .push(UserBookRegistViewRoute(notifyParent: () {}));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7))
                      ]),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 12),
                      Text("직접 검색하기")
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
