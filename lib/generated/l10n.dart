// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get main_screen_bottom_navigation_home {
    return Intl.message(
      'Home',
      name: 'main_screen_bottom_navigation_home',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get main_screen_bottom_navigation_wallet {
    return Intl.message(
      'Wallet',
      name: 'main_screen_bottom_navigation_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get main_screen_bottom_navigation_scan {
    return Intl.message(
      'Scan',
      name: 'main_screen_bottom_navigation_scan',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get main_screen_bottom_navigation_profile {
    return Intl.message(
      'Profile',
      name: 'main_screen_bottom_navigation_profile',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get main_screen_bottom_navigation_more {
    return Intl.message(
      'More',
      name: 'main_screen_bottom_navigation_more',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_b {
    return Intl.message(
      'Continue',
      name: 'continue_b',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Do you want close the app?`
  String get home_screen_close_app {
    return Intl.message(
      'Do you want close the app?',
      name: 'home_screen_close_app',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `dark`
  String get dark {
    return Intl.message(
      'dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `white`
  String get white {
    return Intl.message(
      'white',
      name: 'white',
      desc: '',
      args: [],
    );
  }

  /// `system default`
  String get system_default {
    return Intl.message(
      'system default',
      name: 'system_default',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue`
  String get please_login_to_continue {
    return Intl.message(
      'Please login to continue',
      name: 'please_login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `by clicking continue you are agreeing to the `
  String get by_clicking_continue_you_are {
    return Intl.message(
      'by clicking continue you are agreeing to the ',
      name: 'by_clicking_continue_you_are',
      desc: '',
      args: [],
    );
  }

  /// `terms and conditions`
  String get terms_conditions {
    return Intl.message(
      'terms and conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `no need to remember your password We'll send you a magic link`
  String get no_need_to_remember_your_password {
    return Intl.message(
      'no need to remember your password We`ll send you a magic link',
      name: 'no_need_to_remember_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Maybe Later`
  String get maybe_later {
    return Intl.message(
      'Maybe Later',
      name: 'maybe_later',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Login`
  String get merchant_login {
    return Intl.message(
      'Merchant Login',
      name: 'merchant_login',
      desc: '',
      args: [],
    );
  }

  /// `Client Login`
  String get client_login {
    return Intl.message(
      'Client Login',
      name: 'client_login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `please enter your informations to continue`
  String get please_enter_your_informations_to_continue {
    return Intl.message(
      'please enter your informations to continue',
      name: 'please_enter_your_informations_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `first name`
  String get firstname {
    return Intl.message(
      'first name',
      name: 'firstname',
      desc: '',
      args: [],
    );
  }

  /// `last name`
  String get lastname {
    return Intl.message(
      'last name',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `birth date`
  String get birthDate {
    return Intl.message(
      'birth date',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `referral code (optional)`
  String get referral_code {
    return Intl.message(
      'referral code (optional)',
      name: 'referral_code',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get check_your_email {
    return Intl.message(
      'Check your email',
      name: 'check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `We sent you a confirmation email`
  String get we_sent_you_confirmatin_email {
    return Intl.message(
      'We sent you a confirmation email',
      name: 'we_sent_you_confirmatin_email',
      desc: '',
      args: [],
    );
  }

  /// `Resend email`
  String get resend_email {
    return Intl.message(
      'Resend email',
      name: 'resend_email',
      desc: '',
      args: [],
    );
  }

  /// `Didnt recive the email ?  `
  String get didnt_recive_email {
    return Intl.message(
      'Didnt recive the email ?  ',
      name: 'didnt_recive_email',
      desc: '',
      args: [],
    );
  }

  /// `Open Email`
  String get open_email {
    return Intl.message(
      'Open Email',
      name: 'open_email',
      desc: '',
      args: [],
    );
  }

  /// `shop name`
  String get shop_name {
    return Intl.message(
      'shop name',
      name: 'shop_name',
      desc: '',
      args: [],
    );
  }

  /// `select category`
  String get select_category {
    return Intl.message(
      'select category',
      name: 'select_category',
      desc: '',
      args: [],
    );
  }

  /// `tax register`
  String get tex_register {
    return Intl.message(
      'tax register',
      name: 'tex_register',
      desc: '',
      args: [],
    );
  }

  /// `address`
  String get address {
    return Intl.message(
      'address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `shop admin name`
  String get shop_admin_name {
    return Intl.message(
      'shop admin name',
      name: 'shop_admin_name',
      desc: '',
      args: [],
    );
  }

  /// `shop admin phone`
  String get shop_admin_phone {
    return Intl.message(
      'shop admin phone',
      name: 'shop_admin_phone',
      desc: '',
      args: [],
    );
  }

  /// `select location`
  String get select_location {
    return Intl.message(
      'select location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Registraion Completed`
  String get merchant_registration_completed {
    return Intl.message(
      'Merchant Registraion Completed',
      name: 'merchant_registration_completed',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Registration request is under review ,You will be notified soon`
  String get merchant_registran_request_pending {
    return Intl.message(
      'Merchant Registration request is under review ,You will be notified soon',
      name: 'merchant_registran_request_pending',
      desc: '',
      args: [],
    );
  }

  /// `Back To Main Page`
  String get back_to_main {
    return Intl.message(
      'Back To Main Page',
      name: 'back_to_main',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `statistics`
  String get statistics {
    return Intl.message(
      'statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Pay Commissions`
  String get pay_commissions {
    return Intl.message(
      'Pay Commissions',
      name: 'pay_commissions',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty program`
  String get loyalty_program {
    return Intl.message(
      'Loyalty program',
      name: 'loyalty_program',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Profile`
  String get upgrade_profile {
    return Intl.message(
      'Upgrade Profile',
      name: 'upgrade_profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `offer duration`
  String get offer_duration {
    return Intl.message(
      'offer duration',
      name: 'offer_duration',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Offer Name`
  String get offer_name {
    return Intl.message(
      'Offer Name',
      name: 'offer_name',
      desc: '',
      args: [],
    );
  }

  /// `Cashback Amount`
  String get cashback_amount {
    return Intl.message(
      'Cashback Amount',
      name: 'cashback_amount',
      desc: '',
      args: [],
    );
  }

  /// `I acknowledge that I will pay the commission for this offer + the customer cashback percentage to the MyBill application within a period not exceeding 3 business days from the date of the end of the offer.`
  String get i_acknowledge_that_i_will_pay {
    return Intl.message(
      'I acknowledge that I will pay the commission for this offer + the customer cashback percentage to the MyBill application within a period not exceeding 3 business days from the date of the end of the offer.',
      name: 'i_acknowledge_that_i_will_pay',
      desc: '',
      args: [],
    );
  }

  /// `of bill amount`
  String get of_bill_amount {
    return Intl.message(
      'of bill amount',
      name: 'of_bill_amount',
      desc: '',
      args: [],
    );
  }

  /// `Add New  Offer`
  String get add_offer {
    return Intl.message(
      'Add New  Offer',
      name: 'add_offer',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Application Commission`
  String get application_commission {
    return Intl.message(
      'Application Commission',
      name: 'application_commission',
      desc: '',
      args: [],
    );
  }

  /// `10/10/2023 10:14 PM`
  String get start_date_placeholder {
    return Intl.message(
      '10/10/2023 10:14 PM',
      name: 'start_date_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `10/10/2023 10:14 PM`
  String get end_date_placeholder {
    return Intl.message(
      '10/10/2023 10:14 PM',
      name: 'end_date_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `EX : lorem ipsum`
  String get offer_name_placeholder {
    return Intl.message(
      'EX : lorem ipsum',
      name: 'offer_name_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Select cashback amount`
  String get cashback_amount_placeholder {
    return Intl.message(
      'Select cashback amount',
      name: 'cashback_amount_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email address`
  String get please_check_your_email_inbox {
    return Intl.message(
      'Please check your email address',
      name: 'please_check_your_email_inbox',
      desc: '',
      args: [],
    );
  }

  /// `Cruise through`
  String get cruise_through {
    return Intl.message(
      'Cruise through',
      name: 'cruise_through',
      desc: '',
      args: [],
    );
  }

  /// `MyBill`
  String get mybill {
    return Intl.message(
      'MyBill',
      name: 'mybill',
      desc: '',
      args: [],
    );
  }

  /// `No Offers Found`
  String get no_offers_found {
    return Intl.message(
      'No Offers Found',
      name: 'no_offers_found',
      desc: '',
      args: [],
    );
  }

  /// `Unable to add new offer because you have pending offer`
  String get add_offer_has_pending_error {
    return Intl.message(
      'Unable to add new offer because you have pending offer',
      name: 'add_offer_has_pending_error',
      desc: '',
      args: [],
    );
  }

  /// `Unable to add new offer because you have active offer`
  String get add_offer_has_active_error {
    return Intl.message(
      'Unable to add new offer because you have active offer',
      name: 'add_offer_has_active_error',
      desc: '',
      args: [],
    );
  }

  /// `Unable to add new offer , you need to pay offer commissions`
  String get add_offer_has_pay_comission_error {
    return Intl.message(
      'Unable to add new offer , you need to pay offer commissions',
      name: 'add_offer_has_pay_comission_error',
      desc: '',
      args: [],
    );
  }

  /// `Pay Commission`
  String get pay_comission {
    return Intl.message(
      'Pay Commission',
      name: 'pay_comission',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Sorry`
  String get sorry {
    return Intl.message(
      'Sorry',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `No carousel image found`
  String get no_carousel_image_found {
    return Intl.message(
      'No carousel image found',
      name: 'no_carousel_image_found',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `My Codes`
  String get my_codes {
    return Intl.message(
      'My Codes',
      name: 'my_codes',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get bank_accounts {
    return Intl.message(
      'Bank Account',
      name: 'bank_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Invite Friends`
  String get invite_friends {
    return Intl.message(
      'Invite Friends',
      name: 'invite_friends',
      desc: '',
      args: [],
    );
  }

  /// `Delete My Account`
  String get delete_my_acc {
    return Intl.message(
      'Delete My Account',
      name: 'delete_my_acc',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get select_category_home {
    return Intl.message(
      'Select Category',
      name: 'select_category_home',
      desc: '',
      args: [],
    );
  }

  /// `Best Offers`
  String get best_offers {
    return Intl.message(
      'Best Offers',
      name: 'best_offers',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get left {
    return Intl.message(
      'Left',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `profile edit`
  String get profile_edit {
    return Intl.message(
      'profile edit',
      name: 'profile_edit',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `No favorites`
  String get no_favorites {
    return Intl.message(
      'No favorites',
      name: 'no_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Add Offer`
  String get add_offer_btn {
    return Intl.message(
      'Add Offer',
      name: 'add_offer_btn',
      desc: '',
      args: [],
    );
  }

  /// `Offer name in arabic`
  String get offer_name_in_ar {
    return Intl.message(
      'Offer name in arabic',
      name: 'offer_name_in_ar',
      desc: '',
      args: [],
    );
  }

  /// `Offer name in english`
  String get offer_name_in_en {
    return Intl.message(
      'Offer name in english',
      name: 'offer_name_in_en',
      desc: '',
      args: [],
    );
  }

  /// `Bill number`
  String get bill_number {
    return Intl.message(
      'Bill number',
      name: 'bill_number',
      desc: '',
      args: [],
    );
  }

  /// `Client name`
  String get client_name {
    return Intl.message(
      'Client name',
      name: 'client_name',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Un paid`
  String get unpaid {
    return Intl.message(
      'Un paid',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Cashback`
  String get cashback {
    return Intl.message(
      'Cashback',
      name: 'cashback',
      desc: '',
      args: [],
    );
  }

  /// `Comission`
  String get commission {
    return Intl.message(
      'Comission',
      name: 'commission',
      desc: '',
      args: [],
    );
  }

  /// `Total sales`
  String get total_sales {
    return Intl.message(
      'Total sales',
      name: 'total_sales',
      desc: '',
      args: [],
    );
  }

  /// `number of beneficiaries`
  String get offer_num_of_beneficiaries {
    return Intl.message(
      'number of beneficiaries',
      name: 'offer_num_of_beneficiaries',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get no_data {
    return Intl.message(
      'No Data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Add menu`
  String get add_menu {
    return Intl.message(
      'Add menu',
      name: 'add_menu',
      desc: '',
      args: [],
    );
  }

  /// `Working hours`
  String get working_hours {
    return Intl.message(
      'Working hours',
      name: 'working_hours',
      desc: '',
      args: [],
    );
  }

  /// `Contact informations`
  String get contact_informations {
    return Intl.message(
      'Contact informations',
      name: 'contact_informations',
      desc: '',
      args: [],
    );
  }

  /// `rating`
  String get rating {
    return Intl.message(
      'rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Bank name`
  String get bank_name {
    return Intl.message(
      'Bank name',
      name: 'bank_name',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Account number`
  String get account_number {
    return Intl.message(
      'Account number',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `IBAN `
  String get iban {
    return Intl.message(
      'IBAN ',
      name: 'iban',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Add new bank account`
  String get add_bank_account {
    return Intl.message(
      'Add new bank account',
      name: 'add_bank_account',
      desc: '',
      args: [],
    );
  }

  /// `No bank accounts`
  String get no_bank_accounts {
    return Intl.message(
      'No bank accounts',
      name: 'no_bank_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Offer successfully removed from favorite`
  String get offer_removed_from_favorite {
    return Intl.message(
      'Offer successfully removed from favorite',
      name: 'offer_removed_from_favorite',
      desc: '',
      args: [],
    );
  }

  /// `offer successfully added to favorite`
  String get offer_added_to_favorite {
    return Intl.message(
      'offer successfully added to favorite',
      name: 'offer_added_to_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Shop contact informations successfully updated`
  String get shop_contact_successfully_updated {
    return Intl.message(
      'Shop contact informations successfully updated',
      name: 'shop_contact_successfully_updated',
      desc: '',
      args: [],
    );
  }

  /// `Shop contact email`
  String get shop_contact_email {
    return Intl.message(
      'Shop contact email',
      name: 'shop_contact_email',
      desc: '',
      args: [],
    );
  }

  /// `Shop contact phone`
  String get shop_contact_phone {
    return Intl.message(
      'Shop contact phone',
      name: 'shop_contact_phone',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Shop informations successfully updated`
  String get shop_information_updated {
    return Intl.message(
      'Shop informations successfully updated',
      name: 'shop_information_updated',
      desc: '',
      args: [],
    );
  }

  /// `Shop name in arabic`
  String get shop_name_in_arabic {
    return Intl.message(
      'Shop name in arabic',
      name: 'shop_name_in_arabic',
      desc: '',
      args: [],
    );
  }

  /// `Shop name in english`
  String get shop_name_in_english {
    return Intl.message(
      'Shop name in english',
      name: 'shop_name_in_english',
      desc: '',
      args: [],
    );
  }

  /// `Add new slot`
  String get add_new_slot {
    return Intl.message(
      'Add new slot',
      name: 'add_new_slot',
      desc: '',
      args: [],
    );
  }

  /// `Latest sales`
  String get latest_sales {
    return Intl.message(
      'Latest sales',
      name: 'latest_sales',
      desc: '',
      args: [],
    );
  }

  /// `Bill ID`
  String get bill_id {
    return Intl.message(
      'Bill ID',
      name: 'bill_id',
      desc: '',
      args: [],
    );
  }

  /// `Customer name`
  String get customre_name {
    return Intl.message(
      'Customer name',
      name: 'customre_name',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Edit bank account`
  String get bank_account_edit {
    return Intl.message(
      'Edit bank account',
      name: 'bank_account_edit',
      desc: '',
      args: [],
    );
  }

  /// `Invoice details`
  String get invoice_details {
    return Intl.message(
      'Invoice details',
      name: 'invoice_details',
      desc: '',
      args: [],
    );
  }

  /// `Tax number`
  String get tax_number {
    return Intl.message(
      'Tax number',
      name: 'tax_number',
      desc: '',
      args: [],
    );
  }

  /// `Invoice date`
  String get invoice_date {
    return Intl.message(
      'Invoice date',
      name: 'invoice_date',
      desc: '',
      args: [],
    );
  }

  /// `Total with vat`
  String get total_with_vat {
    return Intl.message(
      'Total with vat',
      name: 'total_with_vat',
      desc: '',
      args: [],
    );
  }

  /// `vat`
  String get vat {
    return Intl.message(
      'vat',
      name: 'vat',
      desc: '',
      args: [],
    );
  }

  /// `valid_invoice`
  String get valid_invoice {
    return Intl.message(
      'valid_invoice',
      name: 'valid_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Pending invoice`
  String get pending_invoice {
    return Intl.message(
      'Pending invoice',
      name: 'pending_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Canceled invoice`
  String get canceled_invoice {
    return Intl.message(
      'Canceled invoice',
      name: 'canceled_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Profile successfully updated`
  String get profile_updated {
    return Intl.message(
      'Profile successfully updated',
      name: 'profile_updated',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image successfully Updated`
  String get profile_image_updated {
    return Intl.message(
      'Profile Image successfully Updated',
      name: 'profile_image_updated',
      desc: '',
      args: [],
    );
  }

  /// `Redeem points`
  String get redeem_points {
    return Intl.message(
      'Redeem points',
      name: 'redeem_points',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Available points`
  String get available_points {
    return Intl.message(
      'Available points',
      name: 'available_points',
      desc: '',
      args: [],
    );
  }

  /// `Enter point amounts you want to redeem`
  String get enter_points_amount_you_want_to_redeem {
    return Intl.message(
      'Enter point amounts you want to redeem',
      name: 'enter_points_amount_you_want_to_redeem',
      desc: '',
      args: [],
    );
  }

  /// `Notice 1 point eqauls 1 SAR`
  String get notice_1_point_equal_1_sar {
    return Intl.message(
      'Notice 1 point eqauls 1 SAR',
      name: 'notice_1_point_equal_1_sar',
      desc: '',
      args: [],
    );
  }

  /// `Choose your gift from our partners`
  String get choose_your_gift_from_our_partners {
    return Intl.message(
      'Choose your gift from our partners',
      name: 'choose_your_gift_from_our_partners',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `No coupons`
  String get no_coupons {
    return Intl.message(
      'No coupons',
      name: 'no_coupons',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan_title {
    return Intl.message(
      'Scan',
      name: 'scan_title',
      desc: '',
      args: [],
    );
  }

  /// `Available balance`
  String get available_balance {
    return Intl.message(
      'Available balance',
      name: 'available_balance',
      desc: '',
      args: [],
    );
  }

  /// `Pending balance`
  String get pending_balance {
    return Intl.message(
      'Pending balance',
      name: 'pending_balance',
      desc: '',
      args: [],
    );
  }

  /// `Total balance`
  String get total_balance {
    return Intl.message(
      'Total balance',
      name: 'total_balance',
      desc: '',
      args: [],
    );
  }

  /// `My history`
  String get my_history {
    return Intl.message(
      'My history',
      name: 'my_history',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw balance`
  String get withdraw_balance {
    return Intl.message(
      'Withdraw balance',
      name: 'withdraw_balance',
      desc: '',
      args: [],
    );
  }

  /// `Previous Offers`
  String get previous_offers {
    return Intl.message(
      'Previous Offers',
      name: 'previous_offers',
      desc: '',
      args: [],
    );
  }

  /// `Approved at`
  String get approved_at {
    return Intl.message(
      'Approved at',
      name: 'approved_at',
      desc: '',
      args: [],
    );
  }

  /// `Rejected invoice`
  String get rejected_invoice {
    return Intl.message(
      'Rejected invoice',
      name: 'rejected_invoice',
      desc: '',
      args: [],
    );
  }

  /// `points`
  String get points {
    return Intl.message(
      'points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `No offers`
  String get no_offers {
    return Intl.message(
      'No offers',
      name: 'no_offers',
      desc: '',
      args: [],
    );
  }

  /// `me`
  String get me {
    return Intl.message(
      'me',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Shop contact informations`
  String get shop_contact_informations {
    return Intl.message(
      'Shop contact informations',
      name: 'shop_contact_informations',
      desc: '',
      args: [],
    );
  }

  /// `shop contact website`
  String get shop_contact_website {
    return Intl.message(
      'shop contact website',
      name: 'shop_contact_website',
      desc: '',
      args: [],
    );
  }

  /// `Sender full name`
  String get sender_full_name {
    return Intl.message(
      'Sender full name',
      name: 'sender_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Sender phone number`
  String get sender_phone_number {
    return Intl.message(
      'Sender phone number',
      name: 'sender_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Deposited at`
  String get deposited_at {
    return Intl.message(
      'Deposited at',
      name: 'deposited_at',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get notice {
    return Intl.message(
      'Notice',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Transaction screenshot`
  String get transaction_screenshot {
    return Intl.message(
      'Transaction screenshot',
      name: 'transaction_screenshot',
      desc: '',
      args: [],
    );
  }

  /// `Select payment method`
  String get select_payment_method {
    return Intl.message(
      'Select payment method',
      name: 'select_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Bank transaction`
  String get bank_transaction {
    return Intl.message(
      'Bank transaction',
      name: 'bank_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Online payment (soon)`
  String get online_payment_soon {
    return Intl.message(
      'Online payment (soon)',
      name: 'online_payment_soon',
      desc: '',
      args: [],
    );
  }

  /// `Deposit bank account`
  String get deposit_bank_account {
    return Intl.message(
      'Deposit bank account',
      name: 'deposit_bank_account',
      desc: '',
      args: [],
    );
  }

  /// `pay with bank transaction for the bank accounts below then fill transaction informations`
  String get pay_offer_commission_pay_with_bank_transaction {
    return Intl.message(
      'pay with bank transaction for the bank accounts below then fill transaction informations',
      name: 'pay_offer_commission_pay_with_bank_transaction',
      desc: '',
      args: [],
    );
  }

  /// `No deposit bank accounts`
  String get no_deposit_bank_accounts {
    return Intl.message(
      'No deposit bank accounts',
      name: 'no_deposit_bank_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Select city`
  String get select_city {
    return Intl.message(
      'Select city',
      name: 'select_city',
      desc: '',
      args: [],
    );
  }

  /// `Select district`
  String get select_district {
    return Intl.message(
      'Select district',
      name: 'select_district',
      desc: '',
      args: [],
    );
  }

  /// `Commission amount for offer`
  String get commission_amount_for_offer {
    return Intl.message(
      'Commission amount for offer',
      name: 'commission_amount_for_offer',
      desc: '',
      args: [],
    );
  }

  /// `Offer sales`
  String get offer_sales {
    return Intl.message(
      'Offer sales',
      name: 'offer_sales',
      desc: '',
      args: [],
    );
  }

  /// `Total commission`
  String get total_commission {
    return Intl.message(
      'Total commission',
      name: 'total_commission',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get sales {
    return Intl.message(
      'Sales',
      name: 'sales',
      desc: '',
      args: [],
    );
  }

  /// `About this coupon`
  String get about_this_coupon {
    return Intl.message(
      'About this coupon',
      name: 'about_this_coupon',
      desc: '',
      args: [],
    );
  }

  /// `Refund details`
  String get refund_details {
    return Intl.message(
      'Refund details',
      name: 'refund_details',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `No categories`
  String get no_cateogies {
    return Intl.message(
      'No categories',
      name: 'no_cateogies',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get birth_date {
    return Intl.message(
      'Birth date',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Select gender`
  String get select_gender {
    return Intl.message(
      'Select gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `point at mybill equal`
  String get point_at_my_bill_equal {
    return Intl.message(
      'point at mybill equal',
      name: 'point_at_my_bill_equal',
      desc: '',
      args: [],
    );
  }

  /// `Select bank account`
  String get select_bank_account {
    return Intl.message(
      'Select bank account',
      name: 'select_bank_account',
      desc: '',
      args: [],
    );
  }

  /// `location permission is required`
  String get location_permission_is_required {
    return Intl.message(
      'location permission is required',
      name: 'location_permission_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Rdeem points history`
  String get redeem_points_history {
    return Intl.message(
      'Rdeem points history',
      name: 'redeem_points_history',
      desc: '',
      args: [],
    );
  }

  /// `used`
  String get used {
    return Intl.message(
      'used',
      name: 'used',
      desc: '',
      args: [],
    );
  }

  /// `Point`
  String get point {
    return Intl.message(
      'Point',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `Each point is equivalent to one riyal and can be exchanged or requested to be withdrawn and transferred to your bank account. A minimum of 100 points must be collected for withdrawal. Points are valid for 12 months from the date they were earned.`
  String get withdraw_blanace_long_text {
    return Intl.message(
      'Each point is equivalent to one riyal and can be exchanged or requested to be withdrawn and transferred to your bank account. A minimum of 100 points must be collected for withdrawal. Points are valid for 12 months from the date they were earned.',
      name: 'withdraw_blanace_long_text',
      desc: '',
      args: [],
    );
  }

  /// `valid for`
  String get valid_for {
    return Intl.message(
      'valid for',
      name: 'valid_for',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `coupon details`
  String get coupon_detals {
    return Intl.message(
      'coupon details',
      name: 'coupon_detals',
      desc: '',
      args: [],
    );
  }

  /// `shop informations`
  String get shop_informations {
    return Intl.message(
      'shop informations',
      name: 'shop_informations',
      desc: '',
      args: [],
    );
  }

  /// `ُEnter shop name`
  String get enter_shop_name {
    return Intl.message(
      'ُEnter shop name',
      name: 'enter_shop_name',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expired {
    return Intl.message(
      'Expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
