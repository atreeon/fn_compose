# fn_compose

Typed functional piping in Dart.

### Examples
```dart
C(initial value).x(first function).x(second function).execute();

var result = C(6)
    .x0(addOne)
    .x2(addTwoNumbers, 4, 5)
    .x1(addNumber, 3)
    .x0(addOne)
    .x1(addNumber, 4)
    .$(); //we need this last function to exectue the composition
```

### Todo / might do later
* just use one class (and the initial value can be created by a static function)
* output a function (although could use compose dartz for that)
* Cannot implement the >> operator because operator generics are not possible in Dart at the moment (possibly ever due to syntax problems)

This is just a playful thing, nothing serious!
