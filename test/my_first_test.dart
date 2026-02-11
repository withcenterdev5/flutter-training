import 'package:flutter_test/flutter_test.dart';

void main(){
  //group multiple tests together
  group("Math is real", (){
    test("addition should work", (){
      // Setup (Arrange)
      var answer = 0;

      //Do something (Act)
      answer = 1 + 1;

      //Check the result (Assert)
      expect(answer, 2);
    });
  });
}