import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DifficultyBox extends ConsumerStatefulWidget {
  const DifficultyBox({super.key});

  @override
  ConsumerState<DifficultyBox> createState() => _DifficultyBoxState();
}

class _DifficultyBoxState extends ConsumerState<DifficultyBox> {
  void setLevel(String value) {
    ref.read(dealRegistProvider).setLevel(value);
  }

  @override
  Widget build(BuildContext context) {
    final level = ref.watch(dealRegistProvider).level;

    return WillPopScope(
      onWillPop: () async {
        setLevel("A");
        return true;
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Checkbox(
                  value: level == "A",
                  onChanged: (_) => setLevel("A"),
                  shape: const CircleBorder()),
              const Text("(쉬움): 쉽게 일혀요")
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Checkbox(
                  value: level == "B",
                  onChanged: (_) => setLevel("B"),
                  shape: const CircleBorder()),
              const Text("(중간): 보통이에요")
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Checkbox(
                  value: level == "C",
                  onChanged: (_) => setLevel("C"),
                  shape: const CircleBorder()),
              const Text("(어려움): 여러 번 멈춰서 읽어야해요")
            ]),
          ]),
    );
  }
}
