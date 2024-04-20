// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:geolocator/geolocator.dart';

import '../wigets/note.dart';
import 'initial_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.title, this.userNickname = 'користувач'})
      : super(key: key);

  final String title;
  final String userNickname;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Note> _notes = [];

  void _addNote(Position position) {
    setState(() {
      _notes.add(Note(
        position: position,
        note:
            'Примітка:\nПлоща ділянки:\nКут нахилу ділянки:\nРівень на рівнем моря:\nРівень ґрунтових вод:',
      ));
    });
  }

  void _editNote(int index, String newNote) {
    setState(() {
      _notes[index].note = newNote;
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    _addNote(position);
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title),
            const SizedBox(width: 8),
            const Icon(Icons.public), // Earth icon
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${widget.userNickname}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate), // Add calculator icon
              title: const Text('Calculator'),
              onTap: () {
                _launchURL(
                  context,
                  'https://geographiclib.sourceforge.io/cgi-bin/GeodSolve',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on), // Geolocation icon
              title: const Text('Google Maps'),
              onTap: () {
                _launchURL(
                  context,
                  'https://www.google.com/maps',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.build), // Wrench icon
              title: const Text('EOS'),
              onTap: () {
                _launchURL(
                  context,
                  'https://auth.eos.com/#!/sign-in?return_url=https:%2F%2Fapi-connect.eos.com%2Fuser-dashboard%2Fstatistics',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on), // Wrench icon
              title: const Text('Land viewer'),
              onTap: () {
                _launchURL(
                  context,
                  'https://eos.com/landviewer/',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on), // Wrench icon
              title: const Text('GGOS'),
              onTap: () {
                _launchURL(
                  context,
                  'https://ggos.org/',
                );
              },
            ),
            ListTile(
              title: const Text(
                'Exit',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              tileColor: Colors.blue,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _notes.isNotEmpty
          ? ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  note: _notes[index],
                  onDelete: () => _deleteNote(index),
                  onEdit: (newNote) => _editNote(index, newNote),
                );
              },
            )
          : const Center(
              child: Text('No Notes'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _launchURL(
  BuildContext context,
  String url,
) async {
  try {
    await launch(
      url,
      customTabsOption: const CustomTabsOption(
        //toolbarColor: headerColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
      ),
      safariVCOption: const SafariViewControllerOption(
        // preferredBarTintColor: headerColor,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
