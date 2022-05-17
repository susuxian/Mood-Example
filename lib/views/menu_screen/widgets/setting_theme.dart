import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/theme/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/db/preferences_db.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 主题设置
class SettingTheme extends StatefulWidget {
  const SettingTheme({Key? key}) : super(key: key);

  @override
  _SettingThemeState createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 主题外观设置
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            S.of(context).app_setting_theme_appearance,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),

        const DarkThemeBody(),
        SizedBox(height: 48.w),

        /// 多主题设置-可浅色、深色模式独立配色方案
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            "多主题",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),

        const MultipleThemesBody(),
        SizedBox(height: 48.w)
      ],
    );
  }
}

/// 主题外观设置
class DarkThemeBody extends StatefulWidget {
  const DarkThemeBody({Key? key}) : super(key: key);

  @override
  State<DarkThemeBody> createState() => _DarkThemeBodyState();
}

class _DarkThemeBodyState extends State<DarkThemeBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        final _themeMode = applicationViewModel.themeMode;
        return Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          runSpacing: 16.w,
          spacing: 16.w,
          children: [
            DarkThemeCard(
              title: S.of(context).app_setting_theme_appearance_system,
              selected: _themeMode == ThemeMode.system,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDarkMode(context)
                              ? [
                                  const Color(0xFFF6F8FA),
                                  const Color(0xFFF6F8FA)
                                ]
                              : [
                                  const Color(0xFF111315),
                                  const Color(0xFF111315)
                                ],
                        ),
                      ),
                      child: Text(
                        "Aa",
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.black87
                              : const Color(0xFFEFEFEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDarkMode(context)
                              ? [
                                  const Color(0xFF111315),
                                  const Color(0xFF111315)
                                ]
                              : [
                                  const Color(0xFFF6F8FA),
                                  const Color(0xFFF6F8FA)
                                ],
                        ),
                      ),
                      child: Text(
                        "Aa",
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? const Color(0xFFEFEFEF)
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () async {
                print("跟随系统");
                await PreferencesDB().setAppThemeDarkMode(context, "system");
              },
            ),
            DarkThemeCard(
              title: S.of(context).app_setting_theme_appearance_light,
              selected: _themeMode == ThemeMode.light,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF6F8FA), Color(0xFFF6F8FA)],
                  ),
                ),
                child: Text(
                  "Aa",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              onTap: () async {
                print("普通模式");
                await PreferencesDB().setAppThemeDarkMode(context, "light");
              },
            ),
            DarkThemeCard(
              title: S.of(context).app_setting_theme_appearance_dark,
              selected: _themeMode == ThemeMode.dark,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF111315), Color(0xFF111315)],
                  ),
                ),
                child: Text(
                  "Aa",
                  style: TextStyle(
                    color: const Color(0xFFEFEFEF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              onTap: () async {
                print("深色模式");
                await PreferencesDB().setAppThemeDarkMode(context, "dark");
              },
            ),
          ],
        );
      },
    );
  }
}

/// 多主题设置
class MultipleThemesBody extends StatefulWidget {
  const MultipleThemesBody({Key? key}) : super(key: key);

  @override
  State<MultipleThemesBody> createState() => _MultipleThemesBodyState();
}

class _MultipleThemesBodyState extends State<MultipleThemesBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        final _multipleThemesMode = applicationViewModel.multipleThemesMode;
        return Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            runSpacing: 16.w,
            spacing: 16.w,
            children: [
              MultipleThemesCard(
                selected: _multipleThemesMode == "default",
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3e4663), Color(0xFF3e4663)],
                    ),
                  ),
                ),
                onTap: () async {
                  print("default");
                  await PreferencesDB()
                      .setMultipleThemesMode(context, "default");
                },
              ),
              MultipleThemesCard(
                selected: _multipleThemesMode == "teal",
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.teal],
                    ),
                  ),
                ),
                onTap: () async {
                  print("teal");
                  await PreferencesDB().setMultipleThemesMode(context, "teal");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 深色模式卡片
class MultipleThemesCard extends StatelessWidget {
  /// 卡片内容
  final Widget? child;

  /// 是否选中
  final bool? selected;

  /// 点击触发
  final Function()? onTap;

  const MultipleThemesCard({
    Key? key,
    this.child,
    this.selected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return InkWell(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: _selected
                      ? Border.all(
                          width: 3.w,
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        )
                      : Border.all(
                          width: 3.w,
                          color: isDarkMode(context)
                              ? Colors.white12
                              : Colors.black12,
                        ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: child,
                ),
              ),
              Builder(
                builder: (_) {
                  if (!_selected) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w, bottom: 12.w),
                    child: Icon(
                      Remix.checkbox_circle_fill,
                      size: 20.sp,
                      color: isDarkMode(context) ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

/// 深色模式卡片
class DarkThemeCard extends StatelessWidget {
  /// 卡片内容
  final Widget? child;

  /// 卡片标题
  final String? title;

  /// 是否选中
  final bool? selected;

  /// 点击触发
  final Function()? onTap;

  const DarkThemeCard({
    Key? key,
    this.child,
    this.title,
    this.selected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return InkWell(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                width: 100.w,
                height: 72.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.w),
                  border: _selected
                      ? Border.all(
                          width: 3.w,
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        )
                      : Border.all(
                          width: 3.w,
                          color: isDarkMode(context)
                              ? Colors.white12
                              : Colors.black12,
                        ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.w),
                  child: child,
                ),
              ),
              Builder(
                builder: (_) {
                  if (!_selected) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w, bottom: 8.w),
                    child: Icon(
                      Remix.checkbox_circle_fill,
                      size: 20.sp,
                      color: isDarkMode(context) ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.w),
            child: Text(
              title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
