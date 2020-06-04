import 'dart:async';

class SimpleBloc<T> {

  final _controller = StreamController<T>();
  Stream<T> get stream => _controller.stream;

  add(T event){
    _controller.add(event);
  }

  addError(Object error){
    if(! _controller.isClosed)
      _controller.addError(error);
  }

  void dispose() {
    print('>>FECHOU SimpleBloc');
    _controller.close();
  }
}
