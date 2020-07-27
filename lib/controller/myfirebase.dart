import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';
import '../model/cd.dart';
import '../model/song.dart';


class MyFirebase {

  static Future<String> createAccount({String email, String password}) async {
    AuthResult auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return auth.user.uid;
  }

  static void createProfile(User user) async {
    await Firestore.instance.collection(User.PROFILE_COLLECTION)
            .document(user.uid) // create document with unique name
            .setData(user.serialize()); // what we are going to store defined by serialize
  }

  static Future<String> login({String email, String password}) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static Future<User> readProfile(String uid) async {
    DocumentSnapshot doc = await Firestore.instance.collection(User.PROFILE_COLLECTION)
            .document(uid).get();
    return User.deserialize(doc.data);
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static Future<String> addCD(CD cd) async {
    DocumentReference ref = await Firestore.instance.collection(CD.CDSCOLLECTION)
            .add(cd.serialize());
    return ref.documentID;
  }

  static Future<List<CD>> getCDs(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection(CD.CDSCOLLECTION)
          .where(CD.CREATEDBY, isEqualTo: email)
          .getDocuments();
    var cdlist = <CD>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return cdlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      cdlist.add(CD.deserialize(doc.data, doc.documentID)); // doc ID that Firestore has created
    }
    return cdlist;
  }

  static Future<void> updateCD(CD cd) async {
    await Firestore.instance.collection(CD.CDSCOLLECTION)
            .document(cd.documentId)
            .setData(cd.serialize());
  }

  static Future<void> deleteCD(CD cd) async {
    await Firestore.instance.collection(CD.CDSCOLLECTION)
            .document(cd.documentId).delete();
  }

  static Future<List<CD>> getCDsSharedWithMe(String email) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
              .collection(CD.CDSCOLLECTION)
              .where(CD.SHAREDWITH, arrayContains: email)
              .orderBy(CD.CREATEDBY)
              .orderBy(CD.LASTUPDATEDAT)
              .getDocuments();
      var cds = <CD>[];
      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        return cds;
      }
      for (DocumentSnapshot doc in querySnapshot.documents) {
        cds.add(CD.deserialize(doc.data, doc.documentID));
      }
      return cds;
    } catch (e) {
      throw e;
    }
  }

  // * * * * * * * ** * * * **  * ****  * *   * ** * * ** * *** *  ** * * * * *

  // May need to change some of the logic here:

   static Future<String> addSong(Song song) async {
    DocumentReference ref = await Firestore.instance.collection(Song.SONGSCOLLECTION)
            .add(song.serialize());
    return ref.documentID;
  }

  static Future<List<Song>> getSongs(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection(Song.SONGSCOLLECTION) ///////////////////////////////
          .where(Song.CREATEDBY, isEqualTo: email)
          .getDocuments();
    var songlist = <Song>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return songlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      songlist.add(Song.deserialize(doc.data, doc.documentID)); // doc ID that Firestore has created
    }
    return songlist;
  }

  static Future<void> updateSong(Song song) async {
    await Firestore.instance.collection(Song.SONGSCOLLECTION)
            .document(song.documentId)
            .setData(song.serialize());
  }

  static Future<void> deleteSong(Song song) async {
    await Firestore.instance.collection(Song.SONGSCOLLECTION)
            .document(song.documentId).delete();
  }

  // static Future<List<Song>> getSongsSharedWithMe(String email) async {
  //   try {
  //     QuerySnapshot querySnapshot = await Firestore.instance
  //             .collection(Song.SONGSCOLLECTION)
  //             .where(Song.SHAREDWITH, arrayContains: email)
  //             //.orderBy(CD.CREATEDBY)
  //             //.orderBy(CD.LASTUPDATEDAT)
  //             .getDocuments();
  //     var songs = <Song>[];
  //     if (querySnapshot == null || querySnapshot.documents.length == 0) {
  //       return songs;
  //     }
  //     for (DocumentSnapshot doc in querySnapshot.documents) {
  //       songs.add(Song.deserialize(doc.data, doc.documentID));
  //     }
  //     return songs;
  //   } catch (e) {
  //     throw e;
  //   }
  // }





}