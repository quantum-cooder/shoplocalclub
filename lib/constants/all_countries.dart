class AllCountries {
  static List<String> list = [
    'United Kingdom',
    'USA',
    'Canada',
    'Australia',
    // 'India',
    // 'New Zealand',
    // 'Norway',
    // 'South Africa',
    // 'Zimbabwe'
  ];
  static int getCounrtyId(String countryName) {
    List<String> countries = AllCountries.list;
    int index = countries.indexOf(countryName) + 1;

    ///if user doesn't selects country then UK will be assigned
    if (index <= 0) {
      return 1;
    }
    return index;
  }

  static String getCountryById(int id) {
    if (id <= 0) {
      return 'United Kingdom';
    }

    return AllCountries.list.elementAt(id);
  }
}
