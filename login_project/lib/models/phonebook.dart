class Phonebook {
  late final int id;
  late final String names;
  late final String telNo;

  Phonebook({required this.id, required this.names, required this.telNo});

  Phonebook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    names = json['names'];
    telNo = json['telNo'];
  }
}
