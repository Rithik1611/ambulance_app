import 'package:flutter/material.dart';

class Contacts {
  String name;
  String contact;
  Contacts({required this.name, required this.contact});
}

List<Contacts> contacts = [
  Contacts(name: 'Alice Johnson', contact: '123-456-7890'),
  Contacts(name: 'Bob Smith', contact: '987-654-3210'),
  Contacts(name: 'Charlie Brown', contact: '555-666-7777'),
  Contacts(name: 'Diana Prince', contact: '111-222-3333'),
  Contacts(name: 'Eve Adams', contact: '444-555-6666'),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contacts> favoriteContacts = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Favorite Contacts'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: favoriteContacts.isEmpty
              ? const Text(
                  'No Favorites Contact added...',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              : ListView.builder(
                  itemCount: favoriteContacts.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final selectedContact = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactsListScreen()),
            );
            if (selectedContact != null &&
                !favoriteContacts.contains(selectedContact)) {
              setState(() {
                favoriteContacts.add(selectedContact);
              });
            }
          },
          child: const Icon(Icons.contacts),
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: Text(
          favoriteContacts[index].name[0],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      trailing: const Icon(Icons.star),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(favoriteContacts[index].name),
          Text(favoriteContacts[index].contact),
        ],
      ),
    );
  }
}

class ContactsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('All Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: Text(
              contacts[index].name[0],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          trailing: const Icon(Icons.star_border),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contacts[index].name),
              Text(contacts[index].contact),
            ],
          ),
          onTap: () {
            Navigator.pop(context, contacts[index]);
          },
        ),
      ),
    );
  }
}
