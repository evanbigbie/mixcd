import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/cd.dart';
import '../model/song.dart';
import '../controller/cdpage_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CDPage extends StatefulWidget {

  final User user; // immutable -- changes should be made in state object below
  final CD cd;
  //final List<Song> songs;

  CDPage(this.user, this.cd /*, this.songs*/);

  @override
  State<StatefulWidget> createState() {
    return CDPageState(user, cd /*, songs*/);
  }
}

class CDPageState extends State<CDPage> { // 'especially for BookPage type'?

  User user;
  CD cd;
  CD cdCopy;
  List<Song> songs;
  CDPageController controller;
  var formKey = GlobalKey<FormState>(); // FormState type object

  CDPageState(this.user, this.cd /*, this.songs*/) { // CDPageState constructor
    controller = CDPageController(this); // pass the current state object
    if (cd == null) {
      // addButton
      cdCopy = CD.empty(); // CD.empty constructor
    } else {
      cdCopy = CD.clone(cd); // clone
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CD Info'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.addButton,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true, // I added this to hopefully be able to nest a ListView
          children: <Widget>[
            SizedBox(height: 55.0,),
            CachedNetworkImage(
              imageUrl: cdCopy.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline, size: 100),
              height: 250,
              width: 250,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              initialValue: cdCopy.imageUrl,
              decoration: InputDecoration(
                labelText: 'Cover Image Url',
              ),
              autocorrect: false,
              validator: controller.validateImageUrl,
              onSaved: controller.saveImageUrl,
            ),
              TextFormField(
              initialValue: cdCopy.name,
              decoration: InputDecoration(
                labelText: 'Mix Name',
              ),
              autocorrect: false,
              validator: controller.validateName,
              onSaved: controller.saveName,
            ),
            TextFormField(
              initialValue: cdCopy.author,
              decoration: InputDecoration(
                labelText: 'Mix Author',
              ),
              autocorrect: false,
              validator: controller.validateAuthor,
              onSaved: controller.saveAuthor,
            ),
            TextFormField(
              initialValue: cdCopy.sharedWith.join(',').toString(),
              decoration: InputDecoration(
                //labelText: 'Shared With (comma separated usernames)',
                labelText: 'Shared With (Comma Separated Usernames)',
              ),
              autocorrect: false,
              validator: controller.validateSharedWith,
              onSaved: controller.saveSharedWith,
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Liner Notes',
              ),
              autocorrect: false,
              initialValue: cdCopy.notes,
              //validator: controller.validateNotes,
              onSaved: controller.saveNotes,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (context, index) => Container(
                child: Column(
                  children: <Widget>[
                    //Text('Name:  ${songs[index].name}'),            Right here... Watch videos on how to make this call a real index value
                  ]
                )
              )
            ),

            Text('Track Listing: \n1. \n2. \n3. \n4. \n5.', style: TextStyle(fontSize: 16, color: Colors.black54),),
            // TextFormField(
            //   maxLines: 1,
            //   // decoration: InputDecoration(
            //   //   labelText: 'Track Listing:',
            //   // ),
            //   autocorrect: false,
            //   //initialValue: cdCopy.notes,
            //   initialValue: null,
            //   //validator: controller.validateNotes,
            //   //onSaved: controller.saveNotes,
            // ),   
            
            // Text('CreatedBy: ' +cdCopy.createdBy),
            // Text('Last Updated At: ' +cdCopy.lastUpdatedAt.toString()),
            // Text('DocumentID: ' +cdCopy.documentId.toString()),
            SizedBox(height: 10.0,),
            RaisedButton(
              child: Text('Save',
                  style: TextStyle(fontSize: 16.5)),
              onPressed: controller.save,
            )
          ],
        ),
      ),
    );
  }
}
