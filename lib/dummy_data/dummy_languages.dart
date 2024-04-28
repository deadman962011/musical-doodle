class Language {
  int id;
  String name;
  String image;
  String code;
  String mobile_app_code;
  bool rtl;
  bool is_default;


  
  Language({
    required this.id,
    required this.name,
    required this.image,
    required this.code,
    required this.mobile_app_code,
    required this.rtl,
    required this.is_default,
  });


}

  final List<Language> dummy_languaes_list = [
    Language(
      id: 1,
      name: 'العربية',
      image: '',
      code: 'ar',
      mobile_app_code: 'ar',
      rtl: true,
      is_default: false,
    ),
    Language(
      id: 1,
      name: 'English',
      image: '',
      code: 'en',
      mobile_app_code: 'en',
      rtl: false,
      is_default: true,
    ),
  ];