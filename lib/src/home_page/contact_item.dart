import 'package:contacts/src/home_page/contact_details_view.dart';
import 'package:contacts/src/utils/contact.dart';
import 'package:flutter/material.dart';
import 'package:contacts/src/components/avatar.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.item,
  });

  final Contact item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(item.name),
        leading: Avatar(
          dpURL: item.profileURL == "" ? item.name : item.profileURL,
          minRadius: 20,
          maxRadius: 20,
          fontSize: 17,
        ),
        onTap: () {
          // Navigate to the details page. If the user leaves and returns to
          // the app after it has been killed while running in the
          // background, the navigation stack is restored.
          Navigator.pushNamed(
            context,
            ContactDetailsView.routeName,
            arguments: item,
          );
        });
  }
}
