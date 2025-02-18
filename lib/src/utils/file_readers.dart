import 'dart:convert';
import 'package:contacts/src/utils/contact.dart';
import 'package:flutter/services.dart';

Future<dynamic> readJson(String path) async {
  final String response = await rootBundle.loadString(path);
  final data = json.decode(response);
  return data;
}

List<Contact> parseData(data) {
  List<Contact> list = [];
  for (int i = 0; i < data.length; i++) {
    List sections_ = data[i]["sections"];
    List<ContactSection> sections = [];
    for (var section in sections_) {
      sections
          .add(ContactSection(title: section["title"], data: section["data"]));
    }
    list.add(Contact(
      name: data[i]["name"],
      profileURL: data[i]["profileURL"],
      sections: sections,
    ));
  }
  return list;
}
