import 'package:equatable/equatable.dart';

class NoConnectionFailure {
  const NoConnectionFailure();
}

class WeatherFailure extends Equatable {
  final String message;
  final String error;

  const WeatherFailure({
    required this.message,
    required this.error,
  });

  @override
  List<Object?> get props => [message, error];
}
