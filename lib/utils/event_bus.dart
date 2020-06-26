import 'dart:async';

import 'package:provider/provider.dart';


//Tipamos para garantir que apenas uma 'aba' será atualizada , a correta !
class Event {
}

class EventBus {

  final _streamController = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamController.stream;

  sendEvents(Event event){
    _streamController.add(event);
  }

  dispose(){
    _streamController.close();
  }

  static EventBus get(context) =>  Provider.of<EventBus>(context, listen: false);
}