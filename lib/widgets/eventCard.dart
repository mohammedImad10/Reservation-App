import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
                                  child: ListTile(
                                    title: Text("EVENT"),
                                    trailing:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("images/flutter-react.jpg"),
                                    ),
                                    
                                  ),
                                )
    );
  }
}