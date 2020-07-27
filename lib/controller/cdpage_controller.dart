import 'package:mixcd/controller/myfirebase.dart';
import 'package:mixcd/view/mydialog.dart';
import 'package:flutter/material.dart';

import '../view/cdpage.dart';
import '../view/songpage.dart';
import '../model/cd.dart';
import '../model/song.dart';

class CDPageController {

  CDPageState state;

  CDPageController(this.state);

  String validateImageUrl(String value) {
    if (value == null || value.length < 5) {
      return 'Please enter a valid image url';
    }
    return null;
  }

  void saveImageUrl(String value) {
    state.cdCopy.imageUrl = value;
  }

  String validateName(String value) {
    if (value == null || value.length < 5) {
      return 'Enter name for your mix';
    }
    return null;
  }

  void saveName(String value) {
    state.cdCopy.name = value;
  }

  String validateAuthor(String value) {
    if (value == null || value.length < 1) {
      return 'Enter mix author';
    }
    return null;
  }

  void saveAuthor(String value) {
    state.cdCopy.author = value;
  }

  String validateSharedWith(String value) {
    if (value == null || value.trim().isEmpty) {
      return null; // no sharing
    }
    for (var email in value.split(',')) {
      if (!(email.contains('.') && email.contains('@'))) {
        return 'Enter comma(,) separated email list';
      }
      if (email.indexOf('@') != email.lastIndexOf('@')) {
        return 'Enter comma(,) separated email list';
      }
    }
    return null;
  }

  void saveSharedWith(String value) {
    if (value == null || value.trim().isEmpty) {
      return;
    }
    state.cdCopy.sharedWith = [];
    List<String> emaillist = value.split(',');
    for (var email in emaillist) {
      state.cdCopy.sharedWith.add(email.trim());
    }
  }

  //String validateNotes(String value) {
  //  if (value == null || value.length < 5) {
  //    return 'Enter liner notes (min 5 chars)';
  //  }
  //  return null;
  //}

  void saveNotes (String value) {
    state.cdCopy.notes = value;
  }

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();

    state.cdCopy.createdBy = state.user.email;
    state.cdCopy.lastUpdatedAt = DateTime.now();

    try {
      if (state.cd == null) {
        // add button
        state.cdCopy.documentId = await MyFirebase.addCD(state.cdCopy);
      } else {
        // from homepage to edit a book
        await MyFirebase.updateCD(state.cdCopy);
      }
      Navigator.pop(state.context, state.cdCopy);
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Firestore Save Error',
        message: 'Firestore is unavailable now. Try again later',
        action: () {
          Navigator.pop(state.context);
          Navigator.pop(state.context, null);
        },
      );
    }
  }

  void addButton() async {
    CD cd = await Navigator.push(state.context, MaterialPageRoute(
    builder: (context) => SongPage(state.user, null),
    ));
  }

  void trackListings() async {
    List<Song> songs = await MyFirebase.getSongs(state.user.email);
    print('# of songs: ' + songs.length.toString());
    for (var song in songs) {
      print(song.name);
    }
  }
}

