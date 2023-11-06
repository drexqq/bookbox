import 'package:flutter/material.dart';

class UserBookboxNicknameSettingView extends StatefulWidget {
  const UserBookboxNicknameSettingView({super.key});

  @override
  State<UserBookboxNicknameSettingView> createState() =>
      _BookboxNicknameSettingViewState();
}

class _BookboxNicknameSettingViewState
    extends State<UserBookboxNicknameSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UserBookboxNicknameSettingView")),
    );
  }
}
