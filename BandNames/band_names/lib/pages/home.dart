import 'dart:io';
import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 2),
    Band(id: '2', name: 'Kaleo', votes: 4),
    Band(id: '3', name: 'Nirvana', votes: 1),
    Band(id: '4', name: 'Coldplay', votes: 6)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 5,
        onPressed: () => addNewBand(context),
      ),
    );
  }

  ListTile bandTile(Band band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(band.name),
      trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
      onTap: () {
        print(band.name);
      },
    );
  }

  addNewBand(BuildContext context) {
    final textController = new TextEditingController();
    //Android
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () => addBandToList(textController.text, context),
                  child: Text('Add'),
                  elevation: 7,
                  textColor: Colors.blue)
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text('New band name:'),
              content: TextField(controller: textController),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Add'),
                  onPressed: () => addBandToList(textController.text, context),
                  isDefaultAction: true,
                ),
                CupertinoDialogAction(
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                  isDestructiveAction: true,
                ),
              ],
            );
          });
    }
  }

  void addBandToList(String name, BuildContext context) {
    print(name.length);

    if (name.length > 1) {
      this.bands.add(new Band(id: DateTime.now().toString(), name: name));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
