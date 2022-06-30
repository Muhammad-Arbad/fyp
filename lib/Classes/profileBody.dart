import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Functions/PageRoutes.dart';
import 'package:tailor_application/Pages/allCustomers.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'package:tailor_application/Chart/chart.dart';
import 'package:tailor_application/Pages/tailorLibrary.dart';
import 'package:tailor_application/Pages/templateModels.dart';
import '../Chart/lineChart.dart';
import '../Pages/profile.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      // await applicationSharedPreferences.setTemplateAddOrRemove("Arbad");
                      // print(applicationSharedPreferences.getTemplateAddOrRemove());
                      NavigateToOtherScreen(context, listofmodels());
                    },
                    child: BuildContainers("Add Templates", Text("100"),
                        Icons.monetization_on, (Colors.blue[300])!),
                  ),

                  InkWell(
                    onTap: () {
                      NavigateToOtherScreen(context, LibraryListOfModels());
                    },
                    child: BuildContainers("Tailor Library", Text("50"),
                        Icons.shopping_cart_outlined, (Colors.orange[300])!),
                  ),
                  InkWell(
                    onTap: () {
                      NavigateToOtherScreen(context, AllCustomers());
                    },
                    child: BuildContainers(
                        "All Customers",
                        FutureBuilder(future: countCustomers(),builder: (context,snapshor){
                          if(snapshor.hasData){
                            Object? data = snapshor.data;
                            return Text("$data");
                          }
                          else
                            return const CircularProgressIndicator();
                        },),
                        Icons.sms, (Colors.red[300])!),
                  ),
                  InkWell(
                    onTap: () {
                      NavigateToOtherScreen(context,RegisterCustomer());
                    },
                    child: BuildContainers("Add Customer", Icon(Icons.add), Icons.person,
                        (Colors.indigo[300])!),
                  ),
                  //LineChartSample2(),
                ],
              ),
            ),

            //SizedBox(height: 15,),
            Container(
              //padding: EdgeInsets.all(50),
              child: LineChartSample2(),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: PieChartPage()),
          ],
        ),
      ),
    );
  }

  Widget BuildContainers(
      String title, Widget detail, IconData icon, Color bgcolor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(08),
      child: Container(
        color: bgcolor,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //padding: EdgeInsets.only(left: 15),
                  child: detail,),
                //   Text(detail,
                //       style: const TextStyle(
                //           fontSize: 35,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.white)),
                // ),
                Container(
                    child: Icon(
                  icon,
                  color: Colors.white,
                  size: 35,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> countCustomers() async{
    final query =  FirebaseFirestore.instance.collection("tailors").doc(user?.phoneNumber).collection("OwnCustomers");
    final doc = await query.get();
    int count = doc.size;
    return count;
  }
}
