import 'dart:convert';

import 'package:dio/dio.dart';

class HttpUtil {
  ///分页默认起始页
  static final int startIndex = 0;

  ///分页默认每一页数量
  static final int pageSize = 10;

  ///请求成功
  static final int successCode = 0;

  static request(
      String url,
      Map<String, Object> parameters,
      successBlock(int code, String msg, dynamic data),
      errorBlock(error)) async {
    try {
      Response response;
      Dio dio = Dio();

      response = await dio.post(url, data: parameters);

      Map map = json.decode(response.toString());

      int code = map["code"];
      String msg = map["msg"];
      dynamic data = map["data"];
      print("请求地址：" + url);
      print("请求参数：" + parameters.toString());
      print("返回数据：" + data.toString());
      successBlock(code, msg, data);
    } on DioError catch (error) {
      print("请求地址：" + url);
      print("请求参数：" + parameters.toString());
      print("请求报错：" + error.toString());
    }
  }
}
