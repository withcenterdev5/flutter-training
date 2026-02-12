import 'package:flutter_test/flutter_test.dart';
import 'package:counter/models/counter_model.dart';


void main(){
  group("CounterModel", (){
    late CounterModel model;

    setUp(() {
      model = CounterModel();
    });

    test('initial count is 4', () {
      expect(model.count, 4);
    });

    test('increment increases count by 1', () {
      model.increment();
      expect(model.count, 5);
    });

    test('decrement decreases count by 1', () {
      model.decrement();
      expect(model.count, 3);
    });

    test('incrementByAmount increases count by given value', () {
      model.incrementByAmount(5);
      expect(model.count, 9);
    });

    test('reset sets count to 0', () {
      model.increment();
      model.reset();
      expect(model.count, 0);
    });

  });
}