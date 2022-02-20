class RasaResponse {
  RasaResponse(this.text);

  RasaResponse.fromJson(Map<String, String> json) : text = json['text'] ?? '';

  final String text;
}

class RasaResponseList {
  RasaResponseList(this.responses);

  RasaResponseList.fromJson(List<dynamic> json)
      : responses = json as List<RasaResponse>;

  final List<RasaResponse> responses;
}
