import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/chat/sendbird/sendbird.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:bookbox/util/map_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.dealId, required this.row});

  final dealId;
  final Map<String,dynamic> row;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final myUserId = 23;
  final myUserName = "신승훈";
  // final userPosterImageUrl = "https://cdn.spotvnews.co.kr/news/photo/201904/281496_346747_5322.jpg";
  final userPosterImageUrl = "assets/images/profile.jpeg";
  final recentTime = "1시간 전";

  String bookName = "";
  String userName = "";
  String status = "";
  String imageUrl = "";

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();



  @override
  Widget build(BuildContext context) {

    

  imageUrl = widget.row["B_COVER_IMG"] ?? "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192300818.jpg";
  status = widget.row["B_RENTAL_STATUS"];
  bookName = widget.row["B_TITLE"];
  userName = widget.row["B_BOOKSELF_NAME"];
  final time = widget.row["B_REG_DATE"];

    debugPrint("chatView ${widget.dealId}");
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(height: 8,),
            Container(
              child: Row(
                children: [
                  _profileImage(),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                      children: [
                        Text(userName, style: TextStyle(fontSize: 20)),
                        SizedBox(width: 8,),
                        _statusText(status),
                      ],
                    ),
                    Text("마지막 활동: $recentTime", style: TextStyle(fontSize: 12)),
                  ],)
                ]),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              _showModal();
            },
            child: const Column(
              children: [
                SizedBox(height: 16,),
                Row(
                  children: [
                    Icon(Icons.book),
                    Text("책 정보"),
                    SizedBox(width: 8,),
                  ],
                ),
              ],
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: _divider(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: Column(children: [
          //   _row(
          //     timeWidget: _timeWidget("11:04"), 
          //     messageWidget: _requestRental0(), 
          //     userId: 23),
          //   _row(
          //     timeWidget: _timeWidget("11:04"),
          //     messageWidget: _requestRental1(),
          //     userId: 23),
          //   _row(
          //     timeWidget: _timeWidget("11:20"),
          //     messageWidget: _requestRental21(),
          //     userId: 23),
          //   _row(
          //     timeWidget: _timeWidget("11:20"),
          //     messageWidget: _requestRental22(),
          //     userId: 23),
          //   _showAlert0(),
          //   _showAlert1(),
          //   _showAlert2(),
          //   _showAlert3(),
          //   _showAlert4(),
          //   _showAlert5(),
          //   _showAlert6(),
          //   _showAlert7(),
          // ]),
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: (BuildContext context, int index){
              return _temp(index);
            }
            ),
        ),
    );
  }

  Widget _temp(int index){
    switch (index) {
      case 0:
      return _row(
        timeWidget: _timeWidget("11:04"), 
        messageWidget: _requestRental0(), 
        userId: 23);
      case 1:
      return _row(
        timeWidget: _timeWidget("11:04"), 
        messageWidget: _requestRental1(), 
        userId: 23);
      case 2:
      return _row(
        timeWidget: _timeWidget("12:44"), 
        messageWidget: _responseRental01(), 
        userId: -1);
      case 3:
      return _row(
        timeWidget: _timeWidget("12:48"), 
        messageWidget: _requestRental22(), 
        userId: 23);
      case 4:
      return  _showAlert0();
      case 5:
      return _showAlert1();
      case 6:
      return _showAlert2();
      case 7:
      return _showAlert3();
      case 8:
      return _showAlert5();
    }

    return _showAlert7();
  }

// 책정보 표시 모달 위젯
  void _showModal(){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(bookName),
          content: CachedNetworkImage(
            width: 200,
            imageUrl: imageUrl,
            ),
          // content: Image.asset(
          //   imageUrl,
          //   width: 200,
          //   ),
        );
      });
  }

  Widget _profileImage(){
    // return ClipOval(
    //   child: CachedNetworkImage(
    //     width: 36,
    //     height: 36,
    //     fit: BoxFit.cover,
    //     imageUrl: userPosterImageUrl,
    //     ),
    // );
    return ClipOval(
      child: Image.asset(
        userPosterImageUrl,
        width: 36,
        height: 36,
        fit: BoxFit.cover
      ),
    );
  }

  //시간 + 말풍선표시, 좌측 or 우측 정렬(누가 톡보낸건지) Row
  Widget _row({
    required Widget timeWidget,
    required Widget messageWidget,
    required userId, 
  }){
    if(userId == myUserId){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          timeWidget,
          const SizedBox(width: 5,),
          messageWidget,
        ],
        );  
    } else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        _profileImage(),
        const SizedBox(width: 4,),
        messageWidget,
        const SizedBox(width: 4,),
        timeWidget,
      ],);
    }
  }

  //시간표시위젯
  Widget _timeWidget(String time){
    return Column(
      children: [
        Text(time),
        SizedBox(height: 8,)
      ],
    );
  }

  Widget _divider(){
    return Container(
      height: 0.8, 
      color: Colors.black45, 
      );  
  }
  
  // 말풍선 프레임 
  Widget _bubbleContainer({required Widget widget, required double width}){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }




  // 안녕하세요 새로미~~ 위젯
  Widget _requestRental0(){
    DateTime dateStart = DateTime.parse(widget.row["B_PERIOD_START"]);
    DateTime dateEnd = DateTime.parse(widget.row["B_PERIOD_END"]);

    return _bubbleContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("안녕하세요 $userName님 !"),
          const Text("총 1권을 대여하고 싶어요."),
          SizedBox(height: 8,),
          _divider(),
          SizedBox(height: 8,),
          Text("대여시작일: ${dateStart.year}년 ${dateStart.month}월 ${dateStart.day}일"),
          Text("대여종료일: ${dateEnd.year}년 ${dateEnd.month}월 ${dateEnd.day}일"),
          SizedBox(height: 8,),
          _divider(),
          SizedBox(height: 8,),
          const Text("대출 도서명"),
          Text(bookName, style: TextStyle(fontWeight: FontWeight.bold)),
        ]
      ), 
      width: 268);
  }

  //북박스 장소 ~~ 위젯
  Widget _requestRental1(){
    //google maps api 키
    //AIzaSyAjvCWZvneT_uVO476uerwUpUJ4MFhYeAs

    MapHelper mapHelper = MapHelper();

    return _bubbleContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("O 북박스 장소"),
          // SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 240,
                height: 240,
                child: mapHelper.drawMapByPosition(37.402995, 127.099149),
              ),
              
            ],
          ),
          Text("투썸플레이스 금토점"),
          Text("경기 성남시 수정구 금토동 00-0"),
          Container(
            width: 270,
          ),
          Text("O 운영시간"),
          Text("- 평일 08:00 ~ 20:00"),
          Text("- 주말 08:00 ~ 20:00"),
          Text("- 공휴일 미운영"),
        ],
      ), 
      width: 270);
  }
  
  //확인했어요 버튼 있는 위젯
  Widget _requestRental21(){
    return _bubbleContainer(
      widget: Column(children: [
        _textButton(
          onPressedCallBack: _dummy, 
          text: "확인했어요" ) ,
        const Text("[확인] 버튼을 눌러야 거래가 시작됩니다."),
        ],), 
      width: 270);
  }

  //거절당해서 확인했어요 글자만 있는 위젯
  Widget _requestRental22(){
    return _bubbleContainer(
      widget: const Text("확인했어요!"), 
      width: 88);
  }

/////////////////////////////////////////////////

  Widget _responseRental01(){
    return _bubbleContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("$myUserName님 제안을 받아드릴게요!"),
        Text("2023년 11월 10일까지 입고하도록 할게요!"),
      ]), 
      width: 268);
  }

  Widget _responseRental02(){
    return _bubbleContainer(
      widget: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("죄송해요. 보내주신 제안이 맞지 않아 거절합니다."),
          Text("좋은 거래를 통해 다시 만나요!"),
        ],
      ), 
      width: 268);
  }

////////////////////////////////////////////////////////
  Widget _alertContainer({
    required Widget widget,
    Color color = Colors.black26,
  }){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54
              ),
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            width: 270,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget,
            ),
          ),
        ],
      ),
    );
  }

  //공급자가 입고를 진행하고 있습니다 위젯
  Widget _showAlert0(){
    return _alertContainer(
      widget: Column(
        children: [ 
          const Text("공급자가 입고를 진행하고 있습니다."),
          _textButton(
            onPressedCallBack: _dummy, 
            text: "북박스 위치 보기",
            ),
        ],
      ),
    );
  }

  //입고가 완료되었습니다 위젯
  Widget _showAlert1(){
    return _alertContainer(
      widget: Column(
        children: [ 
          const Text("입고가 완료되었습니다."),
          const Text("대여를 위한 QR코드 입니다."),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textButton(
                onPressedCallBack: _dummy, 
                text: "북박스 위치 보기",
              ),
              const SizedBox(width: 12,),
              _textButton(
                onPressedCallBack: _dummy,
                text: "QR코드",
              )
            ],
          ),
        ],
      ),
      );
  }

  //대여를 시작합니다 위젯
  Widget _showAlert2(){
    return _alertContainer(
      widget: Column(
        children: [ 
          const Text("대여를 시작합니다."),
          SizedBox(height: 8,),
          const Text("반납 예정일"),
          Text("2023년 11월 22일까지 (D-4)"),
        ]
      ),
    );
  }

  //반납 일정이 되었습니다 위젯
  Widget _showAlert3(){
    return _alertContainer(
      widget: Column(
        children: [ 
          const Text("반납 일정이 되었습니다."),
          const Text("반납을 위한 QR코드 입니다."),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textButton(
                onPressedCallBack: _dummy2, 
                text: "북박스 위치 보기",
              ),
              const SizedBox(width: 12,),
              _textButton(
                onPressedCallBack: _dummy3,
                text: "QR코드",
              )
            ],
          ),
        ],
      ),
    );
  }

  //반납이 완료되었습니다 위젯
  Widget _showAlert4(){
    return _alertContainer(
      widget: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("반납이 완료되었습니다."),
        ],
      ),
    );
  }

  //책에 대한 평가를 남겨주세요 위젯
  Widget _showAlert5(){
    return _alertContainer(
      widget: Column(
        children: [
          Text("책에 대한 평가를 남겨주세요."),
          SizedBox(height: 8,),
          _textButton(
            onPressedCallBack: (){ context.router.push(ReviewViewRoute());}, 
            text: "책 평가하기",
          ),
        ],
      )
    );
  }
  
  //수거가 완료되었습니다 위젯
  Widget _showAlert6(){
    return _alertContainer(
      widget: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("수거가 완료되었습니다"),
        ],
      )
    );
  }

  //거래종료 위젯
  Widget _showAlert7(){
    return _alertContainer(
      widget: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("거래 종료."),
        ],
      ),
      color: Colors.red.shade300,
    );
  }

  Widget _textButton({
    required Function() onPressedCallBack,
    required String text,
    Color color = Colors.transparent,
    }){
    return TextButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            const BorderSide(
              color: Colors.black54,
              width: 2.0,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressedCallBack, 
        child: Text(text));  
  }


  late OpenChannel? openChannel;
  void _dummy() async {
    debugPrint("dummy!");
    openChannel = await SendBird.testCreate(channelUrl: "TESTa");
    debugPrint("${openChannel!.channelUrl}");
    return;
  }

  void _dummy2() async {
    debugPrint("dummy2!");
    openChannel = await SendBird.testEnter("TESTa");
    debugPrint("${openChannel!.channelUrl}");
    return;
  }

  UserMessage? userMessage;

  void _dummy3() async {
    debugPrint("dummy3!");
    userMessage = await SendBird.testSend(openChannel!, "msfsg");
    debugPrint("${userMessage}");
    return;
  }

  Widget _statusText(String status){
    Color color;
    String text;

    switch (status) {
      case "A":
        text = "제안받음";
        color = Colors.red.shade400;
        break;
      case "B":
        text = "제안수락";
        color = Colors.red.shade300;
        break;
      case "C":
        text = "입고준비";
        color = Colors.red.shade200;
        break;
      case "D":
        text = "입고완료";
        color = Colors.blue.shade300;
        break;
      case "E":
        text = "반납대기";
        color = Colors.blue.shade200;
        break;
      case "F":
        text = "수거대기";
        color = Colors.blue.shade100;
        break;
      case "G":
        text = "수거완료";
        color = Colors.black45;
        break;
      case "I":
        text = "제안대기";
        color = Colors.green.shade200;
        break;
      case "N":
        text = "사용안함";
        color = Colors.black45;
        break;
      default:
        text = "오류";
        color = Colors.black45;
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

