import 'package:fn_compose/composefn.dart';

//if https://github.com/dart-lang/sdk/issues/30048 is allowed
// ComposeFn<TOut> operator >><TOut>(TOut Function(TIn) newFn) => f(newFn);

///Initialise our pipe with the first value
class C<TIn> {
  final TIn input;
  C(this.input);

  ///Initial constructor taking two paramet
  ComposeFn<TOut, TParam1, TParam2> x2<TOut, TParam1, TParam2>(
      TOut Function(TIn, TParam1, TParam2) newFn, TParam1 param1, TParam2 param2) {
    return ComposeFn<TOut, TParam1, TParam2>(
        fn: newFn, input: this, param1: param1, param2: param2);
  }

  ///A function that takes the result of the previous as its input and two other parameters
  ComposeFn<TOut, TParam1, dynamic> x1<TOut, TParam1>(
      TOut Function(TIn, TParam1) newFn, TParam1 param1) {
    return ComposeFn<TOut, TParam1, dynamic>(fn: newFn, input: this, param1: param1);
  }

  ///A function that takes the result of the previous as its input and one other parameter
  ComposeFn<TOut, dynamic, dynamic> x0<TOut>(TOut Function(TIn) newFn) {
    return ComposeFn<TOut, dynamic, dynamic>(fn: newFn, input: this);
  }

  ///A function that just takes the result of the previous as its input
  ComposeFn<TOut, dynamic, dynamic> Function(TParam1) c1<TOut, TParam1>(
      TOut Function(TIn, TParam1) newFn) {
    return (TParam1 b) => ComposeFn(fn: (TIn a) => newFn(a, b), input: this);
  }
}
