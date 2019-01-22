import 'package:fn_compose/compose.dart';
import 'package:test/test.dart';

var addOne = (int x) => x + 1;
var addOneAndString = (String str, int x) => (x + 1).toString() + str;
var stringAndAddOne = (int x, String str) => (x + 1).toString() + str;
var stringifyIt = (int x) => x.toString();
var addNumber = (int x, int y) => x + y;
var addTwoNumbers = (int x, int y, int z) => x + y + z;

void main() {
  group("ComposeFn", () {
    test("1", () {
      var result = C(5).x0(addOne).$();
      expect(result, 6);
    });

    test("2", () {
      var result = C(6).x0(addOne).x0(addOne).$();
      expect(result, 8);
    });

    test("3 do other data types work", () {
      var result = C(6).x0(addOne).x0(addOne).x0(stringifyIt).$();
      expect(result, "8");
    });

    test("4 params", () {
      var result = C(6)
          .x0(addOne)
          .x1(addNumber, 3) //
          .$();
      expect(result, 10);
    });

    test("5 multiple params", () {
      var result = C(6)
          .x0(addOne)
          .x2(addTwoNumbers, 4, 5)
          .x1(addNumber, 3)
          .x0(addOne)
          .x1(addNumber, 4)
          .$();
      expect(result, 24);
    });

    test("6 multi params on first", () {
      var result = C(6).x1(addNumber, 2).x1(addNumber, 3).$();
      expect(result, 11);
    });

    test("7 return function", () {
      var add5andOne = C(5).x0(addOne).$;
      var result = add5andOne();
      expect(result, 6);
    });

    test("8 with partial application", () {
      var result = C(5).x0((x) => addNumber(x, 1)).$();
      expect(result, 6);
    });

    test("9 with curry", () {
      var result = C(5).x0(C2(addNumber)(3)).$();
      expect(result, 8);
    });

    test("10 with curry", () {
      var result = C(5).x0(C2(addOneAndString)("Blah")).$();
      expect(result, "6Blah");
    });

    // can we do auto currying?
    test("11 with automatic currying", () {
      var result = C(5).c1(stringAndAddOne)("plip").$();
      expect(result, "6plip");
    });

    // test("8 return function with parameter", () {
    //   var addXandOne = C<int>().x(addOne).execute;
    //   var result = addXandOne();
    //   expect(result, 6);
    //   expect(result, 6);
    // });

    //wouldn't a typed version of this be nice!  it's not possible though
    // test("", () {
    //   var result = C(6) >> addOne >> addOne;
    //   expect(result, "8");
    // });
  });
}

TResult Function(T2) Function(T1) C2<T1, T2, TResult>(TResult Function(T1, T2) function) {
  return (T1 a) => (T2 b) => function(a, b);
}
