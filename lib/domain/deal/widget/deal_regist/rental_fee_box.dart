import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RentalFeeBox extends ConsumerStatefulWidget {
  const RentalFeeBox({super.key});

  @override
  ConsumerState<RentalFeeBox> createState() => _RentalFeeBoxState();
}

class _RentalFeeBoxState extends ConsumerState<RentalFeeBox> {
  late final TextEditingController _periodController;
  late final TextEditingController _feeController;
  late final FocusNode _periodFocusNode;
  late final FocusNode _feeFocusNode;

  @override
  void initState() {
    super.initState();
    _periodController = TextEditingController();
    _feeController = TextEditingController();
    _periodFocusNode = FocusNode();
    _feeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _periodController.dispose();
    _feeController.dispose();
    _periodFocusNode.dispose();
    _feeFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(dealRegistProvider).setDay(null);
        ref.read(dealRegistProvider).setFee(null);
        return true;
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Expanded(flex: 4, child: Text("권당 최대 대여기간")),
              Expanded(
                  flex: 4,
                  child: TextField(
                      controller: _periodController,
                      focusNode: _periodFocusNode,
                      onTapOutside: (e) => _periodFocusNode.hasFocus
                          ? _periodFocusNode.unfocus()
                          : null,
                      textAlign: TextAlign.right,
                      onChanged: (value) {
                        ref.read(dealRegistProvider).setDay(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Text('일'),
                          ),
                        ),
                      )))
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Expanded(flex: 4, child: Text("하루 대여가 입력")),
              Expanded(
                  flex: 4,
                  child: TextField(
                      controller: _feeController,
                      focusNode: _feeFocusNode,
                      onTapOutside: (e) => _feeFocusNode.hasFocus
                          ? _feeFocusNode.unfocus()
                          : null,
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        ref.read(dealRegistProvider).setFee(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Text('원'),
                          ),
                        ),
                      )))
            ])
          ]),
    );
  }
}
