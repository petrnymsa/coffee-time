import 'package:coffee_time/core/cached_value.dart';
import 'package:coffee_time/core/time_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTimeProvider extends Mock implements TimeProvider {}

void main() {
  MockTimeProvider timeProvider;

  int callCount = 0;

  setUp(() {
    timeProvider = MockTimeProvider();
    callCount = 0;
  });

  Future<int> onExpire() async {
    callCount++;
    return 1;
  }

  test('should call onExpire for first get', () async {
    final onExpireCallBack = onExpire;
    final value = CachedValue<int>(onExpireCallBack,
        timeProvider: timeProvider, durability: Duration(minutes: 1));

    final result = await value.get();

    expect(callCount, 1);
    expect(result, 1);
  });

  test('should call onExpire after expire', () async {
    final onExpireCallBack = onExpire;
    final now = DateTime.now();
    when(timeProvider.now()).thenReturn(now);

    final value = CachedValue<int>(onExpireCallBack,
        timeProvider: timeProvider, durability: Duration(minutes: 1));

    final result = await value.get();

    expect(callCount, 1);
    expect(result, 1);

    await value.get();
    expect(callCount, 1);

    when(timeProvider.now()).thenReturn(now.add(Duration(minutes: 2)));

    await value.get();
    expect(callCount, 2);
    await value.get();
    expect(callCount, 2);
  });
}
