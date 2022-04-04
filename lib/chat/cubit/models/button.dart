class ButtonList {
  ButtonList(this.buttons);

  factory ButtonList.fromJson(List<dynamic> parsedJson) {
    final messages = parsedJson
        .map((dynamic i) => Button.fromJson(i as Map<String, dynamic>))
        .toList();

    return ButtonList(messages);
  }

  final List<Button> buttons;
}

class Button {
  Button({required this.title, required this.payload});

  Button.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        payload = json['payload'] as String;

  String title;
  String payload;
}
