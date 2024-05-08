import 'package:contacts/src/home_page/contact_item.dart';
import 'package:contacts/src/utils/contact.dart';
import 'package:contacts/src/utils/file_readers.dart';
import 'package:flutter/material.dart';
import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  static const routeName = '/';
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TextEditingController searchBarController = TextEditingController();
  List<Contact> items = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var data = await readJson("assets/data/data.json");
    setState(() {
      items = parseData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 70),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              'EC1 Directory',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Navigate to the settings page. If the user leaves and returns
                  // to the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    SettingsView.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          children: [
            SearchBar(
              controller: searchBarController,
              constraints:
                  BoxConstraints.tight(const Size(double.infinity, 45)),
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0,
              )),
              onChanged: (_) {
                print(searchBarController.text);
              },
              leading: const Icon(Icons.search),
            ),
            const SizedBox(height: 10),
            ContactList(items: items),
          ],
        ),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
    required this.items,
  });

  final List<Contact> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      child: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'contactListView',
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ContactItem(item: item);
        },
      ),
    );
  }
}
