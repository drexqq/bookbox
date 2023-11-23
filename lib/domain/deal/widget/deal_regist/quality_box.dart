import 'dart:io';

import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/util/permission_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class QualityBox extends ConsumerStatefulWidget {
  const QualityBox({super.key});

  @override
  ConsumerState<QualityBox> createState() => _QualityBoxState();
}

class _QualityBoxState extends ConsumerState<QualityBox> {
  late final ImagePicker _picker;
  List<XFile> images = [];
  void setImages(List<XFile> imgs) {
    setState(() {
      images = imgs;
    });
  }

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setQuality(String value) {
    ref.read(dealRegistProvider).setQuality(value);
  }

  @override
  Widget build(BuildContext context) {
    final quality = ref.watch(dealRegistProvider).quality;
    return WillPopScope(
        onWillPop: () async {
          setQuality("S");
          ref.read(dealRegistProvider).setImg([]);
          return true;
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Checkbox(
                    value: quality == "S",
                    onChanged: (_) => setQuality("S"),
                    shape: const CircleBorder()),
                const Text("특급: 새 책과 품질이 같음")
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Checkbox(
                    value: quality == "A",
                    onChanged: (_) => setQuality("A"),
                    shape: const CircleBorder()),
                const Text("고급: 사용감이 적고 깨끗한 도서")
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Checkbox(
                    value: quality == "B",
                    onChanged: (_) => setQuality("B"),
                    shape: const CircleBorder()),
                const Text("중급: 사용감이 많고 깨끗한 도서")
              ]),
              const SizedBox(height: 10),
              const Text("[필수] 소장도서의 모습을 찍어주세요",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10, children: [
                GestureDetector(
                    onTap: () async {
                      // TODO
                      print("OPEN GALLERY");
                      await PermissionHelper.requestPhotoLibraryPermission();
                      final imgs = await _picker.pickMultiImage();
                      setImages(imgs);
                      ref.read(dealRegistProvider).setImg(imgs);
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt_rounded),
                              Text("${images.length} / 3")
                            ]))),
                for (final img in images) _photo(img)
              ])
            ]));
  }

  Widget _photo(XFile img) {
    return GestureDetector(
      onTap: () {
        images.remove(img);
        setState(() {});
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.file(File(img.path), fit: BoxFit.cover),
        // child: CachedNetworkImage(
        //   fit: BoxFit.cover,
        //   imageUrl: "",
        //   placeholder: (context, url) => const CircularProgressIndicator(),
        //   errorWidget: (context, url, error) => Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 1),
        //         borderRadius: BorderRadius.circular(5)),
        //     child: Container(color: Colors.red),
        //   ),
        // ),
      ),
    );
  }
}
