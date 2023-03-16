import 'package:prueba_tecnica/core/models/result.dart';
import 'package:prueba_tecnica/core/entities/user.dart';
import 'package:prueba_tecnica/core/repositories/iprueba_repository.dart';

class GetUsersUseCase {

  GetUsersUseCase({
    required IPruebaRepository repository
  }) : _repository = repository ;

  final IPruebaRepository _repository;

  Future<Result<List<User>, BackendError>> call({required int init}) => _repository.getUsers(init: init);

}