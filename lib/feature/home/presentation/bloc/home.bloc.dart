import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.event.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeProductBloc extends Bloc<HomeProductEvent, HomeProductState> {
  AppDatabase appDatabase;
  HomeProductBloc({required this.appDatabase}): super(HomeProductLoadingState()) {
    on<HomeOnLoadedEvent>(homeOnLoadedEvent);
    on<HomeOnViewCertainProductEvent>(cartOnViewCertainProductEvent);
  }

  FutureOr<void> homeOnLoadedEvent(HomeOnLoadedEvent event, Emitter<HomeProductState> emit) async{
    List<ProductEntity> productList = await appDatabase.getProductRecord();
  
    emit(HomeProductOnLoadedState(productList: productList));
  }

  FutureOr<void> cartOnViewCertainProductEvent(HomeOnViewCertainProductEvent event, Emitter<HomeProductState> emit) {
    BuildContext context = event.context;

    context.push("/view-certain-product", extra: event.productModel);
  }
}
