import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/provider/note_provider.dart';
import 'package:note_app/screens/widgets/model_sheet.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.model,
  });

  final NoteModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Color.fromARGB(255, 222, 222, 222))
          ]),
      child: ListTile(
        title: Text(model.title),
        subtitle: Text(model.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Provider.of<NoteProvider>(context, listen: false)
                      .setController(model.title, model.description);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: ModelSheetWidget(
                        isUpdating: true,
                        id: model.id,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit, size: 20)),
            IconButton(
                onPressed: () {
                  Provider.of<NoteProvider>(context, listen: false)
                      .startDeleteNote(context, model.id!);
                },
                icon: const Icon(Icons.delete, size: 20)),
          ],
        ),
      ),
    );
  }
}
