import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:third_map_plugin/third_map_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('third_map_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {

  });
}
