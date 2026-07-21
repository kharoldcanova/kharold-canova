import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String activeSection;
  final ValueChanged<String> onSectionTap;

  const HeaderWidget({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    if (isSmallScreen) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: colorScheme.onSurface),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: colorScheme.onSurface,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      title: DefaultTextStyle(
        style: GoogleFonts.poppins(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        child: Row(
          children: [
            _NavLink(
              label: t.home,
              isActive: activeSection == 'home',
              onTap: () => onSectionTap('home'),
            ),
            const SizedBox(width: 12),
            _NavLink(
              label: t.projects,
              isActive: activeSection == 'projects',
              onTap: () => onSectionTap('projects'),
            ),
            const SizedBox(width: 12),
            _NavLink(
              label: t.about,
              isActive: activeSection == 'about',
              onTap: () => onSectionTap('about'),
            ),
            const SizedBox(width: 12),
            _NavLink(
              label: t.contact,
              isActive: activeSection == 'contact',
              onTap: () => onSectionTap('contact'),
            ),
            const Spacer(),
            IconButton(
              icon:
                  Icon(Icons.translate, color: colorScheme.onSurface, size: 24),
              onPressed: () {
                final bloc = context.read<LanguageBloc>();
                final current = bloc.state.selectedLanguage;
                bloc.add(ChangeLanguage(
                  selectedLanguage: current == Language.english
                      ? Language.spanish
                      : Language.english,
                ));
              },
              tooltip: 'Toggle language',
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () => onSectionTap('contact'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: Text(t.contact_me, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: isActive
              ? BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
