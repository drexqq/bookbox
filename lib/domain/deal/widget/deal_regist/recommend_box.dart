import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendBox extends ConsumerStatefulWidget {
  const RecommendBox({super.key});

  @override
  ConsumerState<RecommendBox> createState() => _RecommendBoxState();
}

class _RecommendBoxState extends ConsumerState<RecommendBox> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(dealRegistProvider).setDesc(null);
        return true;
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              onTapOutside: (e) =>
                  _focusNode.hasFocus ? _focusNode.unfocus() : null,
              onChanged: (value) {
                ref.read(dealRegistProvider).setDesc(value);
              },
              maxLines: null,
              minLines: 4,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )
          ]),
    );
  }
}
