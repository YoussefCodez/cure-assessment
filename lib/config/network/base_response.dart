sealed class BaseResponse<T> {}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  SuccessResponse(this.data);
}

class FailedResponse<T> extends BaseResponse<T> {
  final String message;
  FailedResponse(this.message);
}
