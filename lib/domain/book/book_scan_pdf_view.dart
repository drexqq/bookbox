import 'dart:async';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

@RoutePage()
class BookScanPdfView extends StatefulWidget {
  final String title;
  final String path;
  final String filename;
  const BookScanPdfView({
    super.key,
    required this.title,
    required this.path,
    required this.filename,
  });

  @override
  State<BookScanPdfView> createState() => _BookScanPdfViewState();
}

class _BookScanPdfViewState extends State<BookScanPdfView>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  int? totalPage = 0;
  bool isReady = false;
  String errorMessage = '';

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      // null;
    }

    return completer.future;
  }

  String? corruptedPathPDF;
  @override
  void initState() {
    super.initState();
    fromAsset(widget.path, widget.filename).then((f) {
      setState(() {
        corruptedPathPDF = f.path;
      });
    });

    // fromAsset("assets/books/book2.pdf", 'book2.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: false),
        body: Stack(children: [
          corruptedPathPDF != null && corruptedPathPDF != ""
              ? PDFView(
                  filePath: corruptedPathPDF,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage!,
                  fitPolicy: FitPolicy.BOTH,
                  // if set to true the link is handled in flutter
                  preventLinkNavigation: false,
                  onRender: (pages) {
                    setState(() {
                      pages = pages;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onLinkHandler: (String? uri) {
                    print('goto uri: $uri');
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                    setState(() {
                      currentPage = page;
                      totalPage = total;
                    });
                  })
              : const SizedBox(),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
              : Center(child: Text(errorMessage))
        ]),
        floatingActionButton: FutureBuilder<PDFViewController>(
            future: _controller.future,
            builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData) {
                return Text("$currentPage / $totalPage");
              }
              return Container();
            }));
  }
}
