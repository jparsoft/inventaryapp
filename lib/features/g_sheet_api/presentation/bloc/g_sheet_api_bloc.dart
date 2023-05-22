

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'g_sheet_api_event.dart';
part 'g_sheet_api_state.dart';

class GSheetApiBloc extends Bloc<GSheetApiEvent, GSheetApiState> {
  GSheetApiBloc() : super(GSheetApiInitial()) {
    on<GSheetApiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
