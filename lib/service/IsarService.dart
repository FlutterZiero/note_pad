import 'package:isar/isar.dart';
import 'package:note_pad/model/note_model.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  //* constructor
  IsarService() {
    db = openDB();
  }

  //* add note
  Future<void> addNote(NoteModel note) async {
    final isar = await db;

    await isar.writeTxnSync(() async {
      await isar.collection<NoteModel>().putSync(note);
    });
  }

  //* return ==> instance of Isar
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [NoteModelSchema],
        directory: dir.path,
      );
    } else {
      return await Future.value(Isar.getInstance());
    }
  }
}
