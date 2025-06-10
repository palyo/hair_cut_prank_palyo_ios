class Language {
  String? code;
  String? title;
  String? icon;

  Language({this.code, this.title, this.icon});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    data['icon'] = icon;
    return data;
  }
}

List<Language> languages = [
  Language(code: "en", title: "English", icon: "assets/flag/ic_language_english.webp"),
  Language(code: "de", title: "German / Deutsch", icon: "assets/flag/ic_language_german.webp"),
  Language(code: "fr", title: "French / Français", icon: "assets/flag/ic_language_france.webp"),
  Language(code: "ar", title: "Arabic / العربية", icon: "assets/flag/ic_language_arab.webp"),
  Language(code: "ja", title: "Japanese / 日本語", icon: "assets/flag/ic_language_japan.webp"),
  Language(code: "es", title: "Spanish / Española", icon: "assets/flag/ic_language_spanish.webp"),
  Language(
    code: "in",
    title: "Indonesian / bahasa Indonesia",
    icon: "assets/flag/ic_language_indonesian.webp",
  ),
  Language(code: "af", title: "African / Afrikaans", icon: "assets/flag/ic_language_african.webp"),
  Language(
    code: "pt",
    title: "Portuguese / Português",
    icon: "assets/flag/ic_language_portugal.webp",
  ),
];
