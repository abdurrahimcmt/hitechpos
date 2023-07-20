class CreateBaseUrl{
  String createBaseUrl(String schema,String domain,String port){
    return "$schema://$domain:$port/";
  }
}