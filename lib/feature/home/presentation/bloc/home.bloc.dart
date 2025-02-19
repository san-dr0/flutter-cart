import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.event.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.state.dart';

class HomeProductBloc extends Bloc<HomeProductEvent, HomeProductState> {
  AppDatabase appDatabase;
  HomeProductBloc({required this.appDatabase}): super(HomeProductLoadingState()) {
    on<HomeOnLoadedEvent>(homeOnLoadedEvent);
  }

  FutureOr<void> homeOnLoadedEvent(HomeOnLoadedEvent event, Emitter<HomeProductState> emit) async{
    List<ProductModel> productList = await appDatabase.getProductRecord();
  
    emit(HomeProductOnLoadedState(productList: productList));
  }
}
