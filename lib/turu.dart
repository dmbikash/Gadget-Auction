/*

/// Flutter code sample for showModalBottomSheet

// This example demonstrates how to use `showModalBottomSheet` to display a
// bottom sheet that obscures the content behind it when a user taps a button.
// It also demonstrates how to close the bottom sheet using the [Navigator]
// when a user taps on a button inside the bottom sheet.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('Add New Product'),
                ),
                body: Card(
                  child: Container(
    color: Colors.white,
    height: 250,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    Text(
    "Pic Image From",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    ),
    SizedBox(
    height: 10,
    ),
    ElevatedButton.icon(
    onPressed: () {
    pickImage(ImageSource.camera);
    },
    icon: Icon(Icons.camera),
    label: Text("Camera"),
    ),
    ElevatedButton.icon(
    onPressed: () {
    pickImage(ImageSource.gallery);
    },
    icon: Icon(Icons.image),
    label: Text("Gallery"),
    ),
    SizedBox(
    height: 10,
    ),
    ElevatedButton.icon(
    onPressed: () {
    Get.back();
    },
    icon: Icon(Icons.close),
    label: Text("Cancel"),
    ),
    ],
    ),
    ),
    ),
    ),
    ),
    );
    }

    ),
              );
            },
          );
        },
      ),
    );
  }
 }
 */

