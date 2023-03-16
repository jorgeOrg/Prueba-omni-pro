

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/core/entities/result_state.dart';
import 'package:prueba_tecnica/core/models/result.dart';
import 'package:prueba_tecnica/core/entities/user.dart';
import 'package:prueba_tecnica/core/use_cases/get_users_use_case.dart';

class GetUsersNotifier extends StateNotifier<ResultState<List<User>, BackendError>>{
  
  GetUsersNotifier({
    required GetUsersUseCase getUsersusecase,
  }) : _getUsersusecase  = getUsersusecase,
      super(ResultState.initial()) ;

  final GetUsersUseCase _getUsersusecase;

  Future<void> getUsers({required int init}) async {
    state = ResultState.loading();
    final response = await _getUsersusecase.call(init: init);

    state = response.when(
      fail: (fail)=>ResultState.error(fail), 
      success: (success) => ResultState.data(success)
    );
  }

}