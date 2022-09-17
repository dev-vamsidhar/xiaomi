import 'package:dio/dio.dart';
import 'package:frontend/constants/server.constants.dart';
import 'package:frontend/helpers/connectivity.helper.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:frontend/model/apicache.model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> postCall(
    {required String postUrlpath,
    required Map<String, dynamic> body,
    bool cachecall = false,
    String cachekey = ""}) async {
  print("ok");
  try {
    ConnectivityController controller = ConnectivityController();
    bool hasconnection = await controller.checkdataconnection();
    if (hasconnection) {
      Dio dio = Dio();
      String token = await getKey(key: "token");
      Response res = await dio.post(baseurl + postUrlpath,
          data: body, options: Options(headers: {"token": token}));
      if (cachecall) {
        await deletekey(key: cachekey, boxname: "cache");
      }
      if (res.statusCode == 200) {
        log(res.data, Sevearity.low);
        return res.data;
      } else {
        return {};
      }
    } else if (!cachecall) {
      ApiCache apicallcache = ApiCache(url: postUrlpath, postData: body);
      var uuid = const Uuid();
      String randomid = uuid.v4();
      await setKey(
          key: randomid,
          value: apicallcache.tojson(apicallcache),
          boxname: "cache");
    }
  } catch (e) {
    toast("Something went wrong fromour side . Try again later.");
  }
}

Future getcallscache() async {
  try {
    Box box = await Hive.openBox("cache");
    Iterable<dynamic> keys = box.keys;

    for (var element in keys) {
      var data = box.get(element);
      Map<String, dynamic> body = {};
      data['postdata'].forEach((key, value) {
        body[key.toString()] = value;
      });
      await postCall(
          postUrlpath: data['url'],
          body: body,
          cachecall: true,
          cachekey: element);
    }
  } catch (e) {
    toast("Something went wrong from our side.Try again later.");
  }
}
