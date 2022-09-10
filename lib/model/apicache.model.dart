import 'package:hive/hive.dart';

class ApiCache {
  ApiCache({required this.url, required this.postData});
  @HiveField(0)
  String url;
  Map<String, dynamic> postData;

  Map<String, dynamic> tojson(ApiCache cache) {
    return {"url": cache.url, "postdata": cache.postData};
  }

  ApiCache fromjson(Map<String, dynamic> data) {
    return ApiCache(url: data['url'], postData: data['postdata']);
  }
}
