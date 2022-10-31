import 'dart:io';
import 'package:dio/dio.dart';
import '../custom_lib/awesome_dialogs/awesome_dialog.dart';
import '../main.dart';
import 'BaseResponse.dart';
import 'BaseResponseList.dart';
import 'ServerError.dart';
import 'network.dart';


enum LoadingStatus {
  refreshing,
  completed,
  loading,
  empty,
  error,
  newWorkError,
  unauthenticated
}

class Webservice {
  Dio client = Network().dio;

  static String getErrorsFromJson(Map<dynamic, dynamic>? json) {
    var errors = StringBuffer();

    print("getErrorsFromJson");
    if (json!.containsKey("msg")) errors.writeln(json["msg"]);

    if(!json.containsKey("errors"))
      if (json.containsKey("message")) errors.writeln(json["message"]);

    if (json.containsKey("errors"))
      json["errors"].forEach((i, value) {
        errors.writeln(value[0]);
      });


    return errors.toString().trim();
  }

  Future<BaseResponse<T>?> post<T>(String path,
      {Map<String, dynamic>? body}) async {
    try {
      print('body $body');
      var response = await client.post<Map<String, dynamic>>(
        path,
        data: body,
      );
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        print('res res ${res.result}');
        return res;
      } else if(response.statusCode == 401){
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg":"",
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        AwesomeDialog(
          context: MyApp.navigatorKey.currentContext!,
          // dialogType: DialogType.INFO,
          // animType: AnimType.BOTTOMSLIDE,
          // desc: App.getString().please_login,
          // btnOkText: App.getString().login,
          // btnCancelText: App.getString().sign_up,
          // btnCancelOnPress: () {
          //   App.navigatorKey.currentState?.pushAndRemoveUntil(MyRoute(
          //       builder: (context) {
          //         return SignupUi();
          //       },
          //       type: TransitionType.fade),   (Route<dynamic> route) => false);
          //
          // },
          // btnOkOnPress: () {
          //   App.navigatorKey.currentState?.pushAndRemoveUntil(MyRoute(
          //       builder: (context) {
          //         return LoginUi();
          //       },
          //       type: TransitionType.fade),   (Route<dynamic> route) => false);
          //
          // },
        ).show();
        return res;
      }else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.


      // print("${error.}");
      print("############# DioError ########### $error");
      //  print(error.response!.realUri);
      print(error.response!.data);
      //  print(error.response!.statusCode);
      print("############# DioError ###########");

      if (error.response?.statusCode == 401) {
        Map<String, dynamic> body = {
          "status": false,
          "code": error.response?.statusCode,
          "msg": "",
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        AwesomeDialog(
          context: MyApp.navigatorKey.currentContext!,
          // dialogType: DialogType.INFO,
          // animType: AnimType.BOTTOMSLIDE,
          // desc: App
          //     .getString()
          //     .please_login,
          // btnOkText: App
          //     .getString()
          //     .login,
          // btnCancelText: App
          //     .getString()
          //     .sign_up,
          // btnCancelOnPress: () {
          //   App.navigatorKey.currentState?.pushAndRemoveUntil(MyRoute(
          //       builder: (context) {
          //         return SignupUi();
          //       },
          //       type: TransitionType.fade), (Route<dynamic> route) => false);
          // },
          // btnOkOnPress: () {
          //   App.navigatorKey.currentState?.pushAndRemoveUntil(MyRoute(
          //       builder: (context) {
          //         return LoginUi();
          //       },
          //       type: TransitionType.fade), (Route<dynamic> route) => false);
          // },
        ).show();
        return res;
      }
      else {
        dynamic msg = ServerError.withError(error: error).getErrorMessage();
        String err = msg is String ? msg : getErrorsFromJson(msg);
        Map<String, dynamic> body = {
          "status": false,
          "code": getStatusCodeFromDioError(error),
          "msg": err,
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);

        return res;
      }
    }
    return null;
  }

  Future<BaseResponse<T>?> put<T>(String path,
      {Map<String, dynamic>? body}) async {
    try {
      print('body $body');
      var response = await client.put<Map<String, dynamic>>(
        path,
        data: body,
      );
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        print('res res ${res.result}');
        return res;
      } else if(response.statusCode == 401){
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg":"",
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        AwesomeDialog(
          context: MyApp.navigatorKey.currentContext!,
        ).show();
        return res;
      }else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.


      // print("${error.}");
      print("############# DioError ########### $error");
      //  print(error.response!.realUri);
      print(error.response!.data);
      //  print(error.response!.statusCode);
      print("############# DioError ###########");

      if (error.response?.statusCode == 401) {
        Map<String, dynamic> body = {
          "status": false,
          "code": error.response?.statusCode,
          "msg": "",
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        AwesomeDialog(
          context: MyApp.navigatorKey.currentContext!,
        ).show();
        return res;
      }
      else {
        dynamic msg = ServerError.withError(error: error).getErrorMessage();
        String err = msg is String ? msg : getErrorsFromJson(msg);
        Map<String, dynamic> body = {
          "status": false,
          "code": getStatusCodeFromDioError(error),
          "msg": err,
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);

        return res;
      }
    }
    return null;
  }

  Future<BaseResponse<T>?> putFile<T>(String path,
      {Map<String, dynamic>? body,
        File? file,
        File? logoImage,
        File? cardImage,
        List<File?>? files,
        MapEntry<String, MultipartFile>? mapEntry}) async {
    try {
      var formData = FormData.fromMap(body!);

      if (files != null) {
        var myFile = <MapEntry<String, MultipartFile>>[];
        for (int i = 0; i < files.length; i++) {
          if(files[i]!=null)
            myFile.add(MapEntry(
                "images[$i]",
                MultipartFile.fromFileSync(files[i]!.path,
                    filename: files[i]?.path.split(Platform.pathSeparator).last)));
        }

        formData.files.addAll(myFile);
      }
      if (file != null) {
        formData.files.add(MapEntry(
            'file',
            MultipartFile.fromFileSync(file.path,
                filename: file.path.split(Platform.pathSeparator).last)));
      }

      if (logoImage != null&&logoImage.path.isNotEmpty) {
        formData.files.add(MapEntry(
            'logo_url',
            MultipartFile.fromFileSync(logoImage.path,
                filename: logoImage.path.split(Platform.pathSeparator).last)));
      }
      if (cardImage != null&&cardImage.path.isNotEmpty) {
        formData.files.add(MapEntry(
            'business_card_url',
            MultipartFile.fromFileSync(cardImage.path,
                filename: cardImage.path.split(Platform.pathSeparator).last)));
      }

      if (mapEntry != null) formData.files.add(mapEntry);

      var response = await client.put<Map>(
        path,
        data: formData,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        response.data!["code"] = 200;

        print(response.data);
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      print(error.response!.data);
      print(error);

      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": null
      };

      BaseResponse<T> res = BaseResponse.fromJson(body);

      return res;
    }
  }

  Future<BaseResponse<T>?> postWithoutBody<T>(
      String path,
      ) async {
    try {
      var response = await client.post<Map>(
        path,
      );
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        print('res res ${res.result}');
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      print("############# DioError ###########");
      //  print(error.response!.realUri);
      print(error.response!.data);
      //  print(error.response!.statusCode);
      print("############# DioError ###########");

      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": null
      };
      BaseResponse<T> res = BaseResponse.fromJson(body);

      return res;
    }

    return null;
  }

  Future<BaseResponseList<T>?> postList<T>(String path,
      {Map<String, dynamic>? body}) async {
    try {
      print(body);
      var formData = FormData.fromMap(body!);
      var response = await client.post<Map>(
        path,
        data: formData,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponseList<T> res = BaseResponseList.fromJson(response.data);
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponseList<T> res = BaseResponseList.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      print("############# DioError ###########");
      //  print(error.response!.realUri);
      print(error.response!.data);
      //  print(error.response!.statusCode);
      print("############# DioError ###########");

      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": null
      };
      BaseResponseList<T> res = BaseResponseList.fromJson(body);

      return res;
    }

    return null;
  }

  Future<BaseResponse<T>?> postFile<T>(String path,
      {Map<String, dynamic>? body,
        File? file,
        File? logoImage,
        File? cardImage,
        List<File?>? files,
        MapEntry<String, MultipartFile>? mapEntry}) async {
    try {
      var formData = FormData.fromMap(body!);

      if (files != null) {
        var myFile = <MapEntry<String, MultipartFile>>[];
        for (int i = 0; i < files.length; i++) {
          if(files[i]!=null)
            myFile.add(MapEntry(
                "images[$i]",
                MultipartFile.fromFileSync(files[i]!.path,
                    filename: files[i]?.path.split(Platform.pathSeparator).last)));
        }

        formData.files.addAll(myFile);
      }
      if (file != null) {
        formData.files.add(MapEntry(
            'file',
            MultipartFile.fromFileSync(file.path,
                filename: file.path.split(Platform.pathSeparator).last)));
      }

      if (logoImage != null&&logoImage.path.isNotEmpty) {
        formData.files.add(MapEntry(
            'logo',
            MultipartFile.fromFileSync(logoImage.path,
                filename: logoImage.path.split(Platform.pathSeparator).last)));
      }
      if (cardImage != null&&cardImage.path.isNotEmpty) {
        formData.files.add(MapEntry(
            'business_card',
            MultipartFile.fromFileSync(cardImage.path,
                filename: cardImage.path.split(Platform.pathSeparator).last)));
      }

      if (mapEntry != null) formData.files.add(mapEntry);

      var response = await client.post<Map>(
        path,
        data: formData,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        response.data!["code"] = 200;

        print(response.data);
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      print(error.response!.data);
      print(error);

      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": null
      };

      BaseResponse<T> res = BaseResponse.fromJson(body);

      return res;
    }
  }

  Future<BaseResponse<T>?> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      print('hi hi');
      var response = await client.get<Map>(
        path,
        queryParameters: queryParameters,
      );
      print('response kkk ${response.data}');
      print('response status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": null
      };
      BaseResponse<T> res = BaseResponse.fromJson(body);

      return res;
    }
  }

  Future<BaseResponse<T>?> delete<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      print('hi hi');
      var response = await client.delete<Map>(
        path,
        queryParameters: queryParameters,
      );
      print('response kkk ${response.data}');
      print('response status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponse<T> res = BaseResponse.fromJson(response.data);
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponse<T> res = BaseResponse.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": null
      };
      BaseResponse<T> res = BaseResponse.fromJson(body);

      return res;
    }
  }

  Future<BaseResponseList<T>?> getList<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await client.get<Map>(
        path,
        queryParameters: queryParameters,
      );
      print("getList BaseResponseList");
      print(response.data);
      print('response status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        response.data!["code"] = 200;
        BaseResponseList<T> res = BaseResponseList.fromJson(response.data);
        return res;
      } else {
        Map<String, dynamic> body = {
          "status": false,
          "code": response.statusCode,
          "msg": getErrorsFromJson(response.data),
          "result": null
        };
        BaseResponseList<T> res = BaseResponseList.fromJson(body);
        return res;
      }
    } on DioError catch (error) {
      dynamic msg = ServerError.withError(error: error).getErrorMessage();
      String err = msg is String ? msg : getErrorsFromJson(msg);
      Map<String, dynamic> body = {
        "status": false,
        "code": getStatusCodeFromDioError(error),
        "msg": err,
        "result": []
      };
      BaseResponseList<T> res = BaseResponseList.fromJson(body);

      return res;
    }
  }

  int? getStatusCodeFromDioError(DioError error) {
    if (error.type == DioErrorType.response) {
      return error.response!.statusCode!;
    } else {
      return 500;
    }
  }
}


