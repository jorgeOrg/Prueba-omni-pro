
import 'package:prueba_tecnica/core/data_source/prueba_data_source.dart';
import 'package:prueba_tecnica/core/entities/user.dart';
import 'package:prueba_tecnica/core/repositories/iprueba_repository.dart';

import '../models/result.dart';

class PruebaRepository extends IPruebaRepository{

  PruebaRepository({
    required PruebaDataSource dataSource,
  }) : _dataSource = dataSource;
  
  final PruebaDataSource _dataSource;

  @override
  Future<Result<List<User>, BackendError>> getUsers({required int init}) async{
    final result = await _dataSource.getUser(init: init);
    return result.when(
      fail: (fail) => Fail(fail), 
      success: (success)=> Success(success.map((e) => e.toEntity()).toList())
    );
  }
}