import 'package:buddy/domain/enums/enums.dart';
import 'package:flutter/material.dart';

class Assets {
  const Assets._();

  static String svgsBasePath = 'assets/svgs';
  static String gifsBasePath = 'assets/gifs';
  static String imagesBasePath = 'assets/images';

  static String getSvgPath(String name) => '$svgsBasePath/$name';
  static String getGifPath(String name) => '$gifsBasePath/$name';
  static String getImagePath(String name) => '$imagesBasePath/$name';

  static String translateAppLanguageType(AppLanguageType language) {
    switch (language) {
      case AppLanguageType.english:
        return 'English';
      default:
        throw Exception('The provided app language type = $language is not valid');
    }
  }

  static String translateAutoThemeModeType(AutoThemeModeType type) {
    switch (type) {
      case AutoThemeModeType.on:
        return 'Follow OS setting';
      case AutoThemeModeType.off:
        return 'Off';
      default:
        throw Exception('Invalid auto theme mode type = $type');
    }
  }

  static AppThemeType translateThemeTypeBool(bool value) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
      default:
        throw Exception('Unknown error occurred');
    }
  }

  static String translateSportTypeToString(SportType type) {
    switch (type) {
      case SportType.surfing:
        return 'Surfing';
      case SportType.athletics:
        return 'Athletics';
      case SportType.snowboarding:
        return 'Snowboarding';
      case SportType.cycling:
        return 'Cycling';
      case SportType.americanFootball:
        return 'American Football';
      case SportType.formulaOne:
        return 'Motorsports';
      case SportType.baseball:
        return 'Baseball';
      case SportType.boxing:
        return 'Boxing';
      case SportType.rugby:
        return 'Rugby';
      case SportType.volleyball:
        return 'Volleyball';
      case SportType.hockey:
        return 'Hockey';
      case SportType.tennis:
        return 'Tennis';
      case SportType.golf:
        return 'Golf';
      case SportType.cricket:
        return 'Cricket';
      case SportType.basketball:
        return 'Basketball';
      case SportType.football:
        return 'Football';
      default:
        throw Exception('Invalid sport type = $type');
    }
  }

  static IconData translateSportTypeToIcon(SportType type) {
    switch (type) {
      case SportType.surfing:
        return Icons.surfing_rounded;
      case SportType.athletics:
        return Icons.sports_gymnastics_rounded;
      case SportType.snowboarding:
        return Icons.snowboarding_rounded;
      case SportType.cycling:
        return Icons.directions_bike_rounded;
      case SportType.americanFootball:
        return Icons.sports_football_rounded;
      case SportType.formulaOne:
        return Icons.sports_motorsports_rounded;
      case SportType.baseball:
        return Icons.sports_baseball_rounded;
      case SportType.boxing:
        return Icons.sports_mma_rounded;
      case SportType.rugby:
        return Icons.sports_rugby_rounded;
      case SportType.volleyball:
        return Icons.sports_handball_rounded;
      case SportType.hockey:
        return Icons.sports_hockey_rounded;
      case SportType.tennis:
        return Icons.sports_tennis_rounded;
      case SportType.golf:
        return Icons.golf_course_rounded;
      case SportType.cricket:
        return Icons.sports_cricket_rounded;
      case SportType.basketball:
        return Icons.sports_basketball_rounded;
      case SportType.football:
        return Icons.sports_soccer_rounded;
      default:
        throw Exception('Invalid sport type = $type');
    }
  }
}
