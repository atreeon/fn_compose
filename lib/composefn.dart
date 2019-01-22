import 'package:fn_compose/compose.dart';

//if https://github.com/dart-lang/sdk/issues/30048 is allowed
// ComposeFn<TOut> operator >><TOut>(TOut Function(TIn) newFn) => f(newFn);

//horrible duplication in the functions
//mixins won't work because I use this, neither will base classes because I use
//I can't use default parameters because I need to be explicit about the parameters of the function 
//  that is passed in

///The individual functions that you want to compose
class ComposeFn<TFnIn, TInParamIn1, TInParamIn2> {
  final C input;
  final Function fn;
  final ComposeFn previousComposeFn;
  final TInParamIn1 param1;
  final TInParamIn2 param2;

  ComposeFn({this.previousComposeFn, this.input, this.fn, this.param1, this.param2});

  ///A function that just takes the result of the previous as its input
  ComposeFn<TFnOut, dynamic, dynamic> x0<TFnOut>(TFnOut Function(TFnIn) newFn) {
    return ComposeFn<TFnOut, dynamic, dynamic>(fn: newFn, previousComposeFn: this);
  }

  ///A function that takes the result of the previous as its input and one other parameter
  ComposeFn<TFnOut, TParam1, dynamic> x1<TFnOut, TParam1>(
      TFnOut Function(TFnIn, TParam1) newFn, TParam1 param1) {
    return ComposeFn<TFnOut, TParam1, dynamic>(fn: newFn, previousComposeFn: this, param1: param1);
  }

  ///A function that takes the result of the previous as its input and two other parameters
  ComposeFn<TFnOut, TParam1, TParam2> x2<TFnOut, TParam1, TParam2>(
      TFnOut Function(TFnIn, TParam1, TParam2) newFn, TParam1 param1, TParam2 param2) {
    return ComposeFn<TFnOut, TParam1, TParam2>(
        fn: newFn, previousComposeFn: this, param1: param1, param2: param2);
  }

  ///Required to execute the composition
  TFnIn $() {
    if (input == null) {
      if (this.param2 != null) {
        return fn(this.previousComposeFn.$(), param1, param2);
      } else if (this.param1 != null) {
        return fn(this.previousComposeFn.$(), param1);
      } else {
        return fn(this.previousComposeFn.$());
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
