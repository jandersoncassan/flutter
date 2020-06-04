class ResponseApi<T> {

  bool isValid;
  String message;
  T result;

  ResponseApi.ok(this.result){
    this.isValid = true;
  }

  ResponseApi.error(this.message){
    this.isValid = false;
  }
}