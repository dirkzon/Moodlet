import 'entry.dart';

class Session {
  late DateTime date;
  bool valid = false;
  List<Entry> entries = [];

  Session? decode(List<int> bArr) {
    if (bArr.length < 8) {
      return null;
    }
    Session session = Session();
    if ((bArr[0] & 255) == 252) {
      valid = true;
    }

    for (int i = 8; i <= bArr.length - 4; i += 4) {
      var mm = (bArr[i + 1] & 255);
      if (mm < 100) {
        valid = false;
      }
      Entry((bArr[i] & 255), mm, (bArr[i + 2] & 255), (bArr[i + 3] & 255));
    }

    int epoch = (((((bArr[5] & 255) << 0x10) |
                    ((bArr[6] & 255) << 8) |
                    (bArr[7] & 255)) *
                60) +
            (((bArr[1] & 255) << 0x18) |
                ((bArr[2] & 255) << 0x10) |
                ((bArr[3] & 255) << 8) |
                (bArr[4] & 255))) *
        1000;
    date = DateTime.fromMicrosecondsSinceEpoch(epoch * 1000);
    return session;
  }
}
