class ComboData {
  double aA = 0.0;
  double gG = 0.0;
  double mM = 0.0;
  double xX = 0.0;
  double yY = 0.0;
  double zZ = 0.0;

  ComboData(bArr) {
    aA = (((bArr[4] & 255)) * 256) + ((bArr[5] & 255)).toDouble();
    gG = (((bArr[0] & 255)) * 256) + ((bArr[1] & 255)).toDouble();
    mM = (((bArr[2] & 255)) * 256) + ((bArr[3] & 255)).toDouble();
    xX = (((((bArr[6] & 255)) * 256) + ((bArr[7] & 255)) - 32768) / 16384)
        .toDouble();
    yY = (((((bArr[8] & 255)) * 256) + ((bArr[9] & 255)) - 32768) / 16384)
        .toDouble();
    zZ = (((((bArr[10] & 255)) * 256) + ((bArr[11] & 255)) - 32768) / 16384)
        .toDouble();
  }
}
