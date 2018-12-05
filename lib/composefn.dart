
import 'package:fn_compose/compose.dart';

class ComposeFn<TFnIn> {
  final C input;
  final Function fn;
  final ComposeFn previousComposeFn;
 
  //if https://github.com/dart-lang/sdk/issues/30048 is allowed
  // ComposeFn<TOut> operator >><TOut>(TOut Function(TIn) newFn) => f(newFn);

  ComposeFn({this.previousComposeFn, this.input, this.fn});

  ComposeFn<TFnOut> x<TFnOut>(TFnOut Function(TFnIn) newFn) {
    return ComposeFn<TFnOut>(fn: newFn, previousComposeFn: this);
  }

  TFnIn execute() {
    if (input == null) return fn(this.previousComposeFn.execute());

    return fn(input.input);
  }
}
