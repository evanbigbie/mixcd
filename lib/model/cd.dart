import 'package:flutter/material.dart';

class CD {
  String documentId; // firestore doc id
  String name;
  String author;
  String imageUrl;
  String notes;
  String createdBy;
  DateTime lastUpdatedAt; // created or revised
  List<dynamic> sharedWith; // will be emails but dynamic to be safe

  CD({ // CD constructor
    this.name,
    this.author,
    this.imageUrl,
    this.notes,
    this.createdBy,
    this.lastUpdatedAt,
    this.sharedWith,
  });

  CD.empty() {
    this.name = '';
    this.author = '';
    this.imageUrl = '';
    this.notes = '';
    this.createdBy = '';
    this.sharedWith = <dynamic>[]; // dynamic type empty list
  }

  CD.clone(CD cd) {
    this.documentId = cd.documentId;
    this.name = cd.name;
    this.author = cd.author;
    this.notes = cd.notes;
    this.imageUrl = cd.imageUrl;
    this.lastUpdatedAt = cd.lastUpdatedAt;
    this.createdBy = cd.createdBy;
    this.sharedWith = <dynamic>[]..addAll(cd.sharedWith); // deep copy
  }

  // Map is an array which is acceptable to firestore
  Map<String, dynamic> serialize() { // returns Map data structure
    return <String, dynamic>{
      NAME: name,
      AUTHOR: author,
      IMAGEURL: imageUrl,
      NOTES: notes,
      CREATEDBY: createdBy,
      LASTUPDATEDAT: lastUpdatedAt,
      SHAREDWITH: sharedWith,
    };
  }

  static CD deserialize(Map<String, dynamic> data, String docId) {
    var cd = CD(
      name: data[CD.NAME],
      author: data[CD.AUTHOR],
      imageUrl: data[CD.IMAGEURL],
      notes: data[CD.NOTES],
      createdBy: data[CD.CREATEDBY],
      sharedWith: data[CD.SHAREDWITH],
    );
    if (data[CD.LASTUPDATEDAT] != null) {
      cd.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
        data[CD.LASTUPDATEDAT].millisecondsSinceEpoch);
    }
    cd.documentId = docId;
    return cd;
  }

  static const CDSCOLLECTION = 'cds';
  static const NAME = 'name';
  static const AUTHOR = 'author';
  static const IMAGEURL = 'imageUrl';
  static const NOTES = 'notes';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'LastUpdatedAt';
  static const SHAREDWITH = 'sharedWith';

}