import 'package:dio/dio.dart';
import 'package:frontend/constants/server.constants.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';

Future<dynamic> postCall(
    {required String postUrlpath, required Map<String, dynamic> body}) async {
  Dio dio = Dio();
  String token = await getKey(key: "token");
  Response res = await dio.post(baseurl + postUrlpath,
      data: body, options: Options(headers: {"token": token}));
  if (res.statusCode == 200) {
    log(res.data, Sevearity.low);
    return res.data;
  } else {
    return {};
  }
}
