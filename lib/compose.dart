import 'package:fn_compose/composeFn.dart';

class C<TIn> {
  final TIn input;
  C(this.input);

  //if https://github.com/dart-lang/sdk/issues/30048 is allowed
  // ComposeFn<TOut> operator >><TOut>(TOut Function(TIn) newFn) => f(newFn);

  ComposeFn<TOut> x<TOut>(TOut Function(TIn) newFn) {
    return ComposeFn<TOut>(fn: newFn, input: this);
  }
}
