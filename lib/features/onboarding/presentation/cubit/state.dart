import 'package:equatable/equatable.dart';
import 'package:codeable_flutter_test/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.login = const DataState.initial(),
  });

  final DataState<bool> login;

  OnboardingState copyWith({
    DataState<bool>? login,
  }) {
    return OnboardingState(
      login: login ?? this.login,
    );
  }

  @override
  List<Object?> get props => [login];
}
