import 'package:dio/dio.dart';

class AcessoNegadoException extends DioError {
  String msg;
  AcessoNegadoException(this.msg, {DioError exception})
      : super(
            request: exception.request,
            response: exception.response,
            type: exception.type,
            error: exception.error);

  @override
  String toString() =>
      'AcessoNegadoException(mensagem: $msg , exception: ${super.error})';
}
