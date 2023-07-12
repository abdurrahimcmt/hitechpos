// To parse this JSON data, do
//
//     final postdemo = postdemoFromJson(jsonString);

import 'dart:convert';

List<Postdemo> postdemoFromJson(String str) => List<Postdemo>.from(json.decode(str).map((x) => Postdemo.fromJson(x)));

String postdemoToJson(List<Postdemo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postdemo {
    int postId;
    int id;
    String name;
    String email;
    String body;

    Postdemo({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });

    factory Postdemo.fromJson(Map<String, dynamic> json) => Postdemo(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };

  void addAll(List fetchedPosts) {}
}
