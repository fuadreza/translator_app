
import 'package:translator_app/services/translate_repo.dart';

abstract class TranslateState {}

class LoadingState extends TranslateState {}

class HasDataState extends TranslateState {
  final List<Sentence> data;

  HasDataState(this.data);
}