abstract class Fetchdata {
  Future<dynamic> fetchtable(String host, String path);
  Future<dynamic> postData(dynamic myclass,String path,{String host});
}
