

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_tecnica/core/entities/result_state.dart';
import 'package:prueba_tecnica/core/models/result.dart';
import 'package:prueba_tecnica/ui/screens/providers/get_users_notifier.dart';

import '../../../core/dependencies/providers.dart';
import '../../../core/entities/user.dart';

final getUsers = StateNotifierProvider<GetUsersNotifier, ResultState<List<User>, BackendError>>(
  (ref) => GetUsersNotifier(getUsersusecase: ref.watch(getUserUseCaseProvider))
);

final nextItemStart = StateProvider<int>((ref)=> 0);