import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sms_advanced/sms_advanced.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "emergency ambulance",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text('Signup'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                child: Text("login"))
          ],
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "signup",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ));
                  },
                  child: Text("signup"))
            ],
          ),
        ),
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  },
                  child: Text("LogIn"))
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SosScreen(),
                    ),
                  );
                },
                child: Text("SOS")),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlertScreen(),
                    ),
                  );
                },
                child: Text("alert"))
          ],
        ),
      ),
    );
  }
}

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("map"),
          ],
        ),
      ),
    );
  }
}

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  List<Contact> contacts = [];
  List<Contact> favoriteContacts = [];

  @override
  void initState() {
    super.initState();
    requestPermissionAndFetchContacts();
  }

  Future<void> requestPermissionAndFetchContacts() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      if (await Permission.contacts.request().isGranted) {
        fetchContacts();
      } else {
        print("Permission denied");
      }
    } else if (status.isGranted) {
      fetchContacts();
    }
  }

  Future<void> fetchContacts() async {
    Iterable<Contact> fetchedContacts = await ContactsService.getContacts();
    setState(() {
      contacts = fetchedContacts.toList();
    });
  }

  void toggleFavorite(Contact contact) {
    setState(() {
      if (favoriteContacts.contains(contact)) {
        favoriteContacts.remove(contact);
      } else {
        favoriteContacts.add(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Access Demo"),
      ),
      body: contacts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                bool isFavorite = favoriteContacts.contains(contact);
                return ListTile(
                  title: Text(contact.displayName ?? 'No Name'),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : null,
                    ),
                    onPressed: () => toggleFavorite(contact),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FavoriteContactsScreen(favoriteContacts: favoriteContacts),
            ),
          );
        },
      ),
    );
  }
}

class FavoriteContactsScreen extends StatefulWidget {
  final List<Contact> favoriteContacts;

  FavoriteContactsScreen({required this.favoriteContacts});

  @override
  _FavoriteContactsScreenState createState() => _FavoriteContactsScreenState();
}

class _FavoriteContactsScreenState extends State<FavoriteContactsScreen> {
  static const double shakeThresholdGravity = 2.7;
  static const int shakeSlopTimeMs = 500;
  int lastShakeTimestamp = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      double gX = event.x / 9.81;
      double gY = event.y / 9.81;
      double gZ = event.z / 9.81;

      double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

      if (gForce > shakeThresholdGravity) {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (lastShakeTimestamp + shakeSlopTimeMs > now) {
          return;
        }

        lastShakeTimestamp = now;
        onShake();
      }
    });
  }

  void onShake() {
    sendSMS();
  }

  void sendSMS() async {
    String message = "Hello from your favorite contact app!";
    List<String> recipients = widget.favoriteContacts
        .where((contact) => contact.phones!.isNotEmpty)
        .map((contact) => contact.phones!.first.value!)
        .toList();

    if (recipients.isNotEmpty) {
      try {
        SmsSender sender = SmsSender();
        for (String recipient in recipients) {
          SmsMessage sms = SmsMessage(recipient, message);
          sender.sendSms(sms);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("SMS sent successfully"),
            duration: Duration(seconds: 1),
          ),
        );
      } catch (error) {
        print("Error sending SMS: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to send message."),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Contacts"),
      ),
      body: widget.favoriteContacts.isEmpty
          ? Center(child: Text("No favorite contacts selected."))
          : ListView.builder(
              itemCount: widget.favoriteContacts.length,
              itemBuilder: (context, index) {
                Contact contact = widget.favoriteContacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? 'No Name'),
                );
              },
            ),
    );
  }
}
