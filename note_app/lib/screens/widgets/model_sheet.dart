import 'package:flutter/material.dart';
import 'package:note_app/provider/note_provider.dart';
import 'package:provider/provider.dart';

class ModelSheetWidget extends StatelessWidget {
  const ModelSheetWidget({
    super.key,
    this.isUpdating = false,
    this.id,
  });
  final bool isUpdating;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<NoteProvider>(
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Title Here',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontSize: 14)),
                controller: value.title,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Description here',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontSize: 14)),
                controller: value.description,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (isUpdating) {
                      value.startUpdateNote(context, id!);
                    } else {
                      value.startAddNote(context);
                    }
                  },
                  child: Text(isUpdating ? 'Update Note' : 'Save Note'))
            ],
          );
        },
      ),
    );
  }
}
