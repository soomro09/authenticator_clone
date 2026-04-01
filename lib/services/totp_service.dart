import 'package:otp/otp.dart';

class TotpService {
  static const int driftOffset = -2000;

  /// Generates the 6-digit code based on the secret key and current time
  static String generateCode(String secret) {
    try {
      final String cleanSecret = secret.trim().toUpperCase().replaceAll(' ', '');
      if (cleanSecret.isEmpty) return "EMPTY";

      final int correctedTime = DateTime.now().millisecondsSinceEpoch + driftOffset;

      return OTP.generateTOTPCodeString(
        cleanSecret,
        correctedTime,
        interval: 30,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      );
    } catch (e) {
      return "INVALID";
    }
  }

  /// Calculates the progress bar value (1.0 to 0.0)
  static double getProgress() {
    final int correctedTime = DateTime.now().millisecondsSinceEpoch + driftOffset;
    int seconds = (correctedTime ~/ 1000) % 30;
    return 1 - (seconds / 30);
  }
}