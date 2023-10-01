import 'package:flutter_application_1/counter_state.dart';
import 'package:flutter_application_1/counter_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CounterStore sut;
  
  setUp(() {
    sut = CounterStore();
  });

  group('CounterStore', () {
    test('should start with SuccessCounterState(0)', () async {
      // Arrange
      // Act
      // Assert
      expect(sut.state, const SuccessCounterState(value: 0));
    });

    test('should change to LoadingCounterState and SuccessCounterState(1) after increment', () async {
      // Arrange
      loadingStateVerifying() {
        expect(sut.state, LoadingCounterState());
      }
      successStateVerifying() {
        expect(sut.state, const SuccessCounterState(value: 1));
      }
      sut.addListener(loadingStateVerifying);
      // Act
      // Assert
      final future = sut.increment();
      sut.removeListener(loadingStateVerifying);
      sut.addListener(successStateVerifying);
      await future;
    });

    test('should change to LoadingCounterState and SuccessCounterState(0) after decrement', () async {
      // Arrange
      await sut.increment();
      loadingStateVerifying() {
        expect(sut.state, LoadingCounterState());
      }
      successStateVerifying() {
        expect(sut.state, const SuccessCounterState(value: 0));
      }
      sut.addListener(loadingStateVerifying);
      // Act
      // Assert
      expect(sut.state, const SuccessCounterState(value: 1));
      final future = sut.decrement();
      sut.removeListener(loadingStateVerifying);
      sut.addListener(successStateVerifying);
      await future;
    });

    test('should change to ErrorCounterState after decrement', () async {
      // Arrange
      errorStateVerifying() {
        expect(sut.state, const ErrorCounterState(description: 'Numero negativo não permitido'));
      }
      // Act
      // Assert
      expect(sut.state, const SuccessCounterState(value: 0));
      sut.addListener(errorStateVerifying);
      await sut.decrement();
    });

    test('should change to SuccessCounterState(0) after increment', () async {
      // Arrange
      await sut.decrement();
      successStateVerifying() {
        expect(sut.state, const SuccessCounterState(value: 0));
      }
      // Act
      // Assert
      expect(sut.state, const ErrorCounterState(description: 'Numero negativo não permitido'));
      sut.addListener(successStateVerifying);
      await sut.increment();
    });
  });
}