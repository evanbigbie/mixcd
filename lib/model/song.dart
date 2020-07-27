import 'package:flutter/material.dart';

class Song {

  String documentId; // firestore doc id
  String name;
  String CDName; ////////////////////
  String itunesUrl;
  String spotifyUrl;
  String soundCloudUrl;
  String bandCampUrl;
  String createdBy;
  DateTime lastUpdatedAt;
  List<dynamic> sharedWith; // may need to load this up with data from *CD* sharedWith * * *

  Song({
    this.name,
    this.CDName,
    this.itunesUrl,
    this.spotifyUrl,
    this.soundCloudUrl,
    this.bandCampUrl,
    this.createdBy,
    this.lastUpdatedAt,
    this.sharedWith, // * * *
  });

  Song.empty() {
    this.name = '';
    this.CDName = '';
    this.itunesUrl = '';
    this.spotifyUrl = '';
    this.soundCloudUrl = '';
    this.bandCampUrl = '';
    this.createdBy = '';
    this.sharedWith = <dynamic>[]; // * * *
  }

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      NAME: name,
      CDNAME: CDName,
      ITUNESURL: itunesUrl,
      SPOTIFYURL: spotifyUrl,
      SOUNDCLOUDURL: soundCloudUrl,
      BANDCAMPURL: bandCampUrl,
      CREATEDBY: createdBy,
      LASTUPDATEDAT: lastUpdatedAt,
      SHAREDWITH: sharedWith,
    };
  }

    static Song deserialize(Map<String, dynamic> data, String docId) {
    var song = Song(
      name: data[Song.NAME],
      CDName: data[Song.CDNAME],
      itunesUrl: data[Song.ITUNESURL],
      spotifyUrl: data[Song.SPOTIFYURL],
      soundCloudUrl: data[Song.SOUNDCLOUDURL],
      bandCampUrl: data[Song.ITUNESURL],
      createdBy: data[Song.CREATEDBY],
      sharedWith: data[Song.SHAREDWITH],
    );
    if (data[Song.LASTUPDATEDAT] != null) {
      song.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
        data[Song.LASTUPDATEDAT].millisecondsSinceEpoch);
    }
    song.documentId = docId;
    return song;
  }

  static const SONGSCOLLECTION = 'songs'; // may need diff one for each CD ?
  static const NAME = 'name';
  static const CDNAME = "CDName";
  static const ITUNESURL = 'itunesUrl';
  static const SPOTIFYURL = 'spotifyUrl';
  static const SOUNDCLOUDURL = 'soundCloudUrl';
  static const BANDCAMPURL = 'bandCampUrl';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'lastUpdatedAt';
  static const SHAREDWITH = 'sharedWith';

}