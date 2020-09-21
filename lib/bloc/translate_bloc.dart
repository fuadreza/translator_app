

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/bloc/translate_event.dart';
import 'package:translator_app/bloc/translate_state.dart';
import 'package:translator_app/services/translate_repo.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {

  final TranslateRepo _repository;

  TranslateBloc(this._repository){
    _repository.translated.listen((event) {

    });
  }

  @override
  TranslateState get initialState => LoadingState();

  @override
  Stream<TranslateState> mapEventToState(TranslateEvent event) async*{
    if(event is GetDataEvent){
      var data = await _repository.getTranslated(event.target, event.query);
      yield HasDataState(data);
    }
  }
}