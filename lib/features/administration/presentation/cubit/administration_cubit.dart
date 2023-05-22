import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'administration_state.dart';

class AdministrationCubit extends Cubit<AdministrationState> {
  AdministrationCubit() : super(AdministrationInitial());
}


