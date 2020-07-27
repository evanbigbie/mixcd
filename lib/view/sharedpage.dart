import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/cd.dart';
import '../controller/sharedpage_controller.dart';

class SharedCDsPage extends StatefulWidget { // changed to stateful 12/5
  final User user;
  final List<CD> cdlist;

  SharedCDsPage(this.user, this.cdlist);

  @override
  State<StatefulWidget> createState() {
    return SharedCDsPageState(user, cdlist);
  }
}

class SharedCDsPageState extends State<SharedCDsPage> {

  User user;
  List<CD> cdlist;  // changed cds to cdlist 12/4
  SharedCDsPageController controller;
  BuildContext context;
  List<int> deleteIndices;

  SharedCDsPageState(this.user, this.cdlist) {  // changed cds to cdlist 12/4
    controller = SharedCDsPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared CDs'),
      ),
      body: ListView.builder(
        itemCount: cdlist.length,  // changed cds to cdlist 12/4
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(5.0),
          color: Colors.grey[200],
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: cdlist[index].imageUrl,  // changed cds to cdlist 12/4
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
            ),
            title: Text(cdlist[index].name), // changed cds to cdlist 12/4
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Text('Name:  ${cdlist[index].name}'),
                Text('Created by:  ${cdlist[index].author}'),  // changed cds to cdlist 12/4
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
          ),
        ),
      ),
    );
  }

}