import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> login() async {
    await ref
        .watch(authNotifierProvider.notifier)
        .login(_controller.text)
        .then((_) {
      context.router.popTop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.spMin),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("로그인",
                          style: TextStyle(
                              fontSize: 24.spMin, fontWeight: FontWeight.w700)),
                      SizedBox(height: 16.spMin),
                      Text("휴대폰번호로 로그인해주세요.",
                          style: TextStyle(fontSize: 16.spMin)),
                      TextField(
                        keyboardType: TextInputType.number,
                        focusNode: _focusNode,
                        controller: _controller,
                        autofocus: true,
                        onTapOutside: (e) =>
                            _focusNode.hasFocus ? _focusNode.unfocus() : null,
                        style: const TextStyle(color: Colors.black87),
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
                                  backgroundColor: Colors.black87,
                                  foregroundColor: Colors.white),
                              onPressed: () async => await login(),
                              child: const Text("로그인"))),
                    ])))));
  }
}
