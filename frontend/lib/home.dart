// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:frontend/emergency.dart';
import 'package:frontend/firebase.dart';
import 'package:frontend/utilities/global.dart';
import 'package:frontend/utilities/emergencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Emergencies>> emergencies;
  late Map normal;
  loadEmergencies() {
    emergencies = Global.loadEmergency(1);
  }

  loadNormalAlerts() {}
  @override
  void initState() {
    FireBaseMsg().initilise(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadEmergencies();
    return Scaffold(
      body: FutureBuilder<List<Emergencies>>(
          future: emergencies,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100.0,
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return SizedBox(
                          // height: 50,
                          width: 200,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            color: Colors.deepOrange,
                            elevation: 50,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                // Text(snapshot.data![i].location),
                                Text(
                                  snapshot.data![index].description,
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  snapshot.data![index].userId.toString(),
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  snapshot.data![index].location,
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ));
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () => {Navigator.pushNamed(context, '/emergency')},
      ),
    );
  }
}
