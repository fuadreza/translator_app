
abstract class TranslateEvent{}

class GetDataEvent extends TranslateEvent {
  final String target;
  final String query;

  GetDataEvent(this.target, this.query);
}