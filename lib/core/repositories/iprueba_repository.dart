
import 'package:prueba_tecnica/core/entities/user.dart';
import '../models/result.dart';

abstract class IPruebaRepository{

    Future<Result<List<User>, BackendError>> getUsers({required int init});

}