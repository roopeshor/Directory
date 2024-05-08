class Contact {
  Contact({
    required this.name,
    required this.profileURL,
    required this.contactMethods,
  });

  final String name;
  final String profileURL;
  final List<ContactMethod> contactMethods;
}

class ContactMethod {
  ContactMethod({
    required this.data,
  });

  final Map data;
  String get type => data["type"];
  String get value => data["value"];
}
