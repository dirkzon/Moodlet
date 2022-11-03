import 'entry.dart';

class Session {
  late DateTime date;
  late bool valid;
  List<Entry> entries = [];

  Session(this.date, this.valid, this.entries);
}
