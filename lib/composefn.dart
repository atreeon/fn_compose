import 'package:fn_compose/compose.dart';

class ComposeFn<TFnIn, TInParamIn1, TInParamIn2> {
  final C input;
  final Function fn;
  final ComposeFn previousComposeFn;
  final TInParamIn1 param1;
  final TInParamIn2 param2;

  //if https://github.com/dart-lang/sdk/issues/30048 is allowed
  // ComposeFn<TOut> operator >><TOut>(TOut Function(TIn) newFn) => f(newFn);

  ComposeFn({this.previousComposeFn, this.input, this.fn, this.param1, this.param2});

  //horrible duplication in the functions
  //mixins won't work because I use this, neither will base classes because I use
  ComposeFn<TFnOut, dynamic, dynamic> x0<TFnOut>(TFnOut Function(TFnIn) newFn) {
    return ComposeFn<TFnOut, dynamic, dynamic>(fn: newFn, previousComposeFn: this);
  }

  ComposeFn<TFnOut, TParam1, dynamic> x1<TFnOut, TParam1>(
      TFnOut Function(TFnIn, TParam1) newFn, TParam1 param1) {
    return ComposeFn<TFnOut, TParam1, dynamic>(fn: newFn, previousComposeFn: this, param1: param1);
  }

  ComposeFn<TFnOut, TParam1, TParam2> x2<TFnOut, TParam1, TParam2>(
      TFnOut Function(TFnIn, TParam1, TParam2) newFn, TParam1 param1, TParam2 param2) {
    return ComposeFn<TFnOut, TParam1, TParam2>(
        fn: newFn, previousComposeFn: this, param1: param1, param2: param2);
  }

  TFnIn execute() {
    if (input == null) {
      if (this.param2 != null) {
        return fn(this.previousComposeFn.execute(), param1, param2);
      } else if (this.param1 != null) {
        return fn(this.previousComposeFn.execute(), param1);
      } else {
        return fn(this.previousComposeFn.execute());
      }
    }

    if (this.param2 != null) {
      return fn(input.input, param1, param2);
    } else if (this.param1 != null) {
      return fn(input.input, param1);
    } else {
      return fn(input.input);
    }
  }
}
