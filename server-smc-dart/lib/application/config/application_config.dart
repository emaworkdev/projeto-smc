import 'package:dotenv/dotenv.dart' show load;

class ApplicationConfig {
  Future<void> loadConfigApplication() async {
    await _loadEnv();
  }

  Future<void> _loadEnv() async => load();
}
