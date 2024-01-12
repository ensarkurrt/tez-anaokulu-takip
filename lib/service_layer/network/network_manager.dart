/* import 'package:chucker_flutter/chucker_flutter.dart'; */
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';

/* import 'package:pretty_dio_logger/pretty_dio_logger.dart'; */

import '../../tools/constants/application_constants.dart';
import '../models/response.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    if (_instance != null) return _instance!;
    _instance = NetworkManager._init();
    return _instance!;
  }

  Dio? _dio;
  final Options _options = Options(validateStatus: (status) {
    if (status != null && status < 500) return true;
    return false;
  });
  NetworkManager._init() {
    ApplicationConstants.instance;

    _dio = Dio(getBaseOptions());

    /* Interceptors will be add on only debug mode */
    if ((kDebugMode /*  || TestDeviceService.instance.isTestDevice */) && _dio != null) {
      Logger.instance.log("NETWORK MANAGER :: Interceptors add on only debug mode");
      /* _dio!.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90)); */
      _dio!.interceptors.add(ChuckerDioInterceptor());
    }
  }

  Future<NetworkResponse<T>> get<T>(
    String path, {
    T Function(dynamic json)? fromJsonT,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _dio!.options = getBaseOptions();
    Response response = await _dio!.get(path, queryParameters: queryParameters, options: _copyWithOptions(options), cancelToken: cancelToken);
    return NetworkResponse<T>.fromJson(response.data, fromJsonT);
  }

  Future<NetworkResponse<T>> post<T>(
    String path, {
    T Function(dynamic json)? fromJsonT,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _dio!.options = getBaseOptions();
    Response response = await _dio!.post(path, data: data, options: _copyWithOptions(options), cancelToken: cancelToken);
    return NetworkResponse<T>.fromJson(response.data, fromJsonT);
  }

  Future<NetworkResponse<T>> put<T>(
    String path, {
    T Function(dynamic json)? fromJsonT,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _dio!.options = getBaseOptions();
    Response response = await _dio!.put(path, data: data, options: _copyWithOptions(options), cancelToken: cancelToken);
    return NetworkResponse<T>.fromJson(response.data, fromJsonT);
  }

  Future<NetworkResponse<T>> delete<T>(
    String path, {
    T Function(dynamic json)? fromJsonT,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _dio!.options = getBaseOptions();
    Response response = await _dio!.delete(path, data: data, options: _copyWithOptions(options), cancelToken: cancelToken);
    return NetworkResponse<T>.fromJson(response.data, fromJsonT);
  }

  Options _copyWithOptions(Options? options) {
    if (options == null) {
      options = _options;
    } else {
      options = _options.copyWith(
        method: options.method,
        sendTimeout: options.sendTimeout,
        receiveTimeout: options.receiveTimeout,
        extra: options.extra,
        headers: options.headers,
        responseType: options.responseType,
        contentType: options.contentType,
        /* validateStatus: options.validateStatus, */
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
        requestEncoder: options.requestEncoder,
        responseDecoder: options.responseDecoder,
        listFormat: options.listFormat,
      );
    }

    return options;
  }

  BaseOptions getBaseOptions({String? baseUrl}) {
    /* Map<String, dynamic> header = DeviceInfoService.instance.toJson(); */

    return BaseOptions(baseUrl: ApplicationConstants.instance.s3BucketUrl /* , contentType: 'application/json' */);
  }
}
