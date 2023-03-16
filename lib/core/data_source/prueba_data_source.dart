import 'package:prueba_tecnica/core/api/api_utils.dart';
import 'package:prueba_tecnica/core/models/result.dart';
import 'package:prueba_tecnica/core/models/user_model.dart';

const String _kRootPath = "/albums/1";

class PruebaDataSource {

  PruebaDataSource({
    required ApiUtils apiUtils
  }) : _apiUtils = apiUtils;

  final ApiUtils _apiUtils;
  
  Future<Result<List<UserModel>, BackendError>> getUser({required int init,})async{

    String path = '$_kRootPath/photos?_start=$init&_limit=10';

    Result<dynamic, BackendError> result =  await _apiUtils.get(path);


    return result.when(
      fail: (fail) => Fail(fail), 
      success: (success) {
        final usersList = (success) as List;

        return Success(usersList.map((e) => UserModel.fromJson(e)).toList());
      }
    );


  }



}