import 'package:device_preview/device_preview.dart';
import 'package:codeable_flutter_test/app/view/app_page.dart';
import 'package:codeable_flutter_test/bootstrap.dart';
import 'package:codeable_flutter_test/config/flavor_config.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.development);
  await bootstrap(
    () => DevicePreview(
      enabled: false,
      builder: (context) {
        return const App();
      },
    ),
  );
}
