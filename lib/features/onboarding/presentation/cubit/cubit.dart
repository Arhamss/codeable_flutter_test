import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codeable_flutter_test/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:codeable_flutter_test/features/onboarding/presentation/cubit/state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.repository})
      : super(const OnboardingState());

  final OnboardingRepository repository;

  // TODO(codeable): Add cubit methods (login, register, etc.)
}
