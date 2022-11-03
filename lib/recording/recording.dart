import 'session.dart';

class Recording {
  late double aA;
  List<Session> sessions = [];

  Recording decode(List<int> bArr) {
    Recording recording = Recording();
    int i = -1;
    for (int i2 = 0; i2 <= bArr.length; i2++) {
      if (i2 == bArr.length ||
          (bArr[i2]).toInt() == 252 ||
          (bArr[i2]).toInt() == 253) {
        if (i != -1) {
          if (i2 - i > 8) {
            Session? decode = Session().decode(bArr.getRange(i, i2).toList());
            if (decode != null) recording.sessions.add(decode);
          }
        }
        i = i2;
      }
    }
    return recording;
  }
}
