import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Note {
  final Position position;
  String note;

  Note({
    required this.position,
    required this.note,
  });
}

class NoteTile extends StatefulWidget {
  final Note note;
  final Function() onDelete;
  final Function(String) onEdit;

  const NoteTile({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.note.note;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Координати: ${widget.note.position.latitude}, ${widget.note.position.longitude}',
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  color: Colors.white,
                  onPressed: () {
                    String coordinates =
                        '${widget.note.position.latitude}, ${widget.note.position.longitude}';
                    Clipboard.setData(ClipboardData(text: coordinates));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Coordinates copied'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              child: TextField(
                controller: _controller,
                onChanged: widget.onEdit,
                decoration: const InputDecoration(
                  hintText: 'Enter note',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: null, // Allow unlimited lines
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  color: Colors.white,
                  onPressed: () {
                    String noteContent =
                        'Coordinates: ${widget.note.position.latitude}, ${widget.note.position.longitude}\n${widget.note.note}';
                    Clipboard.setData(ClipboardData(text: noteContent));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Note copied'),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: widget.onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
