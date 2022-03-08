import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor_application/selectCustomerTailor.dart';
import 'sharedPreferences/userPreferences.dart';

class introduction extends StatefulWidget {
  const introduction({Key? key}) : super(key: key);
  @override
  _introductionState createState() => _introductionState();
}

class _introductionState extends State<introduction> {

  final controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    applicationSharedPreferences.setIntroVisibility(false);
    print(applicationSharedPreferences.getIntroVisibility());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Introduction"),),
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            Container(
              color: Colors.black12,
              child: Center(child: Text("How to Use"),),
            ),
            Container(
              color: Colors.lightGreenAccent,
              child: Center(child: Text("Screen 2"),),
            ),
            Container(
              color: Colors.amberAccent,
              child: Center(child: Text("Screen 3"),),
            ),
          ],
        ),
      ),

      bottomSheet: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween   ,
          children: [
            TextButton(onPressed: (){controller.jumpToPage(2);}, child: Text("Skip")),
            Center(child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect:  JumpingDotEffect(
                spacing: 16,
                dotColor: Colors.black12,
                activeDotColor: Colors.blue
              ),
              onDotClicked: (index)=>controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn),

            ),),
            TextButton(onPressed: (){
              if(controller.page != 2)
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              else
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>selectCustomerTailor()));
              }, child: Text("Next")),
          ],
        ),
      ),
    ));
  }
}
