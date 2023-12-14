// import 'dart:async';
// import 'dart:convert';

// import 'package:auto_route/auto_route.dart';
// import 'package:bookbox/domain/chat/repository/chat_repository.dart';
// import 'package:bookbox/domain/chat/sendbird/sendbird.dart';
// import 'package:bookbox/router/router.gr.dart';
// import 'package:bookbox/util/map_helper.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// @RoutePage()
// class ChatView extends ConsumerStatefulWidget {
//   const ChatView({super.key, required this.dealId, required this.row});

//   final dealId;
//   final Map<String, dynamic> row;
//   @override
//   ConsumerState<ChatView> createState() => ChatViewState();
// }

// class ChatViewState extends ConsumerState<ChatView>
//     with WidgetsBindingObserver {
//   bool isLoading = false;
//   void setIsLoading(bool val) {
//     setState(() {
//       isLoading = val;
//     });
//   }

//   dynamic rowBookbox;
//   dynamic rentalInfo;
//   dynamic session;

//   String myUserId = "";
//   String myUserName = "";
//   // final userPosterImageUrl = "https://cdn.spotvnews.co.kr/news/photo/201904/281496_346747_5322.jpg";
//   String userPosterImageUrl = "assets/images/profile.jpeg";
//   final recentTime = "1시간 전";

//   bool isMySupply = false;
//   String bookName = "";
//   String userName = "";
//   String? status = "";
//   String imageUrl = "";
//   String userId = "";
//   String qr = "";

//   int statusIndex = 2;
//   late OpenChannel? openChannel;
//   late GroupChannel? groupChannel;
//   late List<BaseMessage>? messages;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _fetch();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     SendBird.eventHandlerDispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // debugPrint("row::::: ${widget.row}");

//     imageUrl = widget.row["B_COVER_IMG"] ??
//         "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192300818.jpg";
//     bookName = widget.row["B_TITLE"];
//     userName = widget.row["B_BOOKSELF_NAME"];

//     userId = widget.row["R_MEM_SEQ"] ?? widget.row["D_MEM_SEQ"];
//     isMySupply = widget.row["D_MEM_SEQ"] == null ? true : false;

//     final time = widget.row["B_REG_DATE"];

//     if (userId == "23") {
//       userPosterImageUrl = "assets/images/profile.jpeg";
//     } else if (userId == "20") {
//       userPosterImageUrl = "assets/images/profile1.jpeg";
//     } else {
//       userPosterImageUrl = "assets/images/profile2.jpeg";
//     }

//     SendBird.eventHandlerInit(callBack: mySetState);

//     return Scaffold(
//       appBar: AppBar(
//           title: Column(children: [
//             const SizedBox(height: 8),
//             Row(children: [
//               _profileImage(),
//               const SizedBox(width: 10),
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Row(children: [
//                   Text(userName, style: const TextStyle(fontSize: 20)),
//                   const SizedBox(width: 8),
//                   _statusText(status),
//                   // FutureBuilder(
//                   //     future: _fetch(),
//                   //     builder:
//                   //         (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                   //       if (snapshot.connectionState ==
//                   //           ConnectionState.waiting) {
//                   //         return const SizedBox(height: 0);
//                   //       } else if (snapshot.hasError) {
//                   //         return const SizedBox(height: 0);
//                   //       } else {
//                   //         return _statusText(status);
//                   //       }
//                   //     })
//                 ])
//                 // Text("마지막 활동: $recentTime", style: TextStyle(fontSize: 12)),
//               ])
//             ])
//           ]),
//           actions: [
//             GestureDetector(
//                 onTap: _showModal,
//                 child: const Column(children: [
//                   SizedBox(height: 16),
//                   Row(children: [
//                     Icon(Icons.book),
//                     Text("책 정보"),
//                     SizedBox(width: 8)
//                   ])
//                 ]))
//           ],
//           bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(0), child: _divider())),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: !isLoading
//             ? const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [CircularProgressIndicator()])
//             : ListView.builder(
//                 itemCount: statusIndex + 1,
//                 itemBuilder: (BuildContext context, int index) {
//                   return _temp(index);
//                 }),
//       ),
//     );
//   }

// //말풍선 뭐 띄울지 정하는 함수... 그지같은 구조라 지송
// //progress는 버튼 누를때마다 sendBird 채팅창 metadata의 statusIndex를 증가 시키는 방식으로
// //FutureBuilder의 fetch 함수에서 채팅창 statusIndex 받아옵니다
//   Widget _temp(int index) {
//     DateTime first = DateTime.parse(rentalInfo["B_REG_DATE"]);

//     switch (index) {
//       //초기 index는 2입니다
//       case 0: //안녕하세요 ~~님
//         return _row(
//             timeWidget: _timeWidget("${first.hour}:${first.minute}"),
//             messageWidget: _requestRental0(),
//             userId: isMySupply ? userId : myUserId);

//       case 1: //북박스 장소 + 시간 표시
//         return _row(
//             timeWidget: _timeWidget("${first.hour}:${first.minute}"),
//             messageWidget: _requestRental1(),
//             userId: isMySupply ? userId : myUserId);

//       case 2: //초기 index는 2입니다
//         if (statusIndex > 2) {
//           // 공급자가 제안 수락한 경우 (statusIndex 3 이상)
//           final time =
//               DateTime.fromMillisecondsSinceEpoch(messages![0].createdAt);
//           return _row(
//               timeWidget: _timeWidget("${time.hour}:${time.minute}"),
//               messageWidget: _responseRental01(),
//               userId: !isMySupply ? userId : myUserId);
//         } else {
//           // 대여자가 상대방의 수락 기다리는 중 표시
//           if (!isMySupply) {
//             return _showAlertWaiting();
//           } else {
//             //공급자의 제안 수락 or 거절 버튼 (제안 수락 눌럿을 때 센드버드 채팅방 개설)
//             return _row(
//                 timeWidget: const SizedBox(
//                   width: 0,
//                 ),
//                 messageWidget: _responseRental00(),
//                 userId: !isMySupply ? userId : myUserId);
//           }
//         }

//       case 3:
//         if (statusIndex > 3) {
//           //제안 수락을 대여자가 확인했을 경우 (statusIndex 4이상 )
//           final time =
//               DateTime.fromMillisecondsSinceEpoch(messages![1].createdAt);
//           return _row(
//               timeWidget: _timeWidget("${time.hour}:${time.minute}"),
//               messageWidget: _requestRental21(),
//               userId: isMySupply ? userId : myUserId);
//         } else {
//           // 공급자가 상대방의 확인 기다리는 중 표시
//           if (isMySupply) {
//             return _showAlertWaiting();
//           }
//           return _row(
//               // 대여자의 확인했어요 버튼 표시
//               timeWidget: const SizedBox(
//                 width: 0,
//               ),
//               messageWidget: _requestRental20(),
//               userId: isMySupply ? userId : myUserId);
//         }

//       case 4:
//         if (statusIndex > 4) {
//           // 공급자가 입고를 완료한 경우
//           return _showAlert1();
//         }

//         if (!isMySupply) {
//           //대여자에게 입고 기다리는 중 표시
//           return _showAlert0();
//         } else {
//           // 공급자의 입고 완료 버튼 표시 (입고 완료 누르면 이번에만 statusIndex를 두개 올려서 4 -> 6 됩니다)
//           return _showAlert01();
//         }

//       case 5: // 대여를 시작합니다 위젯
//         return _showAlert2();

//       case 6: // 반납 일정이 되었습니다 위젯
//         if (statusIndex > 6) {
//           //반납이 완료 된 경우
//           return _showAlert4();
//         } else {
//           DateTime dateEnd = DateTime.parse(rentalInfo["B_PERIOD_END"]);
//           DateTime now = DateTime.now();
//           if (now.isAfter(dateEnd)) {
//             //반납 기한이 된 경우
//             if (isMySupply) {
//               //공급자에게 반납을 기다리는중 표시
//               return _showAlert31();
//             } else {
//               return _showAlert3();
//             }
//           } else {
//             // 반납 기한 안된경우 그냥 빈 위젯
//             return const SizedBox(
//               height: 0,
//             );
//           }
//         }

//       case 7:
//         if (!isMySupply) {
//           return _showAlert5(); //리뷰 남겨주세요
//         } else {
//           if (statusIndex > 7) {
//             //수거가 완료 된 경우
//             return _showAlert7();
//           }
//           return _showAlert6(); //수거 완료 버튼 있는 위젯
//         }

//       case 8:
//         return _showAlert8();
//     }

//     return _showAlert8();
//   }

// // 책정보 표시 모달 위젯
//   void _showModal() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(bookName),
//                 // _textButton(onPressedCallBack: () async { _reset(status!); }, text: "api status 리셋 (센드버드는 수동으로..)")
//               ],
//             ),
//             content: CachedNetworkImage(
//               width: 200,
//               imageUrl: imageUrl,
//             ),
//             // content: Image.asset(
//             //   imageUrl,
//             //   width: 200,
//             //   ),
//           );
//         });
//   }

// // 북박스 위치 모달 위젯
//   void _showModal2() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("북박스 장소 보기"),
//             content: _requestRental1(),
//           );
//         });
//   }

// //qr코드 모달 위젯
//   void _showModal3() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           // debugPrint(qr);
//           return AlertDialog(
//             title: const Text(""),
//             content: SizedBox(
//               width: 280,
//               height: 280,
//               child: QrImageView(
//                 data: qr,
//                 version: QrVersions.auto,
//                 size: 280,
//               ),
//             ),
//           );
//         });
//   }

//   Widget _profileImage() {
//     // return ClipOval(
//     //   child: CachedNetworkImage(
//     //     width: 36,
//     //     height: 36,
//     //     fit: BoxFit.cover,
//     //     imageUrl: userPosterImageUrl,
//     //     ),
//     // );
//     return ClipOval(
//       child: Image.asset(userPosterImageUrl,
//           width: 36, height: 36, fit: BoxFit.cover),
//     );
//   }

//   //시간 + 말풍선표시, 좌측 or 우측 정렬(누가 톡보낸건지) Row
//   Widget _row({
//     required Widget timeWidget,
//     required Widget messageWidget,
//     required String userId,
//   }) {
//     // debugPrint("userId :: $userId // myUserId :: $myUserId");

//     if (userId == myUserId) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           timeWidget,
//           const SizedBox(
//             width: 4,
//           ),
//           messageWidget,
//         ],
//       );
//     } else {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           _profileImage(),
//           const SizedBox(
//             width: 4,
//           ),
//           messageWidget,
//           const SizedBox(
//             width: 4,
//           ),
//           timeWidget,
//         ],
//       );
//     }
//   }

//   //시간표시위젯
//   Widget _timeWidget(String time) {
//     return Column(
//       children: [
//         Text(time),
//         const SizedBox(
//           height: 8,
//         )
//       ],
//     );
//   }

//   Widget _divider() {
//     return Container(
//       height: 0.8,
//       color: Colors.black45,
//     );
//   }

//   // 말풍선 프레임
//   Widget _bubbleContainer({required Widget widget, required double width}) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black54),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           width: width,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: widget,
//           ),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//       ],
//     );
//   }

//   // 안녕하세요~~ 대여 시작하는 첫 말풍선 위젯
//   Widget _requestRental0() {
//     DateTime dateStart = DateTime.parse(rentalInfo["B_PERIOD_START"]);
//     DateTime dateEnd = DateTime.parse(rentalInfo["B_PERIOD_END"]);

//     return _bubbleContainer(
//         widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text("안녕하세요 $userName님 !"),
//           const Text("총 1권을 대여하고 싶어요."),
//           const SizedBox(
//             height: 8,
//           ),
//           _divider(),
//           const SizedBox(
//             height: 8,
//           ),
//           Text(
//               "대여시작일: ${dateStart.year}년 ${dateStart.month}월 ${dateStart.day}일"),
//           Text("대여종료일: ${dateEnd.year}년 ${dateEnd.month}월 ${dateEnd.day}일"),
//           const SizedBox(
//             height: 8,
//           ),
//           _divider(),
//           const SizedBox(
//             height: 8,
//           ),
//           const Text("대출 도서명"),
//           Text(bookName, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ]),
//         width: 268);
//   }

//   //북박스 장소 및 시간 등등 표시 위젯
//   Widget _requestRental1() {
//     MapHelper mapHelper = MapHelper();
//     // final a = ["B_STORE_POSITION"].;

//     return _bubbleContainer(
//         widget: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "O 북박스 장소",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 220,
//                   height: 220,
//                   child: mapHelper.drawMapByPosition(37.402995, 127.099149),
//                 ),
//               ],
//             ),

//             const SizedBox(
//               height: 8,
//             ),
//             Text(
//               rowBookbox["B_STORE_NAME"],
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(widget.row["B_STORE_ADDRESS"]),
//             // SizedBox(height: 12,),
//             Container(
//               width: 270,
//             ),
//             const Text(
//               "O 운영시간",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text("- 평일 ${rentalInfo["B_START_1"]} ~ ${rentalInfo["B_END_1"]}"),
//             Text("- 주말 ${rentalInfo["B_START_6"]} ~ ${rentalInfo["B_END_6"]}"),
//             rentalInfo["B_DAY_CLOSE_H"] == "Y"
//                 ? const Text("- 공휴일 운영")
//                 : const Text("- 공휴일 미운영"),
//           ],
//         ),
//         width: 270);
//   }

//   //확인했어요 버튼 있는 위젯 (공급자가 제안 수락 후)
//   Widget _requestRental20() {
//     return _bubbleContainer(
//         widget: Column(
//           children: [
//             _textButton(
//                 onPressedCallBack: () async {
//                   await groupChannel!.updateMetaData({"statusIndex": "4"});

//                   final ChatRepository repository =
//                       ref.read(chatRepositoryProvider);
//                   await repository.progressStatus(
//                       widget.row["B_RENTAL_SEQ"], myUserId, "B");

//                   await _sendStatusIndexMsg(
//                       groupChannel!, "4", "_requestRental20");

//                   setState(() {});
//                 },
//                 text: "확인했어요"),
//             const Text("[확인] 버튼을 눌러야 거래가 시작됩니다."),
//           ],
//         ),
//         width: 270);
//   }

//   //확인했어요 글자만 있는 위젯
//   Widget _requestRental21() {
//     return _bubbleContainer(widget: const Text("확인했어요!"), width: 88);
//   }

// /////////////////////////////////////////////////
//   ///
// //제안 수락 or 거절 버튼 위젯
//   Widget _responseRental00() {
//     return _bubbleContainer(
//         widget: Column(
//           children: [
//             _textButton(
//                 onPressedCallBack: () async {
//                   _createGroupChat();

//                   setState(() {});
//                 },
//                 text: "제안 수락"),
//             _textButton(onPressedCallBack: _dummy, text: "제안 거절"),
//           ],
//         ),
//         width: 128);
//   }

// //제안 수락 후 제안 받아드릴게요 표시 위젯
//   Widget _responseRental01() {
//     DateTime dateStart = DateTime.parse(rentalInfo["B_PERIOD_START"]);
//     final user = isMySupply ? userName : myUserName;
//     return _bubbleContainer(
//         widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text("$user님 제안을 받아드릴게요!"),
//           Text(
//               "${dateStart.year}년 ${dateStart.month}월 ${dateStart.day}일까지 입고하도록 할게요!"),
//         ]),
//         width: 268);
//   }

//   //보내주신 제안이 맞지않아 거절합니다 위젯
//   Widget _responseRental02() {
//     return _bubbleContainer(
//         widget: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("죄송해요. 보내주신 제안이 맞지 않아 거절합니다."),
//             Text("좋은 거래를 통해 다시 만나요!"),
//           ],
//         ),
//         width: 268);
//   }

// ////////////////////////////////////////////////////////
//   //가운데 표시되는 회색 컨테이너
//   Widget _alertContainer({
//     required Widget widget,
//     Color color = Colors.black26,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black54),
//               borderRadius: BorderRadius.circular(10),
//               color: color,
//             ),
//             width: 270,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: widget,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //공급자가 입고를 진행하고 있습니다 위젯
//   Widget _showAlert0() {
//     return _alertContainer(
//       widget: Column(
//         children: [
//           const Text("공급자가 입고를 진행하고 있습니다."),
//           _textButton(
//             onPressedCallBack: _showModal2,
//             text: "북박스 위치 보기",
//           ),
//         ],
//       ),
//     );
//   }

//   //입고 버튼 위젯
//   Widget _showAlert01() {
//     return _alertContainer(
//         widget: Column(
//       children: [
//         const Text("입고 완료 후 아래 버튼을 눌러주세요"),
//         _textButton(
//             onPressedCallBack: () async {
//               await groupChannel!.updateMetaData({"statusIndex": "6"});

//               final ChatRepository repository =
//                   ref.read(chatRepositoryProvider);
//               await repository.progressStatus(
//                   widget.row["B_RENTAL_SEQ"], myUserId, "C");

//               await _sendStatusIndexMsg(groupChannel!, "6", "_showAlert01");
//               await SendBird.setScheduledMessage(
//                   groupChannel!,
//                   widget.row["B_TITLE"],
//                   DateTime.parse(rentalInfo["B_RETURN_TIME"]));

//               setState(() {});
//             },
//             text: "입고 완료"),
//       ],
//     ));
//   }

//   //입고가 완료되었습니다 위젯
//   Widget _showAlert1() {
//     return _alertContainer(
//       widget: Column(
//         children: [
//           const Text("입고가 완료되었습니다."),
//           const Text("대여를 위한 QR코드 입니다."),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _textButton(
//                 onPressedCallBack: _showModal2,
//                 text: "북박스 위치 보기",
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               _textButton(
//                 onPressedCallBack: _showModal3,
//                 text: "QR코드",
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   //대여를 시작합니다 위젯
//   Widget _showAlert2() {
//     DateTime dateEnd = DateTime.parse(rentalInfo["B_PERIOD_END"]);

//     return _alertContainer(
//       widget: Column(children: [
//         const Text("대여를 시작합니다."),
//         const SizedBox(
//           height: 8,
//         ),
//         const Text("반납 예정일"),
//         Text("${dateEnd.year}년 ${dateEnd.month}월 ${dateEnd.day}일까지"),
//       ]),
//     );
//   }

//   //반납 일정이 되었습니다 + 반납 완료버튼 위젯
//   Widget _showAlert3() {
//     return _alertContainer(
//       widget: Column(
//         children: [
//           const Text("반납 일정이 되었습니다."),
//           const Text("반납을 위한 QR코드 입니다."),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _textButton(
//                 onPressedCallBack: _showModal2,
//                 text: "북박스 위치 보기",
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               _textButton(
//                 onPressedCallBack: _showModal3,
//                 text: "QR코드",
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           const Text("반납 완료 후 아래 버튼을 눌러주세요"),
//           _textButton(
//               onPressedCallBack: () async {
//                 await groupChannel!.updateMetaData({"statusIndex": "7"});

//                 final ChatRepository repository =
//                     ref.read(chatRepositoryProvider);
//                 await repository.progressStatus(
//                     widget.row["B_RENTAL_SEQ"], myUserId, "D");

//                 await _sendStatusIndexMsg(groupChannel!, "7", "_showAlert3");

//                 setState(() {});
//               },
//               text: "반납 완료"),
//         ],
//       ),
//     );
//   }

//   //도서 반납을 기다리고 있습니다 위젯
//   Widget _showAlert31() {
//     return _alertContainer(
//         widget: const Column(children: [
//       Text("반납 일정이 되었습니다."),
//       Text("도서 반납을 기다리고 있습니다."),
//     ]));
//   }

//   //반납이 완료되었습니다 위젯
//   Widget _showAlert4() {
//     return _alertContainer(
//       widget: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("반납이 완료되었습니다."),
//         ],
//       ),
//     );
//   }

//   //책에 대한 평가를 남겨주세요 위젯
//   Widget _showAlert5() {
//     return _alertContainer(
//         widget: Column(
//       children: [
//         const Text("책에 대한 평가를 남겨주세요."),
//         const SizedBox(
//           height: 8,
//         ),
//         _textButton(
//           onPressedCallBack: () {
//             context.router.push(const ReviewViewRoute());
//           },
//           text: "책 평가하기",
//         ),
//       ],
//     ));
//   }

//   //수거완료 버튼 위젯
//   Widget _showAlert6() {
//     return _alertContainer(
//       widget: Column(
//         children: [
//           const Text("도서 수거를 위한 QR코드 입니다."),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _textButton(
//                 onPressedCallBack: _showModal2,
//                 text: "북박스 위치 보기",
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               _textButton(
//                 onPressedCallBack: _showModal3,
//                 text: "QR코드",
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           const Text("수거 완료 후 아래 버튼을 눌러주세요"),
//           _textButton(
//               onPressedCallBack: () async {
//                 await groupChannel!.updateMetaData({"statusIndex": "8"});

//                 final ChatRepository repository =
//                     ref.read(chatRepositoryProvider);
//                 await repository.progressStatus(
//                     widget.row["B_RENTAL_SEQ"], myUserId, "F");

//                 await _sendStatusIndexMsg(groupChannel!, "8", "_showAlert6");

//                 setState(() {});
//               },
//               text: "수거 완료"),
//         ],
//       ),
//     );
//   }

//   //수거가 완료되었습니다 위젯
//   Widget _showAlert7() {
//     return _alertContainer(
//         widget: const Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("수거가 완료되었습니다"),
//       ],
//     ));
//   }

//   //거래종료 위젯
//   Widget _showAlert8() {
//     return _alertContainer(
//       widget: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("거래 종료"),
//         ],
//       ),
//       color: Colors.red.shade300,
//     );
//   }

//   //상대방 응답 대기 위젯
//   Widget _showAlertWaiting() {
//     return _alertContainer(
//         widget: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [Text("상대방의 응답을 기다리고 있습니다.")]));
//   }

//   Widget _textButton({
//     required Function() onPressedCallBack,
//     required String text,
//     Color color = Colors.transparent,
//   }) {
//     return TextButton(
//         style: ButtonStyle(
//           side: MaterialStateProperty.all(
//             const BorderSide(
//               color: Colors.black54,
//               width: 2.0,
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.all<Color>(color),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//         ),
//         onPressed: onPressedCallBack,
//         child: Text(text));
//   }

//   void _dummy() async {
//     return;
//   }

//   Future<GroupChannel?> _createGroupChat() async {
//     GroupChannel? groupChannel = await SendBird.createGroupChat(
//         "bb_${widget.row["B_RENTAL_SEQ"]}", [myUserId]);

//     if (groupChannel == null) {
//       // ignore: use_build_context_synchronously
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return const AlertDialog(
//               title: Text("이미 거래중인 책입니다."),
//             );
//           });
//     } else {
//       this.groupChannel = groupChannel;
//       await groupChannel.createMetaData({"statusIndex": "3"});

//       await groupChannel.join();

//       await _sendStatusIndexMsg(groupChannel, "3", "_createGroupChat");

//       final ChatRepository repository = ref.read(chatRepositoryProvider);
//       await repository.progressStatus(
//           widget.row["B_RENTAL_SEQ"], myUserId, "A");

//       return groupChannel;
//     }

//     return null;
//   }

//   Future<void> _sendStatusIndexMsg(
//       GroupChannel groupChannel, String statusIndex, String methodName) async {
//     final data = {
//       "statusIndex": statusIndex,
//       "methodName": methodName,
//     };
//     final msg = jsonEncode(data);
//     await SendBird.sendToGroupChat(groupChannel, msg);
//   }

//   Future<void> _fetch() async {
//     final ChatRepository repository = ref.read(chatRepositoryProvider);
//     final ret = await repository.getBookboxInfo(widget.row["B_STORE_SEQ"]);
//     rowBookbox = ret["row"];
//     qr = ret["urlqr"];

//     final ret2 = await repository.getRentalTalks(widget.row["B_RENTAL_SEQ"]);
//     rentalInfo = ret2["rental"];
//     status = rentalInfo["B_RENTAL_STATUS"];

//     session = await repository.getSession();
//     myUserName = session["b_name"];
//     myUserId = session["b_mem_seq"];

//     await SendBird.connectByUserId(userId);

//     final GroupChannel? groupChannel =
//         await SendBird.getGroupChat("bb_${widget.row["B_RENTAL_SEQ"]}");

//     if (groupChannel != null) {
//       this.groupChannel = groupChannel;
//       await groupChannel.join();
//       final str = await groupChannel.getMetaData(["statusIndex"]);
//       statusIndex = int.parse(str["statusIndex"]!);

//       messages = await SendBird.getMessages("bb_${widget.row["B_RENTAL_SEQ"]}");
//     }
//     isLoading = true;
//     setState(() {});
//   }

//   Future<void> _reset(String currentStatus) async {
//     final ChatRepository repository = ref.read(chatRepositoryProvider);
//     await repository.resetStatus(
//         widget.row["B_RENTAL_SEQ"], myUserId, currentStatus);
//     // try{
//     //   debugPrint(myUserId);
//     //   await openChannel!.addOperators([myUserId, ]);
//     //   await openChannel!.deleteChannel();
//     // } catch (e) {
//     //   debugPrint("_reset 함수 deleteChannel 오류 :: $e");
//     // }
//   }

//   void mySetState() {
//     setState(() {});
//   }

//   Widget _statusText(String? status) {
//     Color color;
//     String text;

//     switch (status) {
//       case "A":
//         text = "제안받음";
//         color = Colors.red.shade400;
//         break;
//       case "B":
//         text = "제안수락";
//         color = Colors.red.shade300;
//         break;
//       case "C":
//         text = "입고준비";
//         color = Colors.red.shade200;
//         break;
//       case "D":
//         text = "입고완료";
//         color = Colors.blue.shade300;
//         break;
//       case "E":
//         text = "반납대기";
//         color = Colors.blue.shade200;
//         break;
//       case "F":
//         text = "수거대기";
//         color = Colors.blue.shade100;
//         break;
//       case "G":
//         text = "수거완료";
//         color = Colors.black45;
//         break;
//       case "H":
//         text = "제안대기";
//         color = Colors.green.shade200;
//         break;
//       case "I":
//         text = "제안대기";
//         color = Colors.green.shade200;
//         break;
//       case "N":
//         text = "사용안함";
//         color = Colors.black45;
//         break;
//       default:
//         text = "사용안함";
//         color = Colors.black45;
//         break;
//     }

//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Text(text, style: const TextStyle(fontSize: 12)),
//       ),
//     );
//   }
// }

// class MessageHandler extends MessageCollectionHandler {
//   final ChatViewState _state;

//   MessageHandler(this._state);

//   @override
//   void onChannelDeleted(GroupChannelContext context, String deletedChannelUrl) {
//     // _state._goBack();
//   }

//   @override
//   Future<void> onHugeGapDetected() async {
//     _state._disposeMessageCollection();
//     await _state._initializeMessageCollection();
//   }

//   @override
//   Future<void> onChannelUpdated(
//       GroupChannelContext context, GroupChannel channel) async {
//     await _state._refresh();
//   }

//   @override
//   Future<void> onMessagesAdded(MessageContext context, GroupChannel channel,
//       List<BaseMessage> messages) async {
//     await _state._refresh(markAsRead: true);
//     if (context.collectionEventSource !=
//         CollectionEventSource.messageInitialize) {
//       _state._scrollToAddedMessages(context.collectionEventSource);
//     }
//   }

//   @override
//   Future<void> onMessagesDeleted(MessageContext context, GroupChannel channel,
//       List<BaseMessage> messages) async {
//     await _state._refresh();
//   }

//   @override
//   Future<void> onMessagesUpdated(MessageContext context, GroupChannel channel,
//       List<BaseMessage> messages) async {
//     await _state._refresh();
//   }
// }
