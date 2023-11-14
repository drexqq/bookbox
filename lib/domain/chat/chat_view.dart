import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.dealId});

  final dealId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final myUserId = 23;
  final userName = "정현순";
  final myUserName = "이동우";
  final bookName = "데카르트 철학의 원리";
  final userPosterImageUrl = "https://cdn.spotvnews.co.kr/news/photo/201904/281496_346747_5322.jpg";
  final imageUrl = "https://image.yes24.com/goods/90555281/XL";
  final status = "제안받음";
  final recentTime = "2시간 전";

  @override
  Widget build(BuildContext context) {
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              style: TextStyle(fontSize: 12),
                              status,
                              ),
                          ),
                        ),
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
          child: Column(children: [
            // _row(
            //   timeWidget: _timeWidget(), 
            //   messageWidget: _bubbleContainer(
            //     widget: _requestRental0(), 
            //     width: 268), 
            //   userId: 23),
            // _row(
            //   timeWidget: _timeWidget(),
            //   messageWidget: _bubbleContainer(
            //     widget: _requestRental1(),
            //     width: 270),
            //   userId: 23),
            // _row(
            //   timeWidget: _timeWidget(),
            //   messageWidget: _bubbleContainer(
            //     widget: _requestRental21(),
            //     width: 270),
            //   userId: 23),
            // _row(
            //   timeWidget: _timeWidget(),
            //   messageWidget: _bubbleContainer(
            //     widget: _requestRental22(),
            //     width: 88),
            //   userId: 23),
            // _showAlert0(),
            // _showAlert1(),
            // _showAlert2(),
            _showAlert3(),
            _showAlert4(),
            _showAlert5(),
            _showAlert6(),
            _showAlert7(),
          ]),
        ),
    );
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
        );
      });
  }

  Widget _profileImage(){
    return ClipOval(
      child: CachedNetworkImage(
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        imageUrl: userPosterImageUrl,
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
        messageWidget,
        const SizedBox(width: 4,),
        timeWidget,
      ],);
    }
  }

  //시간표시위젯
  Widget _timeWidget(){
    return const Text("11:00");
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("안녕하세요 $userName님 !"),
      const Text("총 1권을 대여하고 싶어요."),
      _divider(),
      Text("대여시작일: 2022년 12월 29일"),
      Text("대여종료일: 2022년 12월 31일 (2일)"),
      _divider(),
      const Text("대출 도서명"),
      Text(bookName),
    ]);
  }

  //북박스 장소 ~~ 위젯
  Widget _requestRental1(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("O 북박스 장소"),
        SizedBox(height: 10,),
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
    );
  }
  
  //확인했어요 버튼 있는 위젯
  Widget _requestRental21(){
    return Column(children: [
      _textButton(
        onPressedCallBack: _dummy, 
        text: "확인했어요" ) ,
      const Text("[확인] 버튼을 눌러야 거래가 시작됩니다."),
    ],);
  }

  //거절당해서 확인했어요 글자만 있는 위젯
  Widget _requestRental22(){
    return Text("확인했어요!");
  }

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
          Text("2022년 12월 23일까지 (D-2)"),
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
            onPressedCallBack: _dummy, 
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
  void _dummy(){
    debugPrint("dummy!");
    return;
  }
}
