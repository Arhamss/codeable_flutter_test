import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:codeable_flutter_test/app/view/app_view.dart';
import 'package:codeable_flutter_test/core/locale/cubit/locale_cubit.dart';
import 'package:codeable_flutter_test/exports.dart';
import 'package:codeable_flutter_test/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:codeable_flutter_test/features/onboarding/presentation/cubit/cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocaleCubit(context: context),
          ),
          BlocProvider(
            create: (context) => OnboardingCubit(
              repository: OnboardingRepositoryImpl(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
