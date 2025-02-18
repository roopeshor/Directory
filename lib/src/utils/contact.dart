class Contact {
  Contact({
    required this.name,
    required this.profileURL,
    required this.sections,
  });

  final String name;
  final String profileURL;
  final List<ContactSection> sections;
}

class ContactSection {
  final List<Map> data;
  final String title;
  late List<ContactField> fields;

  ContactSection({required this.title, required this.data}) {}
}

class ContactField {
  ContactField({
    required this.value,
    required this.type,
  });
  final String value, type;
}
