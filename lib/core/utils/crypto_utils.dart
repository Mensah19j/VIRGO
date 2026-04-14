import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class CryptoUtils {
  static const Uuid _uuid = Uuid();

  /// Generates a random salt using UUID v4
  static String generateSalt() {
    return _uuid.v4();
  }

  /// Hashes a password with the provided salt using SHA-256
  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verifies a plaintext password against a stored hash and salt
  static bool verifyPassword(String password, String storedHash, String salt) {
    final computedHash = hashPassword(password, salt);
    return computedHash == storedHash;
  }
}
