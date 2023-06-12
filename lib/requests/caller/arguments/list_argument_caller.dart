




import 'argument_caller.dart';

class ListArgumentCaller extends ArgumentCaller {


  final int page;
  final String search;
  final String? routePath;
  final String? routeOption;


  ListArgumentCaller({this.page=1, this.search="", this.routePath, this.routeOption, });
}