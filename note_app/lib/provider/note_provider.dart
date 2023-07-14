import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:note_app/controller/sql_controller.dart';
import 'package:note_app/models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  //--- title controller
  final TextEditingController _title = TextEditingController();
  //get title
  TextEditingController get title => _title;

//--- description controller
  final TextEditingController _description = TextEditingController();
  //get description
  TextEditingController get description => _description;

  //-----loader
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //--------add notes feature------------------------------------
  Future<void> startAddNote(BuildContext context) async {
    try {
      //-set loader
      setLoading = true;
      //-check if the title or descc is empty
      if (_title.text.isEmpty || _description.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Fill all the Fields"), backgroundColor: Colors.red));
      } else {
        await SQLController.createNote(_title.text, _description.text);
        _title.clear();
        _description.clear();

        //----refreshing notes
        await startFetchNotes();
        //--strop the loader
        setLoading = false;
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  //----fetch notes----------------------------------
  Future<void> startFetchNotes() async {
    try {
      //-set loader
      setLoading = true;
      _notes = await SQLController.getNotes();
      Logger().wtf(_notes.length);
      //--strop the loader
      setLoading = false;
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //-----set title and desc
  void setController(String title, String desc) {
    _title.text = title;
    _description.text = desc;
  }

  //------update an exsiting note--------------------------------
  Future<void> startUpdateNote(BuildContext context, int id) async {
    try {
      //-set loader
      setLoading = true;
      //-check if the title or descc is empty
      if (_title.text.isEmpty || _description.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Fill all the Fields"), backgroundColor: Colors.red));
      } else {
        await SQLController.updateNote(id, _title.text, _description.text);
        _title.clear();
        _description.clear();

        //----refreshing notes
        await startFetchNotes();
        //--strop the loader
        setLoading = false;
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //------delete an exsiting note--------------------------------
  Future<void> startDeleteNote(BuildContext context, int id) async {
    try {
      //-set loader
      setLoading = true;

      await SQLController.deleteNote(id);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Deleted the note"), backgroundColor: Colors.green));

      //----refreshing notes
      await startFetchNotes();
      //--strop the loader
      setLoading = false;
    } catch (e) {
      Logger().e(e);
    }
  }
}
