class CreateBaseUrl{
  String baseUrl(String schema,String domain,String port){
    return "$schema://$domain:$port/";
  }
}