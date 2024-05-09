import 'package:contacts/src/components/avatar.dart';
import 'package:contacts/src/components/icons.dart';
import 'package:contacts/src/utils/contact.dart';
import 'package:flutter/material.dart';
// Import JSON encoder/decoder

/// Displays detailed information about a SampleItem.
class ContactDetailsView extends StatefulWidget {
  const ContactDetailsView({super.key, required this.data});

  static const routeName = '/details';
  final Contact data;

  @override
  State<ContactDetailsView> createState() => _ContactDetailsViewState();
}

class _ContactDetailsViewState extends State<ContactDetailsView> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Avatar(
                dpURL: data.profileURL == "" ? data.name : data.profileURL,
                minRadius: 50,
                maxRadius: 100,
                fontSize: 100,
              ),
              const SizedBox(height: 20),
              headingTextName(context, data.name),
              const SizedBox(height: 20),
              const MainActionButtonRow(),
              const SizedBox(height: 20),
              InfoCard(
                dat: data,
                cardName: "Contact info",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.dat,
    required this.cardName,
  });

  final Contact dat;
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Contact info"),
            const SizedBox(height: 15),
            ListView.builder(
                restorationId: 'contactListView',
                itemCount: dat.contactMethods.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ContactMethod item = dat.contactMethods[index];
                  var type = item.type.split("-");
                  var method = type[0];
                  var category = type[1];
                  return InfoItem(
                    context,
                    () {
                      print(method);
                    },
                    method == "phone"
                        ? Icons.call_outlined
                        : category == "cusat"
                            ? CustomIcons.cusatSimple
                            : Icons.mail_outline,
                    item.value,
                    category,
                    method != "mail"
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(CustomIcons.whatsapp),
                          )
                        : const SizedBox(),
                  );
                })
          ],
        ),
      ),
    );
  }
}

Row InfoItem(
  BuildContext context,
  VoidCallback onTap,
  IconData primaryIcon,
  String detail,
  String hint,
  Widget? secondaryIcon,
) {
  return Row(
    children: [
      Expanded(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    primaryIcon,
                    size: 25,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(width: 8),
                  columnDetail(context, detail, hint),
                ],
              ),
            ),
          ),
        ),
      ),
      secondaryIcon ?? secondaryIcon!
    ],
  );
}

Padding columnDetail(BuildContext context, String detail, String hint) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail,
          softWrap: true,
        ),
        Text(
          hint,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}

Center headingTextName(BuildContext context, String name) {
  return Center(
    child: Text(
      name,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  );
}

class MainActionButtonRow extends StatelessWidget {
  const MainActionButtonRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HintedActionButton(
          icon: Icons.call_outlined,
          hintText: "Call",
        ),
        SizedBox(width: 35),
        HintedActionButton(
          icon: CustomIcons.whatsapp,
          hintText: "WhatsApp",
        )
      ],
    );
  }
}

class HintedActionButton extends StatelessWidget {
  const HintedActionButton({
    super.key,
    required this.icon,
    required this.hintText,
  });

  final IconData icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          child: IconButton(
            onPressed: () => {},
            icon: Icon(
              icon,
              size: 25,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          hintText,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}
