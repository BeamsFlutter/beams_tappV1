
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:beams_tapp/constants/common_functn.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;





import '../constants/enums/network_types.dart';
import 'exception/exception.dart';
import 'exception/exception_messages.dart';
import 'package:get/get.dart';


class ApiHelperClass {

  static final ApiHelperClass _singleton = ApiHelperClass._internal();

  factory ApiHelperClass() {
    return _singleton;
  }

  ApiHelperClass._internal();

  static BaseOptions baseOptions = BaseOptions(
    baseUrl: getBaseUrl(),
    connectTimeout: 10000,
    receiveTimeout: 10000,
    responseType: ResponseType.json,

  );

  Dio dio = Dio(baseOptions);

  var postLoding =false;

  fnLoading(){
   return Get.dialog(
     barrierDismissible: false, // user must tap button!
     barrierColor: Colors.transparent,
     const AlertDialog (
       elevation: 0,
       backgroundColor: Colors.transparent,
       content: CupertinoActivityIndicator(
         animating: true,
         radius: 20,
       ),
     ),
   );
  }


  //region Get Methode
  Future<dynamic> getRequest(NetworkType method, String endPoint,[header,queryParams]) async {

    var responseJson;
    try {
      debugPrint("Api--------->${dio.options.baseUrl + endPoint}");
      debugPrint("type--------->${method}");
      if(header != null){
        dio.options.headers.addAll(header);
        debugPrint("headers ========>${dio.options.headers}");
      }
      if(queryParams != null){
        dio.options.queryParameters.addAll(queryParams);
        debugPrint("query params ========>${dio.options.queryParameters}");
      }
      final response = await dio.get(endPoint);
      responseJson = _returnResponse(response);
     //  debugPrint("Api result after converting-->$responseJson");
    }on DioError catch(exception){
        debugPrint("Exccception ${exception.response?.statusCode} ${exception.type}");
        handleDioExceptions(exception);
    }catch(exception){
      throw UnHandledException(exception.toString());
    }
    return responseJson;
  }
  //endregion

  //region Post Methode
  Future<dynamic> postRequest(bool isload, String endPoint, dynamic params,[header,isMultiPartRequest]) async {
    var responseJson;

    try {
      if(isload){
  postLoding = true;
  fnLoading();
  }


      debugPrint("Api ============>${dio.options.baseUrl + endPoint}");
      debugPrint("params =========>$params");
      ///if header is not null add the header to request
      if(header != null){
        dio.options.headers.addAll(header);
        debugPrint("header =========>${dio.options.headers}");
      }

         final response = await dio.post(endPoint,
             data: isMultiPartRequest == null ? jsonEncode(params) : params,
             onReceiveProgress: (int count, int total) {
              //  debugPrint("sent${count.toString()}" + " total${total.toString()}");
            }, onSendProgress: (int count, int total) {
              // debugPrint("sent${count.toString()}" + " total${total.toString()}");
            });


      dprint(response);
      responseJson = _returnResponse(response);
      debugPrint("Api result after converting-->$responseJson");
    } on DioError catch(exception){
      debugPrint("Exception ${exception.response?.statusCode} ${exception.type}");
      postLoding =false;
      Get.back();
      handleDioExceptions(exception);
    }catch(exception){
      postLoding =false;
      Get.back();
      throw UnHandledException(exception.toString());
    }
    return responseJson;
  }
//endregion

  //region for GettingToken
  Future<dynamic> tokenPostRequest(
       String endPoint, dynamic params) async {
    var responseJson;
    try {

      debugPrint("Api ============>${dio.options.baseUrl + endPoint}");
      debugPrint("params =========>$params");
      ///if header is not null add the header to request
      final response = await dio.post(
            endPoint,
            data: params,
           options: Options(contentType: Headers.formUrlEncodedContentType),
            );
      responseJson = _returnResponse(response);
      debugPrint("Api result after converting-->$responseJson");
    } on DioError catch(exception){
      debugPrint("Exception........... ${exception.response?.statusCode} ${exception.type}");
      handleDioExceptions(exception);
    }catch(exception){
      throw UnHandledException(exception.toString());
    }
    return responseJson;
  }

  ////BISTRO TOKEN
  Future<dynamic> bistroToken(String endPoint, dynamic params) async {
    var responseJson;
    try {

      debugPrint("Api BISTROOOOOOOOOOOOOOO ============>${endPoint}");
      debugPrint("params =========>$params");
      ///if header is not null add the header to request
      final response = await dio.post(
        endPoint,
        data: params,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      responseJson = _returnResponse(response);
      debugPrint("Api result after converting-->$responseJson");
    } on DioError catch(exception){
      debugPrint("Exception ${exception.response?.statusCode} ${exception.type}");
      handleDioExceptions(exception);
    }catch(exception){
      throw UnHandledException(exception.toString());
    }
    return responseJson;
  }





  ///handling the exception
  handleDioExceptions(DioError exception){
    switch(exception.type){
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
        throw TimeoutException(ExceptionMessages.connectionTimeOut);
    ///handle 500,400,401 api erros .....
      case DioErrorType.response:
        switch(exception.response?.statusCode ?? -1){
          case 400:
            debugPrint("data type of response ${exception.response?.data.runtimeType}");
            throw BadRequestException(exception.response?.data['message'] ?? ExceptionMessages.badRequest);
          case 401:
            // NavigationHelperFn.logout();
            throw UnauthorisedException(ExceptionMessages.unAuthorization);
          case 500:
            throw InternalServerError(exception.response?.statusMessage ?? ExceptionMessages.internelServerError);
          default:
            throw UnHandledException(exception.message);
        }
      case DioErrorType.other:
        if (exception.message.contains('SocketException')) {
          throw InterNetConnectionException(ExceptionMessages.noInternetConnection);
        }
        break;
      case DioErrorType.cancel:
        // TODO: Handle this case.
        break;
    }
  }

  //region Base Url Depends on Modes
  static String getBaseUrl() {
    if (Foundation.kReleaseMode) {
      //todo: change the name of base url
     return "http://192.168.1.117:4400";
     // return "http://192.168.0.103:2323";

      // return  "http://splash123.dyndns.org:4402";
    } else if (Foundation.kDebugMode) {
      return "http://192.168.0.103:2323";
    } else if (Foundation.kProfileMode) {
      return "http://192.168.1.117:4400";
      // return "http://splash123.dyndns.org:4402";
    } else {
      return "http://192.168.1.117:4400";
      // return "http://splash123.dyndns.org:4402";
    }
  }
//endregion

  dynamic _returnResponse(response) {

    if(postLoding){
      postLoding =false;
      Get.back();
    }
    //please refer: https://restfulapi.net/http-status-codes/
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.data;
        return responseJson;
      case 405:
        throw BadRequestException(ExceptionMessages.badRequest);
      case 401:
      case 403:
        throw UnauthorisedException(ExceptionMessages.unAuthorization);
      case 408:
      case 504:
        throw ConnectionTimeOutEception(ExceptionMessages.connectionTimeOut);
      case 500:
        throw InternalServerError(ExceptionMessages.internelServerError);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode :${response.statusCode}');
    }
  }
}


