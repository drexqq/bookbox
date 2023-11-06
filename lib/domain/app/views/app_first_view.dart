import 'package:auto_route/auto_route.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFirstView extends StatelessWidget {
  const AppFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.spMin),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Expanded(
                        child: Container(
                            width: double.infinity, color: Colors.red)),
                    SizedBox(height: 32.spMin),
                    SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.black87,
                                foregroundColor: Colors.white),
                            onPressed: () =>
                                context.router.push(const PhoneAuthViewRoute()),
                            child: const Text("도서공유 서비스 시작하기"))),
                    SizedBox(height: 16.spMin),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("이미 계정이 있나요?",
                              style: TextStyle(fontSize: 16.spMin)),
                          TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: Colors.black87),
                              onPressed: () =>
                                  context.router.push(const LoginViewRoute()),
                              child: const Text("로그인"))
                        ])
                  ]))),
        ));
  }
}
