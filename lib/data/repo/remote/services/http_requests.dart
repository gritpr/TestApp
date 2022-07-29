// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';

import '../../../../__lib.dart';

const timeOutSeconds = 30;
Map<String, String>? header(bool addAuth) {
  final Map<String, String> _header;
  if (addAuth) {
    _header = token != null
        ? {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }
        : {"Content-Type": "application/json"};
  } else {
    _header = {"Content-Type": "application/json"};
  }

  log('HEADER---$_header');

  return _header;
}

get token {
  final t = 
  Get.context!.read(authViewModel).token;
  return t;
}

error401() {
  Get.context!.read(authViewModel).onLogOut();
}

error404() {
  showErrorSnackbar('Something went wrong, contact Admin');
}

Future post({
  required String path,
  required data,
  bool addAuth = true,
  bool check401 = true,
  bool check404 = true,
}) async {
  http.Response? response;
  try {
    final url = Uri.parse(ApiEndPoints.baseUrl + path);
    log('POST---$url');
    log('POST---DATA---$data');

    response = await http.post(
      url,
      body: jsonEncode(data),
      headers: header(addAuth),
    );
    log('Status Code:${response.statusCode}\n Result: ${response.body}');
    if (check401 && response.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (check404 && response.statusCode == 404) {
      error404();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '404';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.body);
  } catch (exception) {
    log('Error: ${exception.runtimeType}');
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = '000';
    data['message'] = exception is TimeoutException
        ? 'Connection Timed Out, Try Again'
        : 'Error Processing response';
    return data;
  }
}

Future get({
  required String path,
  String? id,
  bool addAuth = true,
  bool check401 = true,
}) async {
  http.Response? response;
  try {
    final url =
        Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
    log('GET---$url');

    response = await http.get(
      url,
      headers: header(addAuth),
    );
    log('Status Code:${response.statusCode}\n Result: ${response.body}');
    if (check401 && response.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.body);
  } catch (exception) {
    log('Error: $exception');

    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = '000';
    data['message'] = 'Error Processing response';
    return data;
  }
}

Future getBytes({
  required String path,
  String? id,
  bool addAuth = true,
  bool check401 = true,
}) async {
  http.Response? response;
  try {
    final url =
        Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
    log('GET---$url');

    response = await http.get(
      url,
      headers: header(addAuth),
    );
    log('Status Code:${response.statusCode}\n Result: ${response.body}');

    if (check401 && response.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (check401 && response.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (response.body.isNotEmpty && response.statusCode != 400) {
      return response.body;
    }
    return json.decode(response.body);
  } catch (exception) {
    log('Error: $exception');

    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = '000';
    data['message'] = 'Error Processing response';
    return data;
  }
}

Future put({
  required String path,
  var data,
  bool addAuth = true,
  bool check401 = true,
}) async {
  http.Response? response;
  try {
    final url = Uri.parse(ApiEndPoints.baseUrl + path);
    log('PUT---$url');
    log('PUT---DATA---$data');

    response = await http.put(
      url,
      body: data == null ? null : jsonEncode(data),
      headers: header(addAuth),
    );
    log('Status Code:${response.statusCode}\n Result: ${response.body}');
    if (check401 && response.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.body);
  } catch (exception) {
    log('Error: ${exception.runtimeType}');
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = '000';
    data['message'] = exception is TimeoutException
        ? 'Connection Timed Out, Try Again'
        : 'Error Processing response';
    return data;
  }
}

Future delete({
  required String path,
  String? id,
  bool addAuth = true,
  bool check401 = true,
}) async {
  http.Response? response;
  try {
    final url =
        Uri.parse(ApiEndPoints.baseUrl + path + (id != null ? '/$id' : ''));
    log('DELETE---$url');

    response = await http.delete(
      url,
      headers: header(addAuth),
    );
    log('Status Code:${response.statusCode}\n Result: ${response.body}');
    if (check401 && response.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.body);
  } catch (exception) {
    log('Error: $exception');

    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = '000';
    data['message'] = 'Error Processing response';
    return data;
  }
}

class FileData {
  final io.File ioFile;
  final String ioFileDataPath;
  String? extension;
  String? fileType;

  FileData({
    required this.ioFile,
    required this.ioFileDataPath,
    this.extension = 'png',
    this.fileType = 'image',
  });
}

Future uploadFile({
  String requestType = 'POST',
  required String path,
  required List<FileData> files,
  required Map<String, dynamic> data,
  bool check401 = true,
  bool addAuth = true,
}) async {
  var parsedJson;
  try {
    final url = Uri.parse(ApiEndPoints.baseUrl + path);
    log('UPLOAD---$requestType---$url');

    final request = http.MultipartRequest(
      requestType,
      url,
    );
    if (addAuth) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    request.headers['Content-Type'] = 'multipart/form-data';
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    for (var item in files) {
      log('${item.ioFileDataPath}=====${item.ioFile.path}');
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        '${item.ioFileDataPath}',
        item.ioFile.path,
        contentType: MediaType('${item.fileType}', '${item.extension}'),
      );

      request.files.add(multipartFile);
    }
    log('TOKEN: ${request.headers['Authorization']}');
    log('DATA: ${request.fields}');
    var resp = await request.send();
    String response = await resp.stream.bytesToString();

    log('STATUS CODE: ${resp.statusCode}');
    log('RESPONSE: $response');
    if (check401 && resp.statusCode == 401) {
      error401();
      final Map<String, dynamic> data = <String, dynamic>{};
      data['code'] = '401';
      data['message'] = 'Access Forbidden,Contact Support';
      return data;
    }
    if (response.isEmpty) {
      return <String, String>{};
    }
    if (response.contains('<html>')) {
      var res = <String, String>{};
      res['code'] = '00';
      res['message'] = 'Error Occurred';
      return res;
    }

    parsedJson = await json.decode(response);

    return parsedJson;
  } catch (exception) {
    log('Error: $exception');
    log('RESPONSE: ' + parsedJson);

    var res = <String, String>{};
    res['code'] = '90';
    res['message'] = 'Error Occurred $exception';
    return res;
  }
}
