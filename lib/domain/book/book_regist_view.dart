import 'package:flutter/material.dart';

class BookRegistView extends StatefulWidget {
  const BookRegistView({super.key});

  @override
  State<BookRegistView> createState() => _BookRegistViewState();
}

class _BookRegistViewState extends State<BookRegistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BookRegistView")),
    );
  }
}
