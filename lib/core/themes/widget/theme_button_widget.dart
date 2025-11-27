// 2. Theme Switcher Widget (3 Buttons Style)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcherButtons extends StatelessWidget {
  const ThemeSwitcherButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Settings',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ThemeButton(
                      label: 'Light',
                      icon: Icons.light_mode,
                      isSelected: themeProvider.isLightMode,
                      onTap: () => themeProvider.setLightMode(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ThemeButton(
                      label: 'Dark',
                      icon: Icons.dark_mode,
                      isSelected: themeProvider.isDarkMode,
                      onTap: () => themeProvider.setDarkMode(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ThemeButton(
                      label: 'System',
                      icon: Icons.brightness_auto,
                      isSelected: themeProvider.isSystemMode,
                      onTap: () => themeProvider.setSystemMode(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// 3. Individual Theme Button Widget
class _ThemeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? theme.primaryColor : theme.dividerColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? theme.primaryColor
                    : theme.textTheme.bodyLarge?.color,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? theme.primaryColor
                      : theme.textTheme.bodyLarge?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 4. Alternative: Segmented Button Style (iOS-like)
class ThemeSwitcherSegmented extends StatelessWidget {
  const ThemeSwitcherSegmented({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: 'Theme Settings for Testing Purpose',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _SegmentedButton(
                        label: 'Light',
                        icon: Icons.light_mode,
                        isSelected: themeProvider.isLightMode,
                        onTap: () => themeProvider.setLightMode(),
                        isFirst: true,
                      ),
                    ),
                    Expanded(
                      child: _SegmentedButton(
                        label: 'Dark',
                        icon: Icons.dark_mode,
                        isSelected: themeProvider.isDarkMode,
                        onTap: () => themeProvider.setDarkMode(),
                      ),
                    ),
                    Expanded(
                      child: _SegmentedButton(
                        label: 'System',
                        icon: Icons.brightness_auto,
                        isSelected: themeProvider.isSystemMode,
                        onTap: () => themeProvider.setSystemMode(),
                        isLast: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SegmentedButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const _SegmentedButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.horizontal(
          left: isFirst ? const Radius.circular(12) : Radius.zero,
          right: isLast ? const Radius.circular(12) : Radius.zero,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: isFirst ? const Radius.circular(12) : Radius.zero,
              right: isLast ? const Radius.circular(12) : Radius.zero,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : theme.textTheme.bodyLarge?.color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : theme.textTheme.bodyLarge?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
