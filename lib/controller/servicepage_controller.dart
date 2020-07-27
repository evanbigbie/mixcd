import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:mixcd/controller/myfirebase.dart';

import '../view/servicepage.dart';
import '../view/cdpage.dart';
import '../model/cd.dart';

class ServicePageController {

  ServicePageState state;

  String servicetype = null;

  ServicePageController(this.state);

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

  void  radioServiceChanged(String value) {
    state.stateChanged((){
      servicetype = value;
    });
  }

  //   void save() async {
  //   if (!state.formKey.currentState.validate()) {
  //     return;
  //   }
  //   state.formKey.currentState.save();

  //   state.cdCopy.createdBy = state.user.email;
  //   state.cdCopy.lastUpdatedAt = DateTime.now();

  //   try {
  //     if (state.cd == null) {
  //       // add button
  //       state.cdCopy.documentId = await MyFirebase.addCD(state.cdCopy);
  //     } else {
  //       // from homepage to edit a book
  //       await MyFirebase.updateCD(state.cdCopy);
  //     }
  //     Navigator.pop(state.context, state.cdCopy);
  //   } catch (e) {
  //     MyDialog.info(
  //       context: state.context,
  //       title: 'Firestore Save Error',
  //       message: 'Firestore is unavailable now. Try again later',
  //       action: () {
  //         Navigator.pop(state.context);
  //         Navigator.pop(state.context, null);
  //       },
  //     );
  //   }
  // }

}
