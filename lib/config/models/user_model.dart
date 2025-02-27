import 'dart:convert';

class MyUser {
    final String id;
    final String email;
    final List<String> people;

    MyUser({
        required this.id,
        required this.email,
        required this.people,
    });

    MyUser copyWith(Map<String, dynamic>? data, {
        String? id,
        String? email,
        List<String>? people,
    }) => 
        MyUser(
            id: id ?? this.id,
            email: email ?? this.email,
            people: people ?? this.people,
        );

    factory MyUser.fromRawJson(String str) => MyUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        id: json["id"],
        email: json["email"],
        people: List<String>.from(json["people"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "people": List<String>.from(people.map((x) => x)),
    };
}
