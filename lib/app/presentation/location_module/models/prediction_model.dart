class PredictionModel {
  PredictionModel({
    this.description,
    this.id,
    this.distanceMeters,
    this.placeId,
    this.reference,
    this.place,
    this.text,
    this.structuredFormat,
    this.types,
  });

  PredictionModel.fromJson(Map<String, dynamic> json) {
    description = json['placePrediction']['text']['text'] as String?;
    id = json['placePrediction']['placeId'] as String?;
    placeId = json['placePrediction']['placeId'] as String?;
    place = json['placePrediction']['place'] as String?;
    reference = json['placePrediction']['text']['text'] as String?;
    types = json['placePrediction']['types'] == null
        ? []
        : List<dynamic>.from(json['placePrediction']['types'] as List<dynamic>);
    text = json['placePrediction']['text'] != null
        ? TextModel.fromJson(
            json['placePrediction']['text'] as Map<String, dynamic>,
          )
        : null;
    structuredFormat = json['placePrediction']['structuredFormat'] != null
        ? StructuredFormat.fromJson(
            json['placePrediction']['structuredFormat'] as Map<String, dynamic>,
          )
        : null;
  }
  String? description;
  String? id;
  int? distanceMeters;
  String? placeId;
  String? reference;
  String? place;
  TextModel? text;
  StructuredFormat? structuredFormat;
  List<dynamic>? types;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['placePrediction'] = {
      'text': text?.toJson(),
      'placeId': placeId,
      'place': place,
      'types': types,
      'structuredFormat': structuredFormat?.toJson(),
    };
    return data;
  }
}

class TextModel {
  TextModel({this.text, this.matches});

  TextModel.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
    if (json['matches'] != null) {
      matches = <Match>[];
      json['matches'].forEach((v) {
        matches!.add(Match.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? text;
  List<Match>? matches;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Match {
  Match({this.endOffset});

  Match.fromJson(Map<String, dynamic> json) {
    endOffset = json['endOffset'] as int?;
  }
  int? endOffset;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['endOffset'] = endOffset;
    return data;
  }
}

class StructuredFormat {
  StructuredFormat({this.mainText, this.secondaryText});

  StructuredFormat.fromJson(Map<String, dynamic> json) {
    mainText = json['mainText'] != null
        ? MainText.fromJson(json['mainText'] as Map<String, dynamic>)
        : null;
    secondaryText = json['secondaryText'] != null
        ? SecondaryText.fromJson(json['secondaryText'] as Map<String, dynamic>)
        : null;
  }
  MainText? mainText;
  SecondaryText? secondaryText;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (mainText != null) {
      data['mainText'] = mainText!.toJson();
    }
    if (secondaryText != null) {
      data['secondaryText'] = secondaryText!.toJson();
    }
    return data;
  }
}

class MainText {
  MainText({this.text, this.matches});

  MainText.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
    if (json['matches'] != null) {
      matches = <Match>[];
      json['matches'].forEach((v) {
        matches!.add(Match.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? text;
  List<Match>? matches;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondaryText {
  SecondaryText({this.text});

  SecondaryText.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  String? text;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
