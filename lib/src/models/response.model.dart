class ResponseModel {
  int status;
  String message;
  dynamic data;

  ResponseModel({this.status = 400, this.message = "", this.data});
}
