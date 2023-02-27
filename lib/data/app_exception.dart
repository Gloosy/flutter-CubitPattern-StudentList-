

class AppException implements Exception{

  final _prefix;
  final _message;

  AppException(this._prefix, this._message);


  @override
  String toString() {
    // TODO: implement toString
    return 'AppException{_prefix: $_prefix, _message: $_message}';
  }
}

class FetchDataException extends AppException{
  FetchDataException(String? message):
        super(message, "Error during Communication");
}


class BadRequestException extends AppException{
  BadRequestException(String? message)
  : super(message, 'bad request');
}

class UnAuthorizedException extends AppException{
  UnAuthorizedException(String? message)
  : super(message, 'unauthorized request');
}