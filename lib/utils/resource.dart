sealed class Resource { 

  Resource._();

  factory Resource.success([Map<String, String>? data]) {
    return ResourceSuccess(data: data);
  }

  factory Resource.error(String message){
    return ResourceError(
      message: message
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

  ResourceError({
    required this.message
  }) : super._();
}
