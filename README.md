# fn_compose

A typed functional composition in Dart.

Cannot implement the >> operator because operator generics are not possible in Dart at the moment

### Examples
```dart
C(initial value).x(first function).x(second function).execute();
C(5).x(addOne).execute();
```

This is just a playful thing, nothing serious!
