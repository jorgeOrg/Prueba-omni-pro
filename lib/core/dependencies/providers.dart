
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/core/data_source/prueba_data_source.dart';
import 'package:prueba_tecnica/core/repositories/prueba_repository.dart';
import 'package:prueba_tecnica/core/use_cases/get_users_use_case.dart';

import 'api_provider.dart';

final  pruebaDataSourceProvider = Provider((ref) => PruebaDataSource(
  apiUtils: ref.watch(apiProvider)
));

final pruebaRepositoryProvider = Provider((ref) => PruebaRepository(
  dataSource: ref.watch(pruebaDataSourceProvider)
));

final getUserUseCaseProvider = Provider((ref) => GetUsersUseCase(
  repository: ref.watch(pruebaRepositoryProvider)
));