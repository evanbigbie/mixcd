import 'package:mixcd/controller/myfirebase.dart';
import '../view/songpage.dart';

class SongPageController {  // my class

  SongPageState state;

  SongPageController(this.state);

  String validateName(String value) {
    if (value.length < 1) {
      return 'Please enter a name for this song';
    }
    return null;
  }

  void saveName(String value) {
    state.songCopy.name = value;  // this is what I need to pass to cdpage
  }

    String validateCDName(String value) {
    if (value.length < 1) {
      return 'Please enter a name for this CD';
    }
    return null;
  }

  // void saveCDName(String value) {
  //   state.CDCopy.name = value;  // Need to create this somewhere ////////////////////
  // }

  String validateItunesUrl(String value) {
    if (value.length > 0 && !value.contains('https://music.apple.com')) {
      return 'Please enter a valid iTunes URL';
    }
    return null;
  }

  void saveItunesUrl(String value) {
    state.songCopy.itunesUrl = value;
  }

  String validateSpotifyUrl(String value) {
    if (value.length > 0 && !value.contains('https://open.spotify.com')) {
      return 'Please enter a valid Spotify URL';
    }
    return null;
  }

  void saveSpotifyUrl(String value) {
    state.songCopy.spotifyUrl = value;
  }

  String validateSoundCloudUrl(String value) {
    if (value.length > 0 && !value.contains('https://soundcloud.com')) {
      return 'Please enter a valid SoundCloud URL';
    }
    return null;
  }

  void saveSoundCloudUrl(String value) {
    state.songCopy.soundCloudUrl = value;
  }

  String validateBandCampUrl(String value) {
    if (value.length > 0 && !value.contains('https://') || value.length > 0 && !value.contains('bandcamp.com')) {
      return 'Please enter a valid BandCamp URL';
    }
    return null;
  }

  void saveBandCampUrl(String value) {
    state.songCopy.bandCampUrl = value;
  }

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();

    state.songCopy.createdBy = state.user.email;
    state.songCopy.lastUpdatedAt = DateTime.now();
    state.songCopy.documentId = await MyFirebase.addSong(state.songCopy);
    
  }
}