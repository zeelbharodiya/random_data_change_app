import 'dart:math';

import 'package:flutter/material.dart';

import 'helpers/api_helpers.dart';
import 'models/data_random.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<RandomData?> getData;
  TextStyle myStyle = TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17);

  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.pink,
    Colors.purple,
  ];
  Random random = new Random();

  void changeIndex() {
    setState(() => index = random.nextInt(6));
  }


  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData = APIHelper.apiHelper.fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raandom Details",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                getData = APIHelper.apiHelper.fetchRates();
                changeIndex();
              });
            },
              child: Icon(Icons.refresh,color: Colors.white,)),
          SizedBox(width: 15,),
        ],
        backgroundColor: colors[index],
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
              future: getData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  RandomData? data = snapshot.data;

                  return (data != null)
                      ?  Column(
                        children: [
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    child: Container(
                                        height: 160,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200),
                                          color: colors[index],
                                        ),
                                        child: Image.network("${data.avatar}",fit: BoxFit.fill,)
                                    ),
                                    borderRadius: BorderRadius.circular(200),

                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 40,),
                          Container(
                            height: 300,
                            width: 350,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0,top: 15,bottom: 15),
                              child: Column(
                                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                  Text("Id : ${data.id}",style: myStyle,),
                                  Text("Name : ${data.firstName} ${data.lastName}",style: myStyle,),
                                  Text("Email : ${data.email}",style: myStyle,),
                                  Text("Gender : ${data.gender}",style: myStyle,),
                                  Text("Dob : ${data.dateOfBirth}",style: myStyle,),
                                  Text("City : ${data.city}",style: myStyle,),
                                  Text("Country. : ${data.country}",style: myStyle,),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      )
                      : Center(
                    child: Text("No data found..."),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
