import 'package:client/pages/clist.dart';
import 'package:flutter/material.dart';

class AlertFav extends StatefulWidget{
  const AlertFav ({super.key});
  
  @override
  State<AlertFav> createState() => _AlertFavState();
}
class _AlertFavState extends State<AlertFav>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:const Text('Favourite'),
      backgroundColor: Colors.red,)
      ,
      body: Stack(
        children: [
          // Your body content here,
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}