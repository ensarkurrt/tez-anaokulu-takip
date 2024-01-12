enum AnalyticEvents {
  onboarding$Page,
  onboardingRegisterButton,
  onboardingLoginButton,
  onboardingSwipe,
}

extension AnalyticEventExtentions on AnalyticEvents {
  String eventName({String? extra, List<String>? replace}) {
    String eventName = name.split('').map((element) {
      if (element == '\$' && (replace != null && replace.isNotEmpty)) {
        String rep = replace[0];
        replace.removeAt(0);
        return '_$rep';
      }

      if (element == element.toUpperCase()) {
        return '_${element.toLowerCase()}';
      } else {
        return element;
      }
    }).join();
    /* For adding platform name */
    if (extra != null) eventName += '_$extra';

    return eventName;
  }
}
