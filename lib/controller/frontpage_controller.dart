import 'package:mixcd/controller/myfirebase.dart';
import '../view/mydialog.dart';
import 'package:flutter/material.dart';
import '../view/frontpage.dart';
import '../view/signuppage.dart';
import '../view/mixpage.dart';
import '../model/user.dart';
import '../model/cd.dart';

class FrontPageController {
  FrontPageState state;

  FrontPageController(this.state);

  void createAccount() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
  }

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter password';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  void login() async {
    if (!state.formKey.currentState.validate()) {
      return; // do not proceed
    }
    state.formKey.currentState.save();

    MyDialog.showProgressBar(state.context);

    try {
      state.user.uid = await MyFirebase.login(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      MyDialog.popProgressBar(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Login Error',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return; // do not proceed
    }

    // login success -> read user profile

    try {
      User user = await MyFirebase.readProfile(state.user.uid);
      //User user = await MyFirebase.readProfile('gi7aXajX1NUnzB5CMyi0Q0beJd82');
      state.user.displayName = user.displayName;
      state.user.zip = user.zip;
    } catch (e) {
      // no displayName and zip can be updated
      print('******READPROFILE' + e.toString());
    }

    // read cd notes this user has created /////////////////////////////// ???
    List<CD> cdlist;
    try {
      cdlist = await MyFirebase.getCDs(state.user.email);
    } catch (e) {
      cdlist = <CD>[]; // give empty cdlist
    }

    MyDialog.popProgressBar(state.context);

    MyDialog.info(
        context: state.context,
        title: 'Login Success',
        message: 'Press <OK> to See Your Mixes',
        action: () {
          Navigator.pop(state.context); // dispose this dialog
          Navigator.push(
              state.context,
              MaterialPageRoute(
                builder: (context) => MixPage(state.user, cdlist),
              ));
        });
  }
}
