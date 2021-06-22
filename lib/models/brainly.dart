// To parse this JSON data, do
//
//     final brainly = brainlyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Brainly brainlyFromJson(String str) => Brainly.fromJson(json.decode(str));

String brainlyToJson(Brainly data) => json.encode(data.toJson());

class Brainly {
  Brainly({
    required this.length,
    required this.data,
  });

  int length;
  List<Datum> data;

  factory Brainly.fromJson(Map<String, dynamic> json) => Brainly(
        length: json["length"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.pertanyaan,
    required this.jawaban,
    required this.questionMedia,
  });

  String pertanyaan;
  List<Jawaban> jawaban;
  List<dynamic> questionMedia;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pertanyaan: json["pertanyaan"],
        jawaban:
            List<Jawaban>.from(json["jawaban"].map((x) => Jawaban.fromJson(x))),
        questionMedia: List<dynamic>.from(json["questionMedia"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "pertanyaan": pertanyaan,
        "jawaban": List<dynamic>.from(jawaban.map((x) => x.toJson())),
        "questionMedia": List<dynamic>.from(questionMedia.map((x) => x)),
      };
}

class Jawaban {
  Jawaban({
    required this.text,
    required this.media,
  });

  String text;
  List<dynamic> media;

  factory Jawaban.fromJson(Map<String, dynamic> json) => Jawaban(
        text: json["text"],
        media: List<dynamic>.from(json["media"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "media": List<dynamic>.from(media.map((x) => x)),
      };
}
