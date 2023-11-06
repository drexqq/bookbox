import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealDetailPreview extends StatefulWidget {
  final String? preview;
  const DealDetailPreview({
    super.key,
    this.preview,
  });

  @override
  State<DealDetailPreview> createState() => _DealDetailPreviewState();
}

class _DealDetailPreviewState extends State<DealDetailPreview> {
  bool isExpand = false;
  void toggleExpand() {
    setState(() => isExpand = !isExpand);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.spMin),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.spMin, color: Colors.black45),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                          const TextSpan(children: [
                            WidgetSpan(child: Icon(Icons.attachment)),
                            WidgetSpan(child: SizedBox(width: 8)),
                            TextSpan(text: "이런 내용이에요"),
                          ]),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.spMin)),
                      GestureDetector(
                          onTap: toggleExpand,
                          child: Text.rich(TextSpan(children: [
                            const WidgetSpan(child: Center(child: Text("보기"))),
                            WidgetSpan(
                                child: Icon(isExpand
                                    ? Icons.keyboard_arrow_up_outlined
                                    : Icons.keyboard_arrow_down_outlined))
                          ])))
                    ],
                  ),
                  if (isExpand && widget.preview != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(widget.preview ?? ""),
                    ),
                ],
              ))
        ]));
  }
}
