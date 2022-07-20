
import '../../User/DataLayer/localDataLayer/localData.dart';

class GetSharedLocalData {
 static late Shared shared;

 static Future getShared() async {
    shared = Shared.prefGetString(key: "CompanyTokenVerify");
  }
}
