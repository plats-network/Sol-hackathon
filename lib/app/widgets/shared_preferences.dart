import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class LocalStorageKey {
  static const String historySearch = "history_search";
}

Future<void> saveToRecentSearches(
    {String? searchValue, bool isCleanData = false}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> currentSearches =
      prefs.getStringList(LocalStorageKey.historySearch) ?? [];
  currentSearches.insert(0, searchValue ?? '');
  isCleanData
      ? await prefs.setStringList(LocalStorageKey.historySearch, [])
      : await prefs.setStringList(
          LocalStorageKey.historySearch, currentSearches);
}

Future<List<String>> getStringList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> stringList =
      prefs.getStringList(LocalStorageKey.historySearch) ?? [];

  return stringList;
}
