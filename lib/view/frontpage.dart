import 'package:flutter/material.dart';
import '../controller/frontpage_controller.dart';
import '../model/user.dart';

class FrontPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FrontPageState();
  }
}

class FrontPageState extends State<FrontPage> {
  FrontPageController controller;
  BuildContext context;
  var user = User();
  var formKey = GlobalKey<FormState>();

  FrontPageState() {
    controller = FrontPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mix CD App'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.people, color: Colors.white),
            label: Text(
              'Create Account',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: controller.createAccount,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50.0,),
            TextFormField(
              initialValue: user.email,
              decoration: InputDecoration(
                labelText: 'Enter email as login name',
                hintText: 'email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            TextFormField(
              initialValue: user.password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter password',
                hintText: 'password',
              ),
              validator: controller.validatePassword,
              onSaved: controller.savePassword,
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text('Log In',
                  style: TextStyle(fontSize: 16.5)),
              onPressed: controller.login,
            ),
          ],
        ),
      ),
    );
  }
}
