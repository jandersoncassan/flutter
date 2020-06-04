
import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/services/loripsum_api.dart';

class LoripsumBloc extends SimpleBloc<String> {
  
  String textCache;

 void fetch() async {
    try {
      String text = textCache ?? await LoripsumApi.getLoripsum();
      textCache = text;
      add(text);

    } catch (exception) {
      addError(exception);
    }
  }
}