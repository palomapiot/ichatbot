import 'package:ichatbot/chat/cubit/models/button.dart';

class RasaResponseList {
  RasaResponseList(this.responses);

  factory RasaResponseList.fromJson(List<dynamic> parsedJson) {
    final messages = parsedJson
        .map((dynamic i) => RasaResponse.fromJson(i as Map<String, dynamic>))
        .toList();

    return RasaResponseList(messages);
  }

  final List<RasaResponse> responses;
}

class RasaResponse {
  RasaResponse(this.text, this.buttons);

  RasaResponse.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String,
        buttons = json['buttons'] != null ? ButtonList.fromJson(json['buttons']) : ButtonList([]);

  final String text;
  final ButtonList buttons;
}
