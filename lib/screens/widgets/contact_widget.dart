import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/availability_pill.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:url_launcher/url_launcher.dart';

/// Contact (DESIGN.md 2.5): blue block in light mode, elevated neutral in
/// dark. Message on the left, channels on the right; stacked below 860px.
class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final tokens = theme.extension<PortfolioTokens>()!;
    final fg = isDark ? colorScheme.onSurface : colorScheme.onPrimary;
    final background = isDark ? tokens.elevated : colorScheme.primary;
    final line = fg.withValues(alpha: isDark ? 0.16 : 0.3);
    final repo = PortfolioRepository();

    final message = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvailabilityPill(
          key: const Key('contact-availability'),
          foreground: fg,
          border: line,
        ),
        const SizedBox(height: BrandTheme.spaceMD),
        Text(
          t.contact_title,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.8,
            height: 1.1,
            color: fg,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            t.contact_text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: fg.withValues(alpha: 0.86),
              height: 1.6,
            ),
          ),
        ),
      ],
    );

    final channels = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EmailRow(email: repo.getEmail(), fg: fg, line: line),
        const SizedBox(height: 10),
        _LinkRow(
          key: const Key('contact-linkedin'),
          label: 'LinkedIn',
          value: repo.getLinkedin().replaceFirst('https://', ''),
          url: repo.getLinkedin(),
          fg: fg,
          line: line,
        ),
        const SizedBox(height: 10),
        _LinkRow(
          key: const Key('contact-github'),
          label: 'GitHub',
          value: repo.getGithub().replaceFirst('https://', ''),
          url: repo.getGithub(),
          fg: fg,
          line: line,
        ),
        const SizedBox(height: BrandTheme.spaceSM),
        Text(
          t.contact_meta,
          key: const Key('contact-meta'),
          style: theme.textTheme.bodySmall?.copyWith(
            color: fg.withValues(alpha: 0.7),
          ),
        ),
      ],
    );

    return SectionContainer(
      background: background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 860) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [message, const SizedBox(height: 28), channels],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: message),
              const SizedBox(width: BrandTheme.space2XL),
              Expanded(flex: 5, child: channels),
            ],
          );
        },
      ),
    );
  }
}

class _RowShell extends StatelessWidget {
  const _RowShell({
    required this.label,
    required this.value,
    required this.trailing,
    required this.fg,
    required this.line,
    this.selectable = false,
  });

  final String label;
  final String value;
  final Widget trailing;
  final bool selectable;
  final Color fg;
  final Color line;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: line),
        borderRadius: BorderRadius.circular(BrandTheme.radius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall
                      ?.copyWith(color: fg.withValues(alpha: 0.7)),
                ),
                if (selectable)
                  SelectableText(
                    value,
                    style: textTheme.titleSmall?.copyWith(color: fg),
                  )
                else
                  Text(
                    value,
                    style: textTheme.titleSmall?.copyWith(color: fg),
                  ),
              ],
            ),
          ),
          const SizedBox(width: BrandTheme.spaceSM),
          trailing,
        ],
      ),
    );
  }
}

class _EmailRow extends StatelessWidget {
  const _EmailRow({required this.email, required this.fg, required this.line});

  final String email;
  final Color fg;
  final Color line;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return _RowShell(
      label: t.email,
      value: email,
      selectable: true,
      fg: fg,
      line: line,
      trailing: OutlinedButton(
        key: const Key('contact-copy-email'),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: email));
          if (!context.mounted) return;
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(content: Text(t.email_copied)),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(color: line),
          minimumSize: const Size(0, 34),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          textStyle: const TextStyle(fontSize: 13),
        ),
        child: Text(t.copy_email),
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({
    super.key,
    required this.label,
    required this.value,
    required this.url,
    required this.fg,
    required this.line,
  });

  final String label;
  final String value;
  final String url;
  final Color fg;
  final Color line;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(BrandTheme.radius),
      onTap: () => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      ),
      child: _RowShell(
        label: label,
        value: value,
        fg: fg,
        line: line,
        trailing: Icon(Icons.arrow_outward, size: 18, color: fg),
      ),
    );
  }
}
