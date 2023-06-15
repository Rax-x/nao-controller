sealed class Resource { 

  Resource._();

  factory Resource.success([Map<String, String>? data]) {
    return ResourceSuccess(data: data);
  }

  factory Resource.error(String message, int statusCode){
    return ResourceError(
      message: message, 
      statusCode: statusCode
    );
  }
}

class ResourceSuccess extends Resource { 

  Map<String, String>? data;

  ResourceSuccess({
    required this.data
  }) : super._();

}

class ResourceError extends Resource {
  final String message;
  final int statusCode;

  ResourceError({
    required this.message,
    required this.statusCode
  }) : super._();
}
