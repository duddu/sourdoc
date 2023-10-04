import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/methods/persist_initial_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('getInitialOrDefaultValue', () {
    setUpAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('plugins.flutter.io/shared_preferences'),
              (methodCall) async {
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{'flutter.test1_key': 'test1_value'};
        }
        return null;
      });
    });

    test('should retrieve a value from store for an existing key', () async {
      expect(await getInitialOrDefaultValue('test1_key', 'default_value'),
          'test1_value');
    });

    test('should retrieve default value if key not present in store', () async {
      expect(await getInitialOrDefaultValue('test2_key', 'default_value'),
          'default_value');
    });
  });
}
