import 'package:client/pages/log_in.dart';
import 'package:client/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Getting Started...",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Image.network(
              'https://cdn3d.iconscout.com/3d/free/thumb/free-ambulance-8802945-7192171.png',
              width: 300,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 90),
                child: Text(
                  "SignUp",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90),
                  child: Text(
                    "LogIn",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
