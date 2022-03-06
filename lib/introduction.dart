import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class introduction extends StatefulWidget {
  const introduction({Key? key}) : super(key: key);

  @override
  _introductionState createState() => _introductionState();
}

class _introductionState extends State<introduction> {

  final controller = PageController();

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
              color: Colors.redAccent,
              child: Center(child: Text("Screen 1"),),
            ),
            Container(
              color: Colors.blue,
              child: Center(child: Text("Screen 2"),),
            ),
            Container(
              color: Colors.green,
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
            TextButton(onPressed: (){controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);}, child: Text("Next")),
          ],
        ),
      ),
    ));
  }
}
