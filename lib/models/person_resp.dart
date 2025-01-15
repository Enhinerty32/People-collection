import 'dart:convert';

class PersonResp {
    int id;
    GeneralInformation generalInformation;
    Interests interests;
    Map<String, int> touchSensitiveBody;
    PsychologicalAnalysis psychologicalAnalysis;
    DiagnosedData diagnosedData;
    Map<String, ContactAbout> contactAbout;

    PersonResp({
        required this.id,
        required this.generalInformation,
        required this.interests,
        required this.touchSensitiveBody,
        required this.psychologicalAnalysis,
        required this.diagnosedData,
        required this.contactAbout,
    });

    factory PersonResp.fromRawJson(String str) => PersonResp.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PersonResp.fromJson(Map<String, dynamic> json) => PersonResp(
        id: json["id"],
        generalInformation: GeneralInformation.fromJson(json["general_information"]),
        interests: Interests.fromJson(json["interests"]),
        touchSensitiveBody: Map.from(json["touch_sensitive_body"]).map((k, v) => MapEntry<String, int>(k, v)),
        psychologicalAnalysis: PsychologicalAnalysis.fromJson(json["psychological_analysis"]),
        diagnosedData: DiagnosedData.fromJson(json["diagnosed_data"]),
        contactAbout: Map.from(json["contact_about"]).map((k, v) => MapEntry<String, ContactAbout>(k, ContactAbout.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "general_information": generalInformation.toJson(),
        "interests": interests.toJson(),
        "touch_sensitive_body": Map.from(touchSensitiveBody).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "psychological_analysis": psychologicalAnalysis.toJson(),
        "diagnosed_data": diagnosedData.toJson(),
        "contact_about": Map.from(contactAbout).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class ContactAbout {
    List<String> options;
    String selected;

    ContactAbout({
        required this.options,
        required this.selected,
    });

    factory ContactAbout.fromRawJson(String str) => ContactAbout.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ContactAbout.fromJson(Map<String, dynamic> json) => ContactAbout(
        options: List<String>.from(json["options"].map((x) => x)),
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x)),
        "selected": selected,
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
    int sleepDuration;
    DateTime energyPeak;
    DateTime tirednessPeak;

    SleepPattern({
        required this.wakeUp,
        required this.sleepTime,
        required this.sleepDuration,
        required this.energyPeak,
        required this.tirednessPeak,
    });

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
    String address;
    String workplace;
    CloseRelationships closeRelationships;
    List<String> personalHistory;
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
        required this.address,
        required this.workplace,
        required this.closeRelationships,
        required this.personalHistory,
        required this.gender,
        required this.languagesSpoken,
        required this.phones,
        required this.socialMedia,
        required this.connectionLevel,
    });

    factory GeneralInformation.fromRawJson(String str) => GeneralInformation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GeneralInformation.fromJson(Map<String, dynamic> json) => GeneralInformation(
        fullName: json["full_name"],
        description: json["description"],
        nickname: json["nickname"],
        mail: json["mail"],
        bloodType: json["blood_type"],
        birthDate: json["birth_date"],
        address: json["address"],
        workplace: json["workplace"],
        closeRelationships: CloseRelationships.fromJson(json["close_relationships"]),
        personalHistory: List<String>.from(json["personal_history"].map((x) => x)),
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
        "address": address,
        "workplace": workplace,
        "close_relationships": closeRelationships.toJson(),
        "personal_history": List<dynamic>.from(personalHistory.map((x) => x)),
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
    Mbti mbti;
    Enneagram enneagram;
    BigFive bigFive;

    PsychologicalAnalysis({
        required this.mbti,
        required this.enneagram,
        required this.bigFive,
    });

    factory PsychologicalAnalysis.fromRawJson(String str) => PsychologicalAnalysis.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PsychologicalAnalysis.fromJson(Map<String, dynamic> json) => PsychologicalAnalysis(
        mbti: Mbti.fromJson(json["mbti"]),
        enneagram: Enneagram.fromJson(json["enneagram"]),
        bigFive: BigFive.fromJson(json["big_five"]),
    );

    Map<String, dynamic> toJson() => {
        "mbti": mbti.toJson(),
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
    int perfectionist;
    int helper;
    int achiever;
    int individualist;
    int investigator;
    int loyalist;
    int enthusiast;
    int challenger;
    int peacemaker;

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

    factory Enneagram.fromRawJson(String str) => Enneagram.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Enneagram.fromJson(Map<String, dynamic> json) => Enneagram(
        perfectionist: json["perfectionist"],
        helper: json["helper"],
        achiever: json["achiever"],
        individualist: json["individualist"],
        investigator: json["investigator"],
        loyalist: json["loyalist"],
        enthusiast: json["enthusiast"],
        challenger: json["challenger"],
        peacemaker: json["peacemaker"],
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

class Mbti {
    int extraversionIntroversion;
    int sensingIntuition;
    int thinkingFeeling;
    int judgingPerceiving;

    Mbti({
        required this.extraversionIntroversion,
        required this.sensingIntuition,
        required this.thinkingFeeling,
        required this.judgingPerceiving,
    });

    factory Mbti.fromRawJson(String str) => Mbti.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Mbti.fromJson(Map<String, dynamic> json) => Mbti(
        extraversionIntroversion: json["extraversion>introversion"],
        sensingIntuition: json["sensing>intuition"],
        thinkingFeeling: json["thinking>feeling"],
        judgingPerceiving: json["judging>perceiving"],
    );

    Map<String, dynamic> toJson() => {
        "extraversion>introversion": extraversionIntroversion,
        "sensing>intuition": sensingIntuition,
        "thinking>feeling": thinkingFeeling,
        "judging>perceiving": judgingPerceiving,
    };
}
