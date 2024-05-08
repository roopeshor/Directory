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
    List methods_ = data[i]["contactMethods"];
    List<ContactMethod> methods = [];
    for (var element in methods_) {
      methods.add(ContactMethod(data: element));
    }
    list.add(Contact(
      name: data[i]["name"],
      profileURL: data[i]["profileURL"],
      contactMethods: methods,
    ));
  }
  return list;
}
