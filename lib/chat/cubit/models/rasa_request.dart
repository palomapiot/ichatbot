class RasaRequest {
  RasaRequest(this.sender, this.message);

  final String sender, message;

  Map<String, dynamic> toJson() =>
      <String, String>{'sender': sender, 'message': message};
}
