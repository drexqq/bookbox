
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  bool test= false;
  List<bool> level = List.generate(3, (index) => false);
  List<List<bool>> stars = List.generate(5, (index) {
    return List.generate(5, (index) => false);
  });
  
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("리뷰 남기기", style: TextStyle(fontSize: 20)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: _divider(),
          ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bubbleContainer(
                  widget: Column(
                    children: [
                      Text("책 난이도를 공유해 주세요 (택 1)", style: TextStyle(fontWeight: FontWeight.bold)),
                      _checkBox(0),
                      _checkBox(1),
                      _checkBox(2),
                    ],
                  ),              
                  width: 340),
                ],
              ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bubbleContainer(
                  widget: Column(
                    children: [
                      Text("책 전반적인 평가는 어떤가요? (중복선택)", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8,),
                      _stars(0),
                      _stars(1),
                      _stars(2),
                      _stars(3),
                      _stars(4),
                      SizedBox(height: 8,),
                    ],
                  ), 
                  width: 340)
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bubbleContainer(
                  widget: Column(
                    children: [
                      Text("추천사를 적어주세요", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8,),
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ), 
                  width: 340)
              ],
            ),
          ),
          ListTile(
            title: TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black38)),
              child: Text("완료", style: TextStyle(color:Colors.white)),
              onPressed: (){
                debugPrint("${_textController.text}");
              },
              )
          ),
          ListTile(
            title: SizedBox(height: 24,),
          )

        ],
      )
      
      
      
      
    );
  }

  Widget _stars(int index){
    List<String> starTexts = ["재밌어요", "몰입돼요", "감동적이에요", "스릴넘쳐요", "기발해요"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(starTexts[index], style: TextStyle(fontSize: 14)),
        SizedBox(width: 8,),
        Row(
          children: List.generate(stars[index].length, (starIndex) {
            return GestureDetector(
              onTap:(){
                debugPrint("wh");
                debugPrint("$starIndex");
                debugPrint("${stars}");

                  for(int i= 0; i <= starIndex; i++){
                    debugPrint("true!");
                    stars[index][i] = true;
                  }
                  for(int i= starIndex + 1; i < stars[index].length; i++){
                    debugPrint("false!");
                    stars[index][i] = false;
                  }
                setState((){});
              },
              child: Icon(
                stars[index][starIndex] ? Icons.star : Icons.star_border,
                color: stars[index][starIndex] ? Colors.amber.shade400 : Colors.black54,
              ),
            );
          }),
        ),
      ],
    );
    
  }

  Widget _checkBox(int index){
    List<String> levelMsg = ["(쉬움) 쉽게 읽혀요", "(중간) 보통이에요", "(어려움) 내용이 어려워요"];
    return ListTile(
      title: Text(levelMsg[index], style: TextStyle(fontSize: 14)),
      trailing: Checkbox(
        value: level[index],
        onChanged: (value) {
          for(int i= 0; i < level.length; i++){
            level[i] = false;
          }
          setState(() {
            level[index] = true;
          });
        },
      ),
    );
  }

  Widget _divider(){
    return Container(
      height: 0.8, 
      color: Colors.black45, 
      );  
  }

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
  
  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }
}
