import 'package:translator_app/models/TranslatedModel.dart';

abstract class TranslateState {}

class LoadingState extends TranslateState {}

class HasDataState extends TranslateState {
  final List<Sentence> data;

  HasDataState(this.data);
}
