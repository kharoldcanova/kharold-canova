import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class PresentationSlide extends StatelessWidget {
  const PresentationSlide({
    super.key,
    required this.child,
    required this.index,
    required this.count,
    required this.onPrevious,
    required this.onNext,
    required this.onClose,
  });

  final Widget child;
  final int index;
  final int count;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final canvasWidth =
        (MediaQuery.sizeOf(context).width - BrandTheme.space2XL).clamp(
      320.0,
      BrandTheme.contentMaxWidth,
    );
    return Material(
      color: colors.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: BrandTheme.spaceMD),
              child: Row(
                children: [
                  IconButton(
                    tooltip: t.presentation_close,
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                  const Spacer(),
                  Semantics(
                    liveRegion: true,
                    label: '${index + 1} / $count',
                    child: Text('${index + 1} / $count'),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: t.presentation_previous,
                    onPressed: index == 0 ? null : onPrevious,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    tooltip: t.presentation_next,
                    onPressed: index == count - 1 ? null : onNext,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(BrandTheme.spaceMD),
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: canvasWidth,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
