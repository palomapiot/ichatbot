class RasaResponseList {
  RasaResponseList(this.responses);

  factory RasaResponseList.fromJson(List<dynamic> parsedJson) {
    final photos = parsedJson
        .map((dynamic i) => RasaResponse.fromJson(i as Map<String, dynamic>))
        .toList();

    return RasaResponseList(photos);
  }

  final List<RasaResponse> responses;
}

class RasaResponse {
  RasaResponse(this.text);

  RasaResponse.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String;

  final String text;
}
