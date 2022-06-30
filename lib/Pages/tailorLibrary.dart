import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/customerAdmeasurment.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'package:tailor_application/Pages/templateModels.dart';
import '../Functions/PageRoutes.dart';

class LibraryListOfModels extends StatefulWidget {
  const LibraryListOfModels({Key? key}) : super(key: key);

  @override
  _LibraryListOfModelsState createState() => _LibraryListOfModelsState();
}

class _LibraryListOfModelsState extends State<LibraryListOfModels> {
  late AddModalToYourLibrary modalVariable;

  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Library"),
          ),
          body: StreamBuilder<List<AddModalToYourLibrary>>(
              stream: getModelList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final listModel = snapshot.data!;
                  return ListView(
                    children: listModel.map(buildModel).toList(),
                  );
                } else {
                  return const Center(
                    child: Text("No Record Found"),
                    //child: CircularProgressIndicator()
                  );
                }
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        );
      });

  Widget buildModel(AddModalToYourLibrary model) {
    //modalVariable = model;
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: InkWell(
        onTap: () {
          showDialogBox(model);
        },
        child: Container(
          //height: 280,
          // width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    model.imagePath,
                    fit: BoxFit.fill,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(model.name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        )),
                    Text(
                      model.price,
                      style: const TextStyle(
                          fontSize: 15, color: Colors.orangeAccent),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogBox(AddModalToYourLibrary model) {
    modalVariable = model;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Select Customer"),
          content: SizedBox(
            width: 200,
            //height: 300,
            child: StreamBuilder<List<CustomerRegisterClass>>(
                stream: GetCustomerList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final customers = snapshot.data!;
                    return ListView(
                      children: customers.map(customerContainer).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }

  Widget customerContainer(CustomerRegisterClass customer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          NavigateToOtherScreen(
              context,
              CustomerAdmeasurment(
                imgpath: modalVariable.imagePath,
                name: modalVariable.name,
                price: modalVariable.price,
                customerDetails: customer,));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(30),
            color: Colors.black12,
            child: Column(
              children: [
                Row(children: [
                  const Icon(Icons.person),
                  Text(customer.cName)
                ]),
                const Divider(
                  color: Colors.black,
                ),
                Row(children: [
                  const Icon(Icons.phone),
                  Text(customer.cPhone)
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
