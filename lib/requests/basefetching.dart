abstract class Fetchdata {
  Future<dynamic> fetchtable(String host, String path);
  Future<dynamic> getData(Object myclass,String host,String path);
  Future<dynamic> postData(Object myclass,dynamic body,String host,String path);
}
