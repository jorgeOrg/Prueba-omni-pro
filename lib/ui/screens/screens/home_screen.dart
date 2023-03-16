import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:prueba_tecnica/core/entities/user.dart';
import 'package:prueba_tecnica/ui/utils/custom_toast.dart';
import '../../widgets/custom_card.dart';
import '../providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  final ScrollController _scrollController = ScrollController();

  final userList = <User>[];
  bool isLoadingData = true;
  bool isUpdatingData = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      ref.read(getUsers.notifier).getUsers(init: 0).then((value) {
        final state = ref.read(getUsers);
        if(state.data != null){
          userList.addAll(state.data!);
          isLoadingData = false;
          ref.read(nextItemStart.notifier).state = state.data!.length;
        }
        if(state.error != null){
          isLoadingData = false;
          showCustomToast(state.error!.description!, Colors.white, Colors.red);
        }
      });
      
    });
    _scrollController.addListener(() { 
      if(_scrollController.position.pixels > _scrollController.position.maxScrollExtent-500){
        Future.delayed(Duration.zero, (){
          final state = ref.read(getUsers);
          if(state.data != null){
            ref.read(getUsers.notifier).getUsers(init: ref.read(nextItemStart)).then((value) {
              userList.addAll(state.data!);
              if(state.data != null){
                ref.read(nextItemStart.notifier).state = state.data!.length;
              }
              ref.read(nextItemStart.notifier).state = userList.length;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(getUsers);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Lista de elementos", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
      ),
      body: isLoadingData
      ? Center(
        child: Lottie.asset('assets/loading-data.json')
      )
      :  Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SafeArea(
          child: userList.isNotEmpty ? ListView.builder(
            controller: _scrollController,
            itemCount:userList.length ,
            itemBuilder: (BuildContext context, int index) {  
              final data = userList[index];
              return Item(data: data);
            },
          ) : const Center(
            child: Text(
              "No hay data para mostrar", 
              style: TextStyle( 
                color: Colors.black, 
                fontSize: 30
              ),
            ),
          ),
        ),
      ),
    );
  }
}

