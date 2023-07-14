import 'package:flutter/material.dart';
import 'package:note_app/provider/note_provider.dart';
import 'package:note_app/screens/widgets/model_sheet.dart';
import 'package:note_app/screens/widgets/note_card.dart';
import 'package:provider/provider.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPersistentFrameCallback((_) {
    //   //-start fetch notes when app loads
    //   Provider.of<NoteProvider>(context, listen: false).startFetchNotes();
    // });
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        Provider.of<NoteProvider>(context, listen: false).startFetchNotes();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Note',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Consumer<NoteProvider>(
          builder: (context, value, child) {
            return value.notes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Notes",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 182, 182, 182))),
                        SizedBox(height: 5),
                        Text("Tap Add button to add notes",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 182, 182, 182))),
                      ],
                    ),
                  )
                : value.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : value.notes.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("No Notes",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(
                                            255, 182, 182, 182))),
                                SizedBox(height: 5),
                                Text("Tap Add button to add notes",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(
                                            255, 182, 182, 182))),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return NoteCard(model: value.notes[index]);
                            },
                            itemCount: value.notes.length);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: ModelSheetWidget(
                  isUpdating: false,
                ),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.note_add,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
