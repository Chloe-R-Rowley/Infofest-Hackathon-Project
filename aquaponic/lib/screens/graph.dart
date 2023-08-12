import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' hide State;

import 'dart:async';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  late final Db db;
  List<Map<String, dynamic>> fetchedDataList = [];

  void fetchData() async {
    db = await Db.create(
        'mongodb+srv://pratam:pratam@omega.fcyfti1.mongodb.net/Aquaponics?retryWrites=true&w=majority'); // Update with your connection details
    await db.open();
    var collection = db.collection('data');

    var cursor = await collection.find().toList(); // Fetch one data entry

    setState(() {
      fetchedDataList = cursor;
    });

    for (var document in fetchedDataList) {
      Timer(const Duration(seconds: 10), () => setelements(document));
    }
  }

  void setelements(Map<String, dynamic> document) {
    setState(() {
      _ammonia = document['Ammonia(g/ml)'];
      if (_ammonia > 0.00006 && _ammonia < 0.008) {
        _isIdealammoina = true;
      }
      // print('Ammonia : ${document['Ammonia(g/ml)']}');
      _ph = document['PH'];
      if (_ph > 6.8 && _ph < 7) {
        _isIdealPh = true;
      }
      // print('PH : ${document['PH']}');
      _nitrate = document['Nitrate(g/ml)'];
      if (_nitrate > 198 && _nitrate < 256) {
        _isIdealNitrate = true;
      }
      // print('Nitrate : ${document['Nitrate(g/ml)']}');
      _temp = document['Temperature (C)'];
      if (_temp > 20 && _temp < 30) {
        _isIdealTemp = true;
      }
      // print('Temperature : ${document['Temperature (C)']}');
      _dissolvedOxygen = document['Dissolved Oxygen(g/ml)'];
      if (_dissolvedOxygen > 1 && _dissolvedOxygen < 5) {
        _isIdealDissolvedOxygen = true;
      }
      // print('DO : ${document['Dissolved Oxygen(g/ml)']}');
    });
    print(_isIdealammoina);
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  num _temp = 0;
  num _dissolvedOxygen = 0;
  num _ph = 0;
  num _ammonia = 0;
  num _nitrate = 0;

  bool _isIdealTemp = false;
  bool _isIdealDissolvedOxygen = false;
  bool _isIdealPh = false;
  bool _isIdealammoina = false;
  bool _isIdealNitrate = false;

  // void startScreen() {
  //   {
  //     if (_nitrate > 273 && _nitrate < 526) {
  //       setState(() {
  //         _isIdealNitrate = true;
  //       });
  //     }
  //     if (_ammonia > 0.00006 && _ammonia < 0.008) {
  //       setState(() {
  //         _isIdealammoina = true;
  //       });
  //     }
  //     if (_ph > 6.8 && _ph < 7) {
  //       setState(() {
  //         _isIdealPh = true;
  //       });
  //     }
  //     if (_dissolvedOxygen > 1 && _dissolvedOxygen < 5) {
  //       setState(() {
  //         _isIdealDissolvedOxygen = true;
  //       });
  //     }
  //     if (_temp > 20 && _temp < 30) {
  //       setState(() {
  //         _isIdealTemp = true;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitor Parameters"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Parameters",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "Concentration",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("Temperature"),
                const Spacer(),
                Text(
                  "$_temp",
                  style: TextStyle(
                      color: _isIdealTemp ? Colors.red : Colors.green),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("Dissolved Oxygen"),
                const Spacer(),
                Text(
                  "$_dissolvedOxygen",
                  style: TextStyle(
                      color:
                          _isIdealDissolvedOxygen ? Colors.red : Colors.green),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("pH"),
                const Spacer(),
                Text(
                  "$_ph",
                  style:
                      TextStyle(color: _isIdealPh ? Colors.red : Colors.green),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("Ammonia"),
                const Spacer(),
                Text(
                  "$_ammonia",
                  style: TextStyle(
                      color: _isIdealammoina ? Colors.red : Colors.green),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("Nitrate"),
                const Spacer(),
                Text(
                  "$_nitrate",
                  style: TextStyle(
                      color: _isIdealNitrate ? Colors.red : Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
