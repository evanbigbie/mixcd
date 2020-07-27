import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/cd.dart';
import '../model/song.dart';
import '../controller/mixpage_controller.dart';

class MixPage extends StatefulWidget {
  final User user;
  final List<CD> cdlist;

  MixPage(this.user, this.cdlist);

  @override
  State<StatefulWidget> createState() {
    return MixPageState(user, cdlist);
  }
}

class MixPageState extends State<MixPage> {
  User user;
  List<CD> cdlist;
  List<Song> songlist;
  MixPageController controller;
  BuildContext context;
  List<int> deleteIndices;

  MixPageState(this.user, this.cdlist) {
    controller = MixPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My CDs'),
          actions: deleteIndices == null
              ? null
              : <Widget>[
                  FlatButton.icon(
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                    onPressed: controller.deleteButton,
                  ),
                ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.displayName,
                  style: TextStyle(fontSize: 18.5)),
                accountEmail: Text(user.email,
                  style: TextStyle(fontSize: 18.5)),
              ),
              ListTile(
                leading: Icon(Icons.add_to_home_screen),
                title: Text('Select My Service',
                  style: TextStyle(fontSize: 16.5)),
                onTap: controller.serviceMenu,
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('CDs Shared With Me',
                  style: TextStyle(fontSize: 16.5)),
                onTap: controller.sharedWithMeMenu,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out',
                  style: TextStyle(fontSize: 16.5)),
                onTap: controller.signOut,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.add),
          onPressed: controller.addButton,
        ),
        body: ListView.builder(
          itemCount: cdlist.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5.0),
              color: deleteIndices != null && deleteIndices.contains(index)
                  ? Colors.cyan[200]
                  : Colors.white,
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: cdlist[index].imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
                title: Text(cdlist[index].name,
                  style: TextStyle(fontSize: 16.5)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Text(cdlist[index].documentId), /////////////////
                    Text('by ' + cdlist[index].author,
                  style: TextStyle(fontSize: 16.5)), //////////////
                  ],
                ),
                trailing: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.play_arrow),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black45,
                  hoverElevation: 20,
                  onPressed: controller.playButton,
                ),
                onTap: () => controller.onTap(index),
                onLongPress: () => controller.longPress(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
