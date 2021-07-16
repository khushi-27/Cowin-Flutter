import 'dart:convert';

import 'package:cowin_flutter/slots.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.teal, brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController daycontroller = TextEditingController();

  String dropdownValue = '01';

  List slots = [];

  fetchSlots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
                pincodecontroller.text +
                '&date=' +
                daycontroller.text +
                '-' +
                dropdownValue +
                '-2021'))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Slots(slots: slots)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        title: Text(
          'Vaccination Slots',
          style: TextStyle(letterSpacing: 0.5, fontSize: 25.0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/vaccine.png',
                ),
              ),
              const SizedBox(height: 40.0),
              TextField(
                controller: pincodecontroller,
                decoration: InputDecoration(hintText: 'Enter Pincode'),
                maxLength: 6,
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60.0,
                      child: TextField(
                        controller: daycontroller,
                        decoration: InputDecoration(hintText: 'Enter Date'),
                        // maxLength: 2,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: Container(
                    height: 52.0,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.grey.shade400),
                      underline: Container(
                        height: 0.7,
                        color: Colors.grey.shade400,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        '01',
                        '02',
                        '03',
                        '04',
                        '05',
                        '06',
                        '07',
                        '08',
                        '09',
                        '10',
                        '11',
                        '12'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 40.0),
              Container(
                  height: 45.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      fetchSlots();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: Text(
                      'Find Slots',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
