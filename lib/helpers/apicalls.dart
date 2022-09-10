import 'package:dio/dio.dart';
import 'package:frontend/constants/server.constants.dart';

Future<dynamic> postCall(
    {required String postUrlpath, required Map<String, String> body}) async {
  Dio dio = Dio();
  Response res = await dio.post(baseurl + postUrlpath, data: body);
  if (res.statusCode == 200) {
    return res.data;
  } else {
    return {};
  }
}
