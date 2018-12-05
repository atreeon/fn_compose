import 'package:fn_compose/Compose.dart';
import 'package:test/test.dart';

var addOne = (int x) => x + 1;
var stringifyIt = (int x) => x.toString();

void main() {
  group("ComposeFn", () {
    test("1", () {
      var result = C(5).x(addOne).execute();
      expect(result, 6);
    });

    test("2", () {
      var result = C(6).x(addOne).x(addOne).execute();
      expect(result, 8);
    });

    test("3", () {
      var result = C(6).x(addOne).x(addOne).x(stringifyIt).execute();
      expect(result, "8");
    });

    // test("4", () {
    //   var result = C(6) >> addOne >> addOne;
    //   expect(result, "8");
    // });
  });
}
