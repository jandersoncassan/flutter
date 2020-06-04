class ApiResponse<T> {

  bool isValid;
  String message;
  T result;

  ApiResponse.ok(this.result){
    this.isValid = true;
  }

  ApiResponse.error(this.message){
    this.isValid = false;
  }
}