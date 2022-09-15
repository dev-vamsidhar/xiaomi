import 'package:hive/hive.dart';

Future<bool> setKey(
    {required String key, required var value, String boxname = "temp"}) async {
  Box box = await Hive.openBox(boxname);
  await box.put(key, value);
  return true;
}

Future<dynamic> getKey({required String key, String boxname = "temp"}) async {
  Box box = await Hive.openBox(boxname);
  var value = await box.get(key);
  if (value == null) {
    return "";
  }
  return value;
}

Future<bool> haskey({required String key, String boxname = "temp"}) async {
  Box box = await Hive.openBox(boxname);
  return box.containsKey(key);
}

Future<bool> deletekey({required String key, String boxname = "temp"}) async {
  Box box = await Hive.openBox(boxname);
  await box.delete(key);
  return true;
}

Future cleardb({String boxname = "temp"}) async {
  Box box = await Hive.openBox(boxname);
  box.clear();
}
