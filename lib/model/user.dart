class User {
  String email;
  String password;
  String displayName;
  String service;
  int zip;
  String uid; // Unique user id

  User({ // define constructor with named parameters
    this.email,
    this.password,
    this.displayName,
    this.service,
    this.zip,
    this.uid,
  });

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      EMAIL: email,
      DISPLAYNAME: displayName,
      SERVICE: service,
      ZIP: zip,
      UID: uid,
    };
  }

  static User deserialize(Map<String, dynamic> document) {
    return User(
      email: document[EMAIL],
      displayName: document[DISPLAYNAME],
      service: document[SERVICE],
      zip: document[ZIP],
      uid: document[UID],
    );
  }

  // instead of risking typos we will define constant names:
  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const DISPLAYNAME = 'displayName';
  static const SERVICE = 'service';
  static const ZIP = 'zip';
  static const UID = 'uid';
}