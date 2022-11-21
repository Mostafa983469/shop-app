import 'package:firstapp/shared/network/local/sharred.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../loginscreen/login.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();
  List<OnBoardData> boarding = [
    OnBoardData(
      image: 'assests/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    OnBoardData(
      image: 'assests/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    OnBoardData(
      image: 'assests/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];
  bool IsLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                Naviget(context);
              },
              child: Text('Skip',style: TextStyle(color: Colors.blue,fontSize: 20.0),)
          )
        ],
        title: Text('Shop App'),
      ),
      body: Padding(
          padding: const EdgeInsetsDirectional.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index){
                    if(index==boarding.length-1){
                      setState(() {
                        IsLast=true;
                      });
                    }else{
                      setState(() {
                        IsLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (context ,index) => BuildItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(height: 30.0,),
              Row(
                children: [
                  SmoothPageIndicator(
                    count: boarding.length,
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        activeDotColor : Colors.blue,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if(IsLast){
                        Naviget(context);
                      }else{
                        boardController.nextPage(duration: Duration(milliseconds: 20), curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios,),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}


class OnBoardData {
  final String image;
  final String title;
  final String body;

  OnBoardData({required this.image, required this.title, required this.body});
}

Widget BuildItem(OnBoardData model) =>  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
     Expanded(child: Image(
        image: AssetImage('${model.image}'),
      ),),
    Text('${model.title}',style: TextStyle(color: Colors.black ,fontSize: 30.0),),
    SizedBox(height: 10.0),
    Text('${model.title}',style: TextStyle(color: Colors.black ,fontSize: 15.0),),

  ],
);

void Naviget(context){
  Sharred.put(key: 'OnBoarding', value: true).
  then(
       (value) {
         if(value){
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Login()),
                 (route) {return false;});
         }}
       );
}