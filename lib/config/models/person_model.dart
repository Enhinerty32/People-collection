import 'dart:convert';

class Person {
    final String ?id;
    final String nick;
    final String name;
    final String birthdate;
    final String description;
    final String gender;
    final String phone;
    final List<String> socialNet;
    final List<Extra> extras;

    Person({
          this.id,
        required this.nick,
        required this.name,
        required this.birthdate,
        required this.description,
        required this.gender,
        required this.phone,
        required this.socialNet,
        required this.extras,
    });

    Person copyWith({
        String? id,
        String? nick,
        String? name,
        String? birthdate,
        String? description,
        String? gender,
        String? phone,
        List<String>? socialNet,
        List<Extra>? extras,
    }) => 
        Person(
            id: id ?? this.id,
            nick: nick ?? this.nick,
            name: name ?? this.name,
            birthdate: birthdate ?? this.birthdate,
            description: description ?? this.description,
            gender: gender ?? this.gender,
            phone: phone ?? this.phone,
            socialNet: socialNet ?? this.socialNet,
            extras: extras ?? this.extras,
        );

    factory Person.fromRawJson(String str) => Person.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        nick: json["nick"],
        name: json["name"],
        birthdate: json["birthdate"],
        description: json["description"],
        gender: json["gender"],
        phone: json["phone"],
        socialNet: List<String>.from(json["socialNet"].map((x) => x)),
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nick": nick,
        "name": name,
        "birthdate": birthdate,
        "description": description,
        "gender": gender,
        "phone": phone,
        "socialNet": List<dynamic>.from(socialNet.map((x) => x)),
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
    };
}

class Extra {
    final String title;
    final String description;

    Extra({
        required this.title,
        required this.description,
    });

    Extra copyWith({
        String? title,
        String? description,
    }) => 
        Extra(
            title: title ?? this.title,
            description: description ?? this.description,
        );

    factory Extra.fromRawJson(String str) => Extra.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}
