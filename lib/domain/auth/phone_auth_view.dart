import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/auth/provider/auth_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class PhoneAuthView extends ConsumerStatefulWidget {
  const PhoneAuthView({super.key});

  @override
  ConsumerState<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends ConsumerState<PhoneAuthView> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  late final FocusNode _authFocusNode;
  late final TextEditingController _authController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();

    _authFocusNode = FocusNode();
    _authController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _authFocusNode.dispose();
    _authController.dispose();
    super.dispose();
  }

  bool isSendSMS = false;
  String? authCode;

  Future<void> sendSMS() async {
    if (_controller.text == "" || _controller.text.isEmpty) {
      return;
    }
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .sendSms(_controller.text)
          .then((code) {
        if (code == "" || code == null) {
          Fluttertoast.showToast(
              msg: "인증문자 발송에 실패했습니다", gravity: ToastGravity.CENTER);
        } else {
          setState(() {
            isSendSMS = true;
            authCode = code;
          });
          Fluttertoast.showToast(
              msg: "인증문자를 발송했습니다", gravity: ToastGravity.CENTER);
        }
      });
    } catch (e) {
      throw Exception("Send SMS Failed");
    }
  }

  Future<void> authSMS() async {
    if (_authController.text != authCode) {
      Fluttertoast.showToast(msg: "인증 코드가 다릅니다", gravity: ToastGravity.CENTER);
      return;
    }
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .authSms(_controller.text)
          .then((result) {
        if (result) {
          context.router.pushAndPopUntil(const HomeViewRoute(),
              predicate: (Route<dynamic> route) => false);
        }
      });
    } catch (e) {
      throw Exception("Auth SMS Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.spMin),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("휴대폰번호 인증",
                          style: TextStyle(
                              fontSize: 24.spMin, fontWeight: FontWeight.w700)),
                      SizedBox(height: 16.spMin),
                      Text("회원가입용이며, 타인에게 보여지지 않습니다.",
                          style: TextStyle(fontSize: 16.spMin)),
                      TextField(
                        keyboardType: TextInputType.number,
                        readOnly: isSendSMS,
                        focusNode: _focusNode,
                        controller: _controller,
                        autofocus: true,
                        onTapOutside: (e) =>
                            _focusNode.hasFocus ? _focusNode.unfocus() : null,
                        style: TextStyle(
                            color: isSendSMS ? Colors.black38 : Colors.black87),
                        decoration:
                            const InputDecoration(hintText: "01012341234"),
                      ),
                      SizedBox(height: 32.spMin),
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor:
                                      !isSendSMS ? Colors.black87 : Colors.grey,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (!isSendSMS) {
                                  await sendSMS();
                                }
                              },
                              child: const Text("인증문자 보내기"))),
                      if (isSendSMS) authField()
                      // authField()
                    ])))));
  }

  Widget authField() {
    return Column(
      children: [
        SizedBox(height: 16.spMin),
        TextField(
          keyboardType: TextInputType.number,
          focusNode: _authFocusNode,
          controller: _authController,
          autofocus: true,
          onTapOutside: (e) =>
              _authFocusNode.hasFocus ? _authFocusNode.unfocus() : null,
          decoration: const InputDecoration(hintText: "인증번호를 입력해주세요"),
        ),
        SizedBox(height: 16.spMin),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white),
              onPressed: () async => await sendSMS(),
              child: const Text("인증문자 다시 보내기")),
        ),
        SizedBox(height: 16.spMin),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white),
              onPressed: () async => await authSMS(),
              child: const Text("인증하기")),
        ),
      ],
    );
  }
}
