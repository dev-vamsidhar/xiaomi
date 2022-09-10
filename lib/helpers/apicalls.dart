import 'package:dio/dio.dart';

Future postCall(
    {required String postUrl, required Map<String, String> body}) async {
  Dio dio = Dio();
  Response res = await dio.post(postUrl, data: body);
  if (res.statusCode == 200) {
    return res.data;
  } else {
    return "Something went wrong";
  }
}
