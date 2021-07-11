// To parse this JSON data, do
//
//     final wikipedia = wikipediaFromJson(jsonString);

import 'dart:convert';

Wikipedia wikipediaFromJson(String str) => Wikipedia.fromJson(json.decode(str));

String wikipediaToJson(Wikipedia data) => json.encode(data.toJson());

class Wikipedia {
  Wikipedia({
    required this.data,
  });

  final List<Datum> data;

  factory Wikipedia.fromJson(Map<String, dynamic> json) => Wikipedia(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.pageId,
    required this.desc,
  });

  final String title;
  final int pageId;
  final String desc;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        pageId: json["pageId"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "pageId": pageId,
        "desc": desc == "" ? "" : desc,
      };
}

// To parse this JSON data, do
//
//     final wikipediaPage = wikipediaPageFromJson(jsonString);

WikipediaPage wikipediaPageFromJson(String str) =>
    WikipediaPage.fromJson(json.decode(str));

String wikipediaPageToJson(WikipediaPage data) => json.encode(data.toJson());

class WikipediaPage {
  WikipediaPage({
    required this.data,
  });

  final Data data;

  factory WikipediaPage.fromJson(Map<String, dynamic> json) => WikipediaPage(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.title,
    required this.summary,
    required this.thumbnail,
    required this.lang,
    required this.description,
    required this.intro,
  });

  final String title;
  final String summary;
  final String thumbnail;
  final String lang;
  final String description;
  final String intro;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        summary: json["summary"],
        thumbnail: json["thumbnail"],
        lang: json["lang"],
        description: json["description"],
        intro: json["intro"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "summary": summary,
        "thumbnail": thumbnail,
        "lang": lang,
        "description": description,
        "intro": intro,
      };
}
