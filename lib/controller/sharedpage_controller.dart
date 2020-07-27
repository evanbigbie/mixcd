import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:mixcd/controller/myfirebase.dart';

import '../view/sharedpage.dart';
import '../view/cdpage.dart';
import '../model/cd.dart';

class SharedCDsPageController {
  SharedCDsPageState state;

  SharedCDsPageController(this.state);

  void playButton() async {
    const url = 'https://soundcloud.com/flyinglotus/sds-mac-miller-instrumental';
    //var url = state.songlist;
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
      print("something is happening");
    } else {
      throw 'Could not launch $url';
    }
  }

}

