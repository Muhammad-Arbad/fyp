import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Preferences/userPreferences.dart';
import 'package:tailor_application/Pages/selectCustomerTailor.dart';
import '../functions/functions.dart';

class introduction extends StatefulWidget {
  const introduction({Key? key}) : super(key: key);

  @override
  _introductionState createState() => _introductionState();
}

class _introductionState extends State<introduction> {
  ScrollController scrollController = ScrollController();

  final controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    ApplicationSharedPreferences.setIntroVisibility(false);
    //print(ApplicationSharedPreferences.getIntroVisibility());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    scrollToEnd(milliseconds: 1000);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool LandScape = isLandscape(context);
    scrollToEnd(milliseconds: 100);
    return ScaffoldTemplate(
      OurWidget: Container(
        padding: EdgeInsets.only(bottom: LandScape ? 50 : 80),
        child: PageView(
          controller: controller,
          children: [
            Container(
              color: Colors.black12,
              child: introScreenItems(0, scrollController),
              //child: Center(child: Text("How to Use"),),
            ),
            Container(
              color: Colors.lightGreenAccent,
              child: introScreenItems(1, scrollController),
              //child: Center(child: Text("Screen 2"),),
            ),
            Container(
              color: Colors.amberAccent,
              child: introScreenItems(2, scrollController),
              //child: Center(child: Text("Screen 3"),),
            ),
          ],
        ),
        // child: PageView.builder(itemBuilder: (BuildContext buildContex,int index)=>introScreenItems(1),
        //   itemCount: 3,),
      ),
      appBarTitle: Text("Introduction"),
      ScaffoldTemplateBottomSheet: Container(
        height: LandScape ? 50 : 80,
        //height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  controller.jumpToPage(2);
                },
                child: Text("Skip")),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: JumpingDotEffect(
                    spacing: 16,
                    dotColor: Colors.black12,
                    activeDotColor: Colors.blue),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (controller.page != 2) {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => selectCustomerTailor()));
                  }
                },
                child: Text("Next")),
          ],
        ),
      ),
      floatingActionButton: null,
    );
  }

  void scrollToEnd({required int milliseconds}) {
    Timer(
      Duration(milliseconds: milliseconds),
      () {
        if (!scrollController.hasClients) return;
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      },
    );
  }
}
