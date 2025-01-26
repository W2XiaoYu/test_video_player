import 'package:dio/dio.dart';

// 基础响应模型
class BaseModel {
  int code;
  dynamic data;
  String msg;

  BaseModel({required this.code, required this.data, required this.msg});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      code: json['code'] ?? -1,
      data: json['data'],
      msg: json['msg'] ?? '未知错误',
    );
  }

  // 根据响应映射为BaseModel
  static BaseModel fromResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      return BaseModel.fromJson(response.data);
    }
    return BaseModel(code: -1, data: null, msg: '响应数据格式错误');
  }
}

// Dio单例实例
class DioInstance {
  static DioInstance? _instance;
  late Dio _dio;
  final _defaultTimeout = const Duration(seconds: 30);
  bool _inited = false;

  DioInstance._internal();

  static DioInstance get instance {
    return _instance ??= DioInstance._internal();
  }

  // 初始化Dio实例
  void initDio({
    required String baseUrl,
    String method = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType responseType = ResponseType.json,
    String? contentType,
    List<Interceptor>? interceptors,
  }) {
    print('初始化Dio实例,请求地址为$baseUrl');
    _dio = Dio(buildBaseOptions(
      method: method,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      responseType: responseType,
      contentType: contentType,
    ));

    // 添加默认拦截器
    _dio.interceptors.add(DioInterceptor());

    // 添加自定义拦截器
    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }

    _inited = true;
  }

  // 构建基础配置
  BaseOptions buildBaseOptions({
    required String baseUrl,
    String method = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType responseType = ResponseType.json,
    String? contentType,
  }) {
    return BaseOptions(
      method: method,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      responseType: responseType,
      contentType: contentType ?? Headers.jsonContentType,
    );
  }

  // GET请求
  Future<BaseModel> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _checkInitialization();
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return BaseModel.fromResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST请求
  Future<BaseModel> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _checkInitialization();
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return BaseModel.fromResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // PUT请求
  Future<BaseModel> put({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _checkInitialization();
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return BaseModel.fromResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // DELETE请求
  Future<BaseModel> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    _checkInitialization();
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return BaseModel.fromResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // 改变基础URL
  void changeBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  // 检查Dio是否已初始化
  void _checkInitialization() {
    if (!_inited) {
      throw Exception("Dio未初始化，请先调用initDio()方法进行初始化。");
    }
  }

  // 全局错误处理
// 全局错误处理
  BaseModel _handleError(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return BaseModel(
            code: -1,
            data: null,
            msg: '网络超时，请稍后再试。',
          );
        case DioExceptionType.badResponse:
          return BaseModel(
            code: error.response?.statusCode ?? -1,
            data: error.response?.data,
            msg: error.response?.statusMessage ?? '未知错误',
          );
        case DioExceptionType.cancel:
          return BaseModel(
            code: -1,
            data: null,
            msg: '请求已取消。',
          );
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
        default:
          return BaseModel(
            code: -1,
            data: null,
            msg: '发生未知错误',
          );
      }
    } else {
      return BaseModel(
        code: -1,
        data: null,
        msg: error.toString(),
      );
    }
  }
}

// HTTP方法常量类
class HttpMethod {
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String DELETE = 'DELETE';
  static const String PATCH = 'PATCH';
  static const String HEAD = 'HEAD';
  static const String OPTIONS = 'OPTIONS';
}

// 自定义Dio拦截器，用于打印请求和响应
class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('请求: ${options.method} ${options.uri}');
    print('请求头: ${options.headers}');
    print('请求体: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('响应: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('错误: ${err.response?.statusCode} ${err.message}');
    super.onError(err, handler);
  }
}
