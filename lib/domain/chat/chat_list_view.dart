import 'package:auto_route/auto_route.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});
  
  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final textButtons1 = ["전체", "제안", "거래중", "완료"];
  int curIdx = 0;
  bool isMySupplies = true;

  List< Map<String,dynamic> > rowsSupplies = [
    {"test": "abc", "test2": 2},
    {"test": "bfc", "test2": 12},
  ];
  List< Map<String,dynamic> > rowsRentals = [
    {"test": "abc", "test2": 2},
    {"test": "bfc", "test2": 12},
  ];

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
                return const CircularProgressIndicator();
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
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        // itemCount: rows.length,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return _item(index);
        }
      ),
    );
  }

  Widget _item(int index){
    // final row = rows[index];

    // final String imageUrl = row["test"];
    // final status = row["test"];
    // final bookName = row["test"];
    // final userName = row["test"];
    // final time = row["test"];
    // final int chatId = row["test"]; 

    final imageUrl = "https://image.yes24.com/goods/90555281/XL";
    final status = "제안받음";
    final bookName = "데카르트 철학의 원리";
    final userName = "정현순";
    final time = "1시간 이내";

    // final int chatId = row["test2"]; 

    return GestureDetector(
      onTap: (){
        debugPrint("누름! $index");
        context.router.push(ChatViewRoute(dealId: index));
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
                          Container(
                            color: Colors.red,
                            child: Text(status)
                            ),
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

  Widget _divider(){
    return Container(
      height: 0.8, 
      color: Colors.black45, 
      );  
  }

//여기서 공급책 대여책 api 다받고 한번에 데이터 초기화
//전체 제안 거래중 완료 누를때마다 rows에서 필터돌려서 출력하거나 처음부터 각 필터별 어레이 다 저장해놓기
  Future<bool> _fetch() async {
    return true;
  }
}
