import 'package:hive/hive.dart';

Future<bool> setKey({required String key, required var value}) async {
  Box box = await Hive.openBox("temp");
  await box.put(key, value);
  return true;
}

Future<dynamic> getKey({required String key}) async {
  Box box = await Hive.openBox("temp");
  var value = await box.get(key);
  if (value == null) {
    return "";
  }
  return value;
}

Future<bool> haskey({required String key}) async {
  Box box = await Hive.openBox("temp");
  return box.containsKey(key);
}
