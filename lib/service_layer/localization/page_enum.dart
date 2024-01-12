import '../../../service_layer/localization/localization.dart';
/*
enum LanguageLocalizationKeys { general, input, chatPage, subscriptionPage, settingsPage, popUp } */

enum generalPage {
  recommendsTitle,
  historyTitle,
  settingsTitle,
  createNewChat,
  chatTitle,
  historyNoDataMessage,
  messageCount,
  limitlessReach,
  anErrorOccurred,
  messageCopied,
  darkTheme,
  lightTheme,
}

enum inputPage {
  writeMessage,
}

enum chatPage {
  gpt3Message,
  gpt4Message,
  exportAsPdf,
  copyMessage,
  premiumLimitMessage,
  shareMessage,
  extendAnswer,
  shortenAnswer,
  regenerateAnswer,
  moreOptions,
  stopAnswer,
  continueAnswer,
  youTitle,
}

enum subscriptionPage {
  title,
  gpt4Title,
  gpt4Description,
  characterLimitTitle,
  characterLimitDescription,
  unlimitedMessagingTitle,
  unlimitedMessagingDescription,
  adFreeTitle,
  adFreeDescription,
  discount,
  privacyPolicy,
  termsOfService,
  recoverSubscription,
  cancelEverytime,
  startFreeTrial,
  continueButton,
  welcomeToPremium,
  noRecovers,
  offerCodeInvalid,
  offerCodeTitle,
  offerCodeDescription,
  offerCodePlaceholder,
  offerCodeButton,
  weeklySubscriptionPriceTitle,
  weeklySubscriptionPriceDescription,
  monthlySubscriptionPriceTitle,
  monthlySubscriptionPriceDescription,
  lifetimeSubscriptionPriceTitle,
  lifetimeSubscriptionPriceDescription,
}

enum popUp {
  subscriptionInfoTitle,
  subscriptionInfoDescription,
  subscriptionInfoButton,
  updateInfoTitle,
  updateInfoDescription,
  updateInfoButton,
  connectionErrorTitle,
  connectionErrorDescription,
  connectionErrorButton,
  clearHistoryTitle,
  clearHistoryDescription,
  clearHistoryPositiveButton,
  deleteChatTitle,
  deleteChatDescription,
  deleteChatPositiveButton,
  cancelButton
}

enum settingsPage {
  followOnTwitter,
  rateUs,
  writeUs,
  shareWithFriends,
  recoverSubscription,
  privacyPolicy,
  termsOfService,
  changeTheme,
}
/*
extension PageLocalization on LanguageLocalizationKeys {
  String locale(Enum keyEnum, {Map<String, dynamic>? replace}) {
    Logger.instance.log('LocalizationService.include.tr($snakeCase, ${keyEnum.snakeCase})');
    String result = LocalizationService.include.tr(snakeCase, keyEnum.snakeCase);

    if (replace != null) {
      replace.forEach((key, value) {
        result = result.replaceAll('{$key}', value.toString());
      });
    }
    return result;
  }
} */

extension PageLocalizationConverter on Enum {
  String get snakeCase => name.split('').map((element) {
        if (element == element.toUpperCase()) {
          return '_${element.toLowerCase()}';
        } else {
          return element;
        }
      }).join();

  String Function({Map<String, dynamic>? replace}) get tr => ({replace}) {
        String pageKey = toString().split('.').first.snakeCase;
        String keyEnum = toString().split('.').last.snakeCase;
        String result = LocalizationService.include.tr(pageKey, keyEnum);
        if (replace != null) {
          replace.forEach((key, value) {
            result = result.replaceAll('{$key}', value.toString());
          });
        }
        return result;
      };
}

extension StringExtentions on String {
  String get snakeCase => split('').map((element) {
        if (element == '') return '';
        if (element == element.toUpperCase()) {
          return '_${element.toLowerCase()}';
        } else {
          return element;
        }
      }).join();
}
