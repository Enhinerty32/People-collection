import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:people_collection/data/storage_provider.dart';

class UserModel extends BaseModel{
    String id;
    String name;
    String email;
    String phone;
    List<ListPerson> listPeople;

    UserModel({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.listPeople,
    });

    UserModel copyWith({
        String? id,
        String? name,
        String? email,
        String? phone,
        List<ListPerson>? listPeople,
    }) => 
        UserModel(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            listPeople: listPeople ?? this.listPeople,
        );

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        listPeople: List<ListPerson>.from(json["listPeople"].map((x) => ListPerson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "listPeople": List<dynamic>.from(listPeople.map((x) => x.toJson())),
    };
    
      @override
      BaseModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
      }
}

class ListPerson {
    GeneralInformation generalInformation;
    Interests interests;
    TouchSensitiveBody touchSensitiveBody;
    PsychologicalAnalysis psychologicalAnalysis;
    DiagnosedData diagnosedData;

    ListPerson({
        required this.generalInformation,
        required this.interests,
        required this.touchSensitiveBody,
        required this.psychologicalAnalysis,
        required this.diagnosedData,
    });

    ListPerson copyWith({
        GeneralInformation? generalInformation,
        Interests? interests,
        TouchSensitiveBody? touchSensitiveBody,
        PsychologicalAnalysis? psychologicalAnalysis,
        DiagnosedData? diagnosedData,
    }) => 
        ListPerson(
            generalInformation: generalInformation ?? this.generalInformation,
            interests: interests ?? this.interests,
            touchSensitiveBody: touchSensitiveBody ?? this.touchSensitiveBody,
            psychologicalAnalysis: psychologicalAnalysis ?? this.psychologicalAnalysis,
            diagnosedData: diagnosedData ?? this.diagnosedData,
        );

    factory ListPerson.fromRawJson(String str) => ListPerson.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListPerson.fromJson(Map<String, dynamic> json) => ListPerson(
        generalInformation: GeneralInformation.fromJson(json["general_information"]),
        interests: Interests.fromJson(json["interests"]),
        touchSensitiveBody: TouchSensitiveBody.fromJson(json["touch_sensitive_body"]),
        psychologicalAnalysis: PsychologicalAnalysis.fromJson(json["psychological_analysis"]),
        diagnosedData: DiagnosedData.fromJson(json["diagnosed_data"]),
    );

    Map<String, dynamic> toJson() => {
        "general_information": generalInformation.toJson(),
        "interests": interests.toJson(),
        "touch_sensitive_body": touchSensitiveBody.toJson(),
        "psychological_analysis": psychologicalAnalysis.toJson(),
        "diagnosed_data": diagnosedData.toJson(),
    };
}

class DiagnosedData {
    int weight;
    List<String> diagnosedConditions;
    String diagnosis;
    SleepPattern sleepPattern;
    MenstrualCycle menstrualCycle;

    DiagnosedData({
        required this.weight,
        required this.diagnosedConditions,
        required this.diagnosis,
        required this.sleepPattern,
        required this.menstrualCycle,
    });

    DiagnosedData copyWith({
        int? weight,
        List<String>? diagnosedConditions,
        String? diagnosis,
        SleepPattern? sleepPattern,
        MenstrualCycle? menstrualCycle,
    }) => 
        DiagnosedData(
            weight: weight ?? this.weight,
            diagnosedConditions: diagnosedConditions ?? this.diagnosedConditions,
            diagnosis: diagnosis ?? this.diagnosis,
            sleepPattern: sleepPattern ?? this.sleepPattern,
            menstrualCycle: menstrualCycle ?? this.menstrualCycle,
        );

    factory DiagnosedData.fromRawJson(String str) => DiagnosedData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DiagnosedData.fromJson(Map<String, dynamic> json) => DiagnosedData(
        weight: json["weight"],
        diagnosedConditions: List<String>.from(json["diagnosed_conditions"].map((x) => x)),
        diagnosis: json["diagnosis"],
        sleepPattern: SleepPattern.fromJson(json["sleep_pattern"]),
        menstrualCycle: MenstrualCycle.fromJson(json["menstrual_cycle"]),
    );

    Map<String, dynamic> toJson() => {
        "weight": weight,
        "diagnosed_conditions": List<dynamic>.from(diagnosedConditions.map((x) => x)),
        "diagnosis": diagnosis,
        "sleep_pattern": sleepPattern.toJson(),
        "menstrual_cycle": menstrualCycle.toJson(),
    };
}

class MenstrualCycle {
    DateTime start;
    int bloodDuration;
    int cycleLength;

    MenstrualCycle({
        required this.start,
        required this.bloodDuration,
        required this.cycleLength,
    });

    MenstrualCycle copyWith({
        DateTime? start,
        int? bloodDuration,
        int? cycleLength,
    }) => 
        MenstrualCycle(
            start: start ?? this.start,
            bloodDuration: bloodDuration ?? this.bloodDuration,
            cycleLength: cycleLength ?? this.cycleLength,
        );

    factory MenstrualCycle.fromRawJson(String str) => MenstrualCycle.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MenstrualCycle.fromJson(Map<String, dynamic> json) => MenstrualCycle(
        start: DateTime.parse(json["start"]),
        bloodDuration: json["blood_duration"],
        cycleLength: json["cycle_length"],
    );

    Map<String, dynamic> toJson() => {
        "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "blood_duration": bloodDuration,
        "cycle_length": cycleLength,
    };
}

class SleepPattern {
    DateTime wakeUp;
    DateTime sleepTime;
    double sleepDuration;
    DateTime energyPeak;
    DateTime tirednessPeak;

    SleepPattern({
        required this.wakeUp,
        required this.sleepTime,
        required this.sleepDuration,
        required this.energyPeak,
        required this.tirednessPeak,
    });

    SleepPattern copyWith({
        DateTime? wakeUp,
        DateTime? sleepTime,
        double? sleepDuration,
        DateTime? energyPeak,
        DateTime? tirednessPeak,
    }) => 
        SleepPattern(
            wakeUp: wakeUp ?? this.wakeUp,
            sleepTime: sleepTime ?? this.sleepTime,
            sleepDuration: sleepDuration ?? this.sleepDuration,
            energyPeak: energyPeak ?? this.energyPeak,
            tirednessPeak: tirednessPeak ?? this.tirednessPeak,
        );

    factory SleepPattern.fromRawJson(String str) => SleepPattern.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SleepPattern.fromJson(Map<String, dynamic> json) => SleepPattern(
        wakeUp: DateTime.parse(json["wake_up"]),
        sleepTime: DateTime.parse(json["sleep_time"]),
        sleepDuration: json["sleep_duration"],
        energyPeak: DateTime.parse(json["energy_peak"]),
        tirednessPeak: DateTime.parse(json["tiredness_peak"]),
    );

    Map<String, dynamic> toJson() => {
        "wake_up": wakeUp.toIso8601String(),
        "sleep_time": sleepTime.toIso8601String(),
        "sleep_duration": sleepDuration,
        "energy_peak": energyPeak.toIso8601String(),
        "tiredness_peak": tirednessPeak.toIso8601String(),
    };
}

class GeneralInformation {
    String fullName;
    String description;
    String nickname;
    String mail;
    String bloodType;
    String birthDate;
    List<Location> locations;
    String workplace;
    CloseRelationships closeRelationships;
    List<PersonalHistory> personalHistory;
    String gender;
    List<String> languagesSpoken;
    List<String> phones;
    List<String> socialMedia;
    int connectionLevel;

    GeneralInformation({
        required this.fullName,
        required this.description,
        required this.nickname,
        required this.mail,
        required this.bloodType,
        required this.birthDate,
        required this.locations,
        required this.workplace,
        required this.closeRelationships,
        required this.personalHistory,
        required this.gender,
        required this.languagesSpoken,
        required this.phones,
        required this.socialMedia,
        required this.connectionLevel,
    });

    GeneralInformation copyWith({
        String? fullName,
        String? description,
        String? nickname,
        String? mail,
        String? bloodType,
        String? birthDate,
        List<Location>? locations,
        String? workplace,
        CloseRelationships? closeRelationships,
        List<PersonalHistory>? personalHistory,
        String? gender,
        List<String>? languagesSpoken,
        List<String>? phones,
        List<String>? socialMedia,
        int? connectionLevel,
    }) => 
        GeneralInformation(
            fullName: fullName ?? this.fullName,
            description: description ?? this.description,
            nickname: nickname ?? this.nickname,
            mail: mail ?? this.mail,
            bloodType: bloodType ?? this.bloodType,
            birthDate: birthDate ?? this.birthDate,
            locations: locations ?? this.locations,
            workplace: workplace ?? this.workplace,
            closeRelationships: closeRelationships ?? this.closeRelationships,
            personalHistory: personalHistory ?? this.personalHistory,
            gender: gender ?? this.gender,
            languagesSpoken: languagesSpoken ?? this.languagesSpoken,
            phones: phones ?? this.phones,
            socialMedia: socialMedia ?? this.socialMedia,
            connectionLevel: connectionLevel ?? this.connectionLevel,
        );

    factory GeneralInformation.fromRawJson(String str) => GeneralInformation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GeneralInformation.fromJson(Map<String, dynamic> json) => GeneralInformation(
        fullName: json["full_name"],
        description: json["description"],
        nickname: json["nickname"],
        mail: json["mail"],
        bloodType: json["blood_type"],
        birthDate: json["birth_date"],
        locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
        workplace: json["workplace"],
        closeRelationships: CloseRelationships.fromJson(json["close_relationships"]),
        personalHistory: List<PersonalHistory>.from(json["personal_history"].map((x) => PersonalHistory.fromJson(x))),
        gender: json["gender"],
        languagesSpoken: List<String>.from(json["languages_spoken"].map((x) => x)),
        phones: List<String>.from(json["phones"].map((x) => x)),
        socialMedia: List<String>.from(json["social_media"].map((x) => x)),
        connectionLevel: json["connection_level"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "description": description,
        "nickname": nickname,
        "mail": mail,
        "blood_type": bloodType,
        "birth_date": birthDate,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "workplace": workplace,
        "close_relationships": closeRelationships.toJson(),
        "personal_history": List<dynamic>.from(personalHistory.map((x) => x.toJson())),
        "gender": gender,
        "languages_spoken": List<dynamic>.from(languagesSpoken.map((x) => x)),
        "phones": List<dynamic>.from(phones.map((x) => x)),
        "social_media": List<dynamic>.from(socialMedia.map((x) => x)),
        "connection_level": connectionLevel,
    };
}

class CloseRelationships {
    List<String> family;
    List<String> friends;
    List<String> enemies;

    CloseRelationships({
        required this.family,
        required this.friends,
        required this.enemies,
    });

    CloseRelationships copyWith({
        List<String>? family,
        List<String>? friends,
        List<String>? enemies,
    }) => 
        CloseRelationships(
            family: family ?? this.family,
            friends: friends ?? this.friends,
            enemies: enemies ?? this.enemies,
        );

    factory CloseRelationships.fromRawJson(String str) => CloseRelationships.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CloseRelationships.fromJson(Map<String, dynamic> json) => CloseRelationships(
        family: List<String>.from(json["family"].map((x) => x)),
        friends: List<String>.from(json["friends"].map((x) => x)),
        enemies: List<String>.from(json["enemies"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "family": List<dynamic>.from(family.map((x) => x)),
        "friends": List<dynamic>.from(friends.map((x) => x)),
        "enemies": List<dynamic>.from(enemies.map((x) => x)),
    };
}

class Location {
    String namePlace;
    Place place;
    String description;

    Location({
        required this.namePlace,
        required this.place,
        required this.description,
    });

    Location copyWith({
        String? namePlace,
        Place? place,
        String? description,
    }) => 
        Location(
            namePlace: namePlace ?? this.namePlace,
            place: place ?? this.place,
            description: description ?? this.description,
        );

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        namePlace: json["name_place"],
        place: Place.fromJson(json["place"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name_place": namePlace,
        "place": place.toJson(),
        "description": description,
    };
}

class Place {
    double lat;
    double lng;

    Place({
        required this.lat,
        required this.lng,
    });

    Place copyWith({
        double? lat,
        double? lng,
    }) => 
        Place(
            lat: lat ?? this.lat,
            lng: lng ?? this.lng,
        );

    factory Place.fromRawJson(String str) => Place.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class PersonalHistory {
    String title;
    String history;

    PersonalHistory({
        required this.title,
        required this.history,
    });

    PersonalHistory copyWith({
        String? title,
        String? history,
    }) => 
        PersonalHistory(
            title: title ?? this.title,
            history: history ?? this.history,
        );

    factory PersonalHistory.fromRawJson(String str) => PersonalHistory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PersonalHistory.fromJson(Map<String, dynamic> json) => PersonalHistory(
        title: json["title"],
        history: json["history"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "history": history,
    };
}

class Interests {
    List<String> mysticalInterests;
    List<String> hobbyAreas;
    List<String> musicalPreferences;
    List<String> cinematicThemes;
    List<String> deepInterests;

    Interests({
        required this.mysticalInterests,
        required this.hobbyAreas,
        required this.musicalPreferences,
        required this.cinematicThemes,
        required this.deepInterests,
    });

    Interests copyWith({
        List<String>? mysticalInterests,
        List<String>? hobbyAreas,
        List<String>? musicalPreferences,
        List<String>? cinematicThemes,
        List<String>? deepInterests,
    }) => 
        Interests(
            mysticalInterests: mysticalInterests ?? this.mysticalInterests,
            hobbyAreas: hobbyAreas ?? this.hobbyAreas,
            musicalPreferences: musicalPreferences ?? this.musicalPreferences,
            cinematicThemes: cinematicThemes ?? this.cinematicThemes,
            deepInterests: deepInterests ?? this.deepInterests,
        );

    factory Interests.fromRawJson(String str) => Interests.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Interests.fromJson(Map<String, dynamic> json) => Interests(
        mysticalInterests: List<String>.from(json["mystical_interests"].map((x) => x)),
        hobbyAreas: List<String>.from(json["hobby_areas"].map((x) => x)),
        musicalPreferences: List<String>.from(json["musical_preferences"].map((x) => x)),
        cinematicThemes: List<String>.from(json["cinematic_themes"].map((x) => x)),
        deepInterests: List<String>.from(json["deep_interests"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "mystical_interests": List<dynamic>.from(mysticalInterests.map((x) => x)),
        "hobby_areas": List<dynamic>.from(hobbyAreas.map((x) => x)),
        "musical_preferences": List<dynamic>.from(musicalPreferences.map((x) => x)),
        "cinematic_themes": List<dynamic>.from(cinematicThemes.map((x) => x)),
        "deep_interests": List<dynamic>.from(deepInterests.map((x) => x)),
    };
}

class PsychologicalAnalysis {
    String mbti;
    Enneagram enneagram;
    BigFive bigFive;

    PsychologicalAnalysis({
        required this.mbti,
        required this.enneagram,
        required this.bigFive,
    });

    PsychologicalAnalysis copyWith({
        String? mbti,
        Enneagram? enneagram,
        BigFive? bigFive,
    }) => 
        PsychologicalAnalysis(
            mbti: mbti ?? this.mbti,
            enneagram: enneagram ?? this.enneagram,
            bigFive: bigFive ?? this.bigFive,
        );

    factory PsychologicalAnalysis.fromRawJson(String str) => PsychologicalAnalysis.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PsychologicalAnalysis.fromJson(Map<String, dynamic> json) => PsychologicalAnalysis(
        mbti: json["mbti"],
        enneagram: Enneagram.fromJson(json["enneagram"]),
        bigFive: BigFive.fromJson(json["big_five"]),
    );

    Map<String, dynamic> toJson() => {
        "mbti": mbti,
        "enneagram": enneagram.toJson(),
        "big_five": bigFive.toJson(),
    };
}

class BigFive {
    List<int> openness;
    List<int> conscientiousness;
    List<int> extraversion;
    List<int> agreeableness;
    List<int> neuroticism;

    BigFive({
        required this.openness,
        required this.conscientiousness,
        required this.extraversion,
        required this.agreeableness,
        required this.neuroticism,
    });

    BigFive copyWith({
        List<int>? openness,
        List<int>? conscientiousness,
        List<int>? extraversion,
        List<int>? agreeableness,
        List<int>? neuroticism,
    }) => 
        BigFive(
            openness: openness ?? this.openness,
            conscientiousness: conscientiousness ?? this.conscientiousness,
            extraversion: extraversion ?? this.extraversion,
            agreeableness: agreeableness ?? this.agreeableness,
            neuroticism: neuroticism ?? this.neuroticism,
        );

    factory BigFive.fromRawJson(String str) => BigFive.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BigFive.fromJson(Map<String, dynamic> json) => BigFive(
        openness: List<int>.from(json["openness"].map((x) => x)),
        conscientiousness: List<int>.from(json["conscientiousness"].map((x) => x)),
        extraversion: List<int>.from(json["extraversion"].map((x) => x)),
        agreeableness: List<int>.from(json["agreeableness"].map((x) => x)),
        neuroticism: List<int>.from(json["neuroticism"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "openness": List<dynamic>.from(openness.map((x) => x)),
        "conscientiousness": List<dynamic>.from(conscientiousness.map((x) => x)),
        "extraversion": List<dynamic>.from(extraversion.map((x) => x)),
        "agreeableness": List<dynamic>.from(agreeableness.map((x) => x)),
        "neuroticism": List<dynamic>.from(neuroticism.map((x) => x)),
    };
}

class Enneagram {
    double perfectionist;
    double helper;
    double achiever;
    double individualist;
    double investigator;
    double loyalist;
    double enthusiast;
    double challenger;
    double peacemaker;

    Enneagram({
        required this.perfectionist,
        required this.helper,
        required this.achiever,
        required this.individualist,
        required this.investigator,
        required this.loyalist,
        required this.enthusiast,
        required this.challenger,
        required this.peacemaker,
    });

    Enneagram copyWith({
        double? perfectionist,
        double? helper,
        double? achiever,
        double? individualist,
        double? investigator,
        double? loyalist,
        double? enthusiast,
        double? challenger,
        double? peacemaker,
    }) => 
        Enneagram(
            perfectionist: perfectionist ?? this.perfectionist,
            helper: helper ?? this.helper,
            achiever: achiever ?? this.achiever,
            individualist: individualist ?? this.individualist,
            investigator: investigator ?? this.investigator,
            loyalist: loyalist ?? this.loyalist,
            enthusiast: enthusiast ?? this.enthusiast,
            challenger: challenger ?? this.challenger,
            peacemaker: peacemaker ?? this.peacemaker,
        );

    factory Enneagram.fromRawJson(String str) => Enneagram.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Enneagram.fromJson(Map<String, dynamic> json) => Enneagram(
        perfectionist: json["perfectionist"]?.toDouble(),
        helper: json["helper"]?.toDouble(),
        achiever: json["achiever"],
        individualist: json["individualist"]?.toDouble(),
        investigator: json["investigator"]?.toDouble(),
        loyalist: json["loyalist"]?.toDouble(),
        enthusiast: json["enthusiast"]?.toDouble(),
        challenger: json["challenger"]?.toDouble(),
        peacemaker: json["peacemaker"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "perfectionist": perfectionist,
        "helper": helper,
        "achiever": achiever,
        "individualist": individualist,
        "investigator": investigator,
        "loyalist": loyalist,
        "enthusiast": enthusiast,
        "challenger": challenger,
        "peacemaker": peacemaker,
    };
}

class TouchSensitiveBody {
    int neck;
    int shoulder;
    int chest;
    int abdomen;
    int elbow;
    int arm;
    int hands;
    int thigh;
    int knee;
    int leg;
    int feet;
    int upperBack;
    int lowerBack;
    int glutes;
    int ear;
    int chin;
    int forehead;
    int cheek;
    int hair;
    int mouth;
    int nose;

    TouchSensitiveBody({
        required this.neck,
        required this.shoulder,
        required this.chest,
        required this.abdomen,
        required this.elbow,
        required this.arm,
        required this.hands,
        required this.thigh,
        required this.knee,
        required this.leg,
        required this.feet,
        required this.upperBack,
        required this.lowerBack,
        required this.glutes,
        required this.ear,
        required this.chin,
        required this.forehead,
        required this.cheek,
        required this.hair,
        required this.mouth,
        required this.nose,
    });

    TouchSensitiveBody copyWith({
        int? neck,
        int? shoulder,
        int? chest,
        int? abdomen,
        int? elbow,
        int? arm,
        int? hands,
        int? thigh,
        int? knee,
        int? leg,
        int? feet,
        int? upperBack,
        int? lowerBack,
        int? glutes,
        int? ear,
        int? chin,
        int? forehead,
        int? cheek,
        int? hair,
        int? mouth,
        int? nose,
    }) => 
        TouchSensitiveBody(
            neck: neck ?? this.neck,
            shoulder: shoulder ?? this.shoulder,
            chest: chest ?? this.chest,
            abdomen: abdomen ?? this.abdomen,
            elbow: elbow ?? this.elbow,
            arm: arm ?? this.arm,
            hands: hands ?? this.hands,
            thigh: thigh ?? this.thigh,
            knee: knee ?? this.knee,
            leg: leg ?? this.leg,
            feet: feet ?? this.feet,
            upperBack: upperBack ?? this.upperBack,
            lowerBack: lowerBack ?? this.lowerBack,
            glutes: glutes ?? this.glutes,
            ear: ear ?? this.ear,
            chin: chin ?? this.chin,
            forehead: forehead ?? this.forehead,
            cheek: cheek ?? this.cheek,
            hair: hair ?? this.hair,
            mouth: mouth ?? this.mouth,
            nose: nose ?? this.nose,
        );

    factory TouchSensitiveBody.fromRawJson(String str) => TouchSensitiveBody.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TouchSensitiveBody.fromJson(Map<String, dynamic> json) => TouchSensitiveBody(
        neck: json["neck"],
        shoulder: json["shoulder"],
        chest: json["chest"],
        abdomen: json["abdomen"],
        elbow: json["elbow"],
        arm: json["arm"],
        hands: json["hands"],
        thigh: json["thigh"],
        knee: json["knee"],
        leg: json["leg"],
        feet: json["feet"],
        upperBack: json["upper_back"],
        lowerBack: json["lower_back"],
        glutes: json["glutes"],
        ear: json["ear"],
        chin: json["chin"],
        forehead: json["forehead"],
        cheek: json["cheek"],
        hair: json["hair"],
        mouth: json["mouth"],
        nose: json["nose"],
    );

    Map<String, dynamic> toJson() => {
        "neck": neck,
        "shoulder": shoulder,
        "chest": chest,
        "abdomen": abdomen,
        "elbow": elbow,
        "arm": arm,
        "hands": hands,
        "thigh": thigh,
        "knee": knee,
        "leg": leg,
        "feet": feet,
        "upper_back": upperBack,
        "lower_back": lowerBack,
        "glutes": glutes,
        "ear": ear,
        "chin": chin,
        "forehead": forehead,
        "cheek": cheek,
        "hair": hair,
        "mouth": mouth,
        "nose": nose,
    };
}
