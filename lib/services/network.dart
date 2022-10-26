import 'package:dio/dio.dart';
import '../utils/constants.dart';
import '../utils/user_preference.dart';

class Network {
  static final Network _singleton =  Network._internal();

  factory Network() {
    return _singleton;
  }

  Network._internal();

  Dio get dio {
    Dio dio = Dio();
    // set base url
    dio.options.baseUrl = Constants.baseUrl;
    // handle timeouts
    dio.options.connectTimeout = 20000; //5s
    dio.options.receiveTimeout = 20000;

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent

      String token = UserPreferences().token;
      print("tokenx $token");
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }

      // set accept language
      String lang = "ar";
      if (lang != null) {
        options.headers["Accept-Language"] = lang;
      }
      options.headers["X-Client-Device-Name"] = "flutter";
      options.headers["Accept"] = "application/json";

      // print requests
      print("Pre request:${options.method},${options.uri.toString()}");
      /*print("Pre request:${options.headers.toString()}");
          print("Pre request:${options.data.toString()}");*/

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      final int? statusCode = response.statusCode;

      // print(
      //     "Response From:${statusCode} ${response.request.method} ${response.request.baseUrl} ${response.request.path}");
      // print("Response From:${response.toString()}");
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));

    return dio;
  }
/* static Future<Dio> getApiClient() async {

    if( _dio == null) {
      _dio = new Dio();

      String token = ""; //await storage.read(key: USER_TOKEN);
      _dio.interceptors.clear();
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Authorization"] = "Bearer " + token;
        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          /*_dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        token = await user.getIdToken(refresh: true);
        await writeAuthKey(token);
        options.headers["Authorization"] = "Bearer " + token;
        _dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();
        return _dio.request(options.path,options: options);*/

          return error;
        } else {
          return error;
        }
      }));
      // _dio.options.baseUrl = baseUrl;
      return _dio;
    }else{
      return _dio;
    }
  }

  */
}
