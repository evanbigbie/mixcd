import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/song.dart';
import '../controller/songpage_controller.dart';

class SongPage extends StatefulWidget {

  User user;
  Song song;

  SongPage(this.user, this.song);

  @override
  State<StatefulWidget> createState() {
    return SongPageState(user, song);
  }

}

class SongPageState extends State<SongPage> {

User user;
Song song;
Song songCopy;
//String CDName = null; ////////////////// added this for initial value
SongPageController controller;
var formKey = GlobalKey<FormState>();

SongPageState(this.user, this.song){
  controller = SongPageController(this);
  if (song == null) {
    // add button
    songCopy = Song.empty();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Song Info:'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 150.0,),
            // TextFormField(
            //   initialValue: CDName.name,
            //   decoration: InputDecoration(
            //     labelText: '  Mix Name:',
            //   ),
            //   autocorrect: false,
            //   validator: controller.validateCDName,
            //   onSaved: controller.saveCDName,
            // ),
            TextFormField(
              initialValue: songCopy.name,
              decoration: InputDecoration(
                labelText: '  New Song Name:',
              ),
              autocorrect: false,
              validator: controller.validateName,
              onSaved: controller.saveName, // this is what is being called
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              initialValue: songCopy.itunesUrl,
              decoration: InputDecoration(
                labelText: '  iTunes URL:',
              ),
              autocorrect: false,
              validator: controller.validateItunesUrl,
              onSaved: controller.saveItunesUrl,
            ),
            TextFormField(
              initialValue: songCopy.spotifyUrl,
              decoration: InputDecoration(
                labelText: '  Spotify URL:',
              ),
              autocorrect: false,
              validator: controller.validateSpotifyUrl,
              onSaved: controller.saveSpotifyUrl,
            ),
            TextFormField(
              initialValue: songCopy.soundCloudUrl,
              decoration: InputDecoration(
                labelText: '  SoundCloud URL:',
              ),
              autocorrect: false,
              validator: controller.validateSoundCloudUrl,
              onSaved: controller.saveSoundCloudUrl,
            ),
            TextFormField(
              initialValue: songCopy.bandCampUrl,
              decoration: InputDecoration(
                labelText: '  BandCamp URL:',
              ),
              autocorrect: false,
              validator: controller.validateBandCampUrl,
              onSaved: controller.saveBandCampUrl,
            ),
            SizedBox(height: 35.0,),
            RaisedButton(
              child: Text('Save',
                  style: TextStyle(fontSize: 16.5)),
              onPressed: controller.save,
            ),
          ],),
      ),
    );
  }

}