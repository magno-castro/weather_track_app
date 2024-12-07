import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/core/network/network_info.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late MockInternetConnection mockInternetConnection;
  late NetworkInfo networkInfo;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfo(connection: mockInternetConnection);
  });

  tearDown(() {
    reset(mockInternetConnection);
  });

  group('Network info =>', () {
    test('should return true when there is internet access', () async {
      when(() => mockInternetConnection.hasInternetAccess)
          .thenAnswer((_) async => true);

      final result = await networkInfo.isConnected;

      expect(result, true);
      verify(() => mockInternetConnection.hasInternetAccess).called(1);
    });

    test('should return false when there is no internet access', () async {
      when(() => mockInternetConnection.hasInternetAccess)
          .thenAnswer((_) async => false);

      final result = await networkInfo.isConnected;

      expect(result, false);
      verify(() => mockInternetConnection.hasInternetAccess).called(1);
    });
  });
}
