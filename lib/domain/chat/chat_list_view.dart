import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/auth/provider/auth_provider.dart';
import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/domain/chat/repository/chat_repository.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListView extends ConsumerStatefulWidget {
  const ChatListView({super.key});
  
  @override
  ConsumerState<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends ConsumerState<ChatListView> {
  final temp = TempData();
  final textButtons1 = ["전체", "제안", "거래중", "완료"];
  int curIdx = 0;
  bool isMySupplies = true;

  List< dynamic > rows = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top:8.0),
            child: Text(
              "채팅",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
              ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _textButton0(true),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _textButton0(false),
            ),
          ],
          bottom:  PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Column(
              children: [
                SizedBox(height: 7,),
                _divider(),
              ],
            ),
            ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 6,),
          Container(
            height: 42,
            child: Row(
              children: [
                Expanded(child: _textButton1()),
              ],
            )
            ),
          _divider(),
          Expanded(child: 
          FutureBuilder(
            future: _fetch(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }else if (snapshot.hasError){
                debugPrint("[Error]:: snapshot error : ${snapshot.error}");
                return const Text("오류가 발생했습니다.");
              }else{
                return _items();
              }
            }
            )
          ),
        ],
      ),
    );
  }


//공급한책 대여한책 버튼
  Widget _textButton0(bool mySupplies){
    void changeMySupplies(bool mySupplies){
      isMySupplies = mySupplies;
    }

    if(mySupplies){
      return TextButton(
        onPressed: () {
           debugPrint("공");
           setState(() {
            changeMySupplies(true);  
           });
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        child: 
          isMySupplies 
            ? const Text(
              "공급한 책", 
              style: TextStyle(fontWeight: FontWeight.bold) ,)
            : const Text(
              "공급한 책",
            ),
        );
    }

    return TextButton(
        onPressed: () {
          debugPrint("대여");
            setState(() {
              changeMySupplies(false);  
            });
          },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        child: 
          !isMySupplies 
            ? const Text(
              "대여한 책", 
              style: TextStyle(fontWeight: FontWeight.bold) ,)
            : const Text(
              "대여한 책",
            ),
        );
  }

//전체 제안 거래중 완료 버튼
  Widget _textButton1(){
    Widget texts(int index){
      return GestureDetector(
        onTap: (){
          setState(() {
            curIdx = index;  
          });
        },
        child: 
          curIdx == index 
          ? Text(textButtons1[index],
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
          : Text(textButtons1[index],),
      ); 
      
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: texts(index),
        );
      },
    );
  }

  Widget _items(){
    List<dynamic> rows = _filter(this.rows);

    if(rows.isEmpty){
      return const Column(
        children: [
          SizedBox(height: 16,),
          Text("항목이 없습니다"),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (BuildContext context, int index){
          return _item(rows[index], index);
        }
      ),
    );
  }

  Widget _item(dynamic row, int index){
    // final row = isMySupplies 
    //   ? rowsSupplies[index] : rowsRentals[index];

    final String imageUrl = 
      row["B_COVER_IMG"] ?? "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9791192300818.jpg";

    final status = row["B_RENTAL_STATUS"];
    final bookName = row["B_TITLE"];
    final userName = row["B_BOOKSELF_NAME"];
    final time = _formatTimeDifference(row["B_REG_DATE"]);

    return GestureDetector(
      onTap: (){
        debugPrint("누름! $index");
        context.router.push(ChatViewRoute(dealId: index, row: row));
      },
      child: Column(
        children: [
          Container(
            height: 180,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  ),
                // Image.asset(
                //   imageUrl,
                //   width: 120,
                // ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _statusText(status),
                          Text(bookName),
                          Text("등록자: $userName"),
                      ],),
                      Text(time),
                    ]
                    ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _divider(),
          ),
        ],
      ),
    );
    
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
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text),
      )
    );
  }

  Widget _divider(){
    return Container(
      height: 0.8, 
      color: Colors.black45, 
      );  
  }

//버튼 누를때마다 api 호출함 ㅎㅎㅎ
  Future<bool> _fetch() async {
    final ChatRepository repository = ref.read(chatRepositoryProvider);

    final ret = isMySupplies 
      ? await repository.getSupplies()
      : await repository.getRentals();
    rows = ret["rows"];

    return true;
  }

  List<dynamic> _filter(List<dynamic> rows){
    //I, A, B 제안
    //C, D, E, F 거래중
    //G, N 종료
    List<String> status = [];
    if(curIdx == 0){
      return rows;
    } else if (curIdx == 1) {
      status = ["A", "B", "I"];
    }else if (curIdx == 2) {
      status = ["C", "D", "E", "F"];
    }else {
      status = ["G", "N"];
    }

    debugPrint("rowsLength! ${rows.length}");

    List<dynamic> ret = [];
    for(int i= 0; i< rows.length; i++){
      debugPrint("i= $i");
      debugPrint("row= ${rows[i]}");
     for(int j= 0; j< status.length; j++){
      if(rows[i]["B_RENTAL_STATUS"] == status[j]){
        ret.add(rows[i]);
        break;
      } 
     } 
    }

    return ret;
  }

  String _formatTimeDifference(String inputDateString) {
    DateTime inputDate = DateTime.parse(inputDateString);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(inputDate);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1일 전';
      } else {
        return '${difference.inDays}일 전';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1시간 전';
      } else {
        return '${difference.inHours}시간 전';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1분 전';
      } else {
        return '${difference.inMinutes}분 전';
      }
    } else {
      return '방금 전';
    }
  }
}

class TempData{
  List< Map<String,dynamic> > rowsSupplies = [

    {"userName": "신승훈", "bookName": "12가지 인생의 법칙", "imageUrl": "assets/images/s1.jpeg", "status": "I", "time": "2시간 전"},
    {"userName": "신승훈", "bookName": "블록체인", "imageUrl": "assets/images/s2.jpeg", "status": "C", "time": "1일 전"},
    {"userName": "신승훈", "bookName": "우리는 어떻게 괴물이 되어가", "imageUrl": "assets/images/s3.jpeg", "status": "I", "time": "1일 전"},
    {"userName": "신승훈", "bookName": "시드마이어", "imageUrl": "assets/images/s4.jpeg", "status": "I", "time": "4일 전"},

  ];

  List< Map<String,dynamic> > rowsRentals = [
    {"userName": "정인수", "bookName": "그냥 하지 말라", "imageUrl": "assets/images/i1.jpeg", "status": "E", "time": "7일 전"},
    {"userName": "구성연", "bookName": "스타트업 경영수업", "imageUrl": "assets/images/d1.jpeg", "status": "G", "time": "9일 전"},
    {"userName": "현우", "bookName": "프레임의 힘", "imageUrl": "assets/images/e1.jpeg", "status": "F", "time": "9일 전"},
    {"userName": "방현주", "bookName": "레버리지", "imageUrl": "assets/images/i3.jpeg", "status": "G", "time": "14일 전"},
    {"userName": "미네르바", "bookName": "코스모스", "imageUrl": "assets/images/i4.jpeg", "status": "A", "time": "14일 전"},
    
    {"userName": "하리닝", "bookName": "나는 장사의 신이다", "imageUrl": "assets/images/i2.jpeg", "status": "F", "time": "15일 전"},
  ];
}
