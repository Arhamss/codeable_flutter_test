import 'package:codeable_flutter_test/exports.dart';

/// Reusable section title widget with consistent styling
class CustomSectionTitle extends StatelessWidget {
  const CustomSectionTitle({
    required this.title,
    this.padding,
    this.bottomSpacing,
    super.key,
  });

  final String title;
  final EdgeInsets? padding;
  final double? bottomSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: context.h4Medium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: bottomSpacing ?? 16),
      ],
    );
  }
}
