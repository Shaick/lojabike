import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String name;
  String email;
  String urlimage;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.urlimage});

  UserModel.fromSnapshot(User currentUser)
      : id = currentUser.uid,
        name = currentUser.displayName!,
        email = currentUser.email!,
        urlimage = currentUser.photoURL!;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "urlimage": urlimage,
    };
  }
}
