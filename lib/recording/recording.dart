import 'session.dart';

class Recording {
  double aA = 100;
  List<Session> sessions = [];

  Recording(this.sessions);

  static Recording decode(List<int> bArr) {
    List<Session> sessions = [];
    int i = -1;
    for (int i2 = 0; i2 <= bArr.length; i2++) {
      if (i2 == bArr.length ||
          (bArr[i2]).toInt() == 252 ||
          (bArr[i2]).toInt() == 253) {
        if (i != -1) {
          if (i2 - i > 8) {
            Session? decode = Session.decode(bArr.getRange(i, i2).toList());
            if (decode != null) sessions.add(decode);
          }
        }
        i = i2;
      }
    }
    return Recording(sessions);
  }
}
