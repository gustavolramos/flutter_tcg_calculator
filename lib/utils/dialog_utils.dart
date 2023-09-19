import 'package:flutter/material.dart';

class DialogUtils {

  static Future<void> showEditDialog(BuildContext context, Function(String) onEdit) async {
    String newName = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Deck Name'),
          content: TextField(
            onChanged: (value) => newName = value,
            decoration: const InputDecoration(labelText: 'New Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                onEdit(newName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDeleteDialog(BuildContext context, Function() onDelete) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Deck'),
          content: const Text('Are you sure you want to delete this deck?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                onDelete(); 
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}