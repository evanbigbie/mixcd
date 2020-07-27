import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/servicepage_controller.dart';

class ServicePage extends StatefulWidget {
  // changed to stateful 12/5
  final User user;

  ServicePage(this.user);

  @override
  State<StatefulWidget> createState() {
    return ServicePageState(user);
  }
}

class ServicePageState extends State<ServicePage> {
  User user;
  ServicePageController controller;
  BuildContext context;
  List<int> deleteIndices;

  ServicePageState(this.user) {
    controller = ServicePageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 115.0,
          ),
          Text(
              '     Your Preferred \n Streaming Service: \n ___________________',
              style: TextStyle(height: 1.5, fontSize: 17.5)),
          Container(
            padding: EdgeInsets.only(top: 42, left: 107.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RadioListTile<String>(
                  title: Text('iTunes', style: TextStyle(fontSize: 17)),
                  value: 'iTunes',
                  groupValue: controller.servicetype,
                  onChanged: controller.radioServiceChanged,
                ),
                RadioListTile<String>(
                  title: Text('Spotify', style: TextStyle(fontSize: 17)),
                  value: 'Spotify',
                  groupValue: controller.servicetype,
                  onChanged: controller.radioServiceChanged,
                ),
                RadioListTile<String>(
                  title: Text('SoundCloud', style: TextStyle(fontSize: 17)),
                  value: 'SoundCloud',
                  groupValue: controller.servicetype,
                  onChanged: controller.radioServiceChanged,
                ),
                RadioListTile<String>(
                  title: Text('BandCamp', style: TextStyle(fontSize: 17)),
                  value: 'BandCamp',
                  groupValue: controller.servicetype,
                  onChanged: controller.radioServiceChanged,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          RaisedButton(
            onPressed: () {} /*controller.save*/,
            padding: EdgeInsets.all(0.0),
            child: Container(
                decoration: BoxDecoration(color: Colors.blue[600]),
                padding: EdgeInsets.only(
                    top: 8.5, bottom: 8.5, left: 35.0, right: 35.0),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16.5, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
