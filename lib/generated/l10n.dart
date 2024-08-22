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

  /// `Booking different courts`
  String get OnboardingTitle1 {
    return Intl.message(
      'Booking different courts',
      name: 'OnboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `The application brings together all of the different sports stadiums, allowing you to choose what works best for you in terms of stadium and time`
  String get Onboardingdesc1 {
    return Intl.message(
      'The application brings together all of the different sports stadiums, allowing you to choose what works best for you in terms of stadium and time',
      name: 'Onboardingdesc1',
      desc: '',
      args: [],
    );
  }

  /// `Offers group`
  String get OnboardingTitle2 {
    return Intl.message(
      'Offers group',
      name: 'OnboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Many bundled offers are applied for people who always book continuously and receive points for each booking.`
  String get Onboardingdesc2 {
    return Intl.message(
      'Many bundled offers are applied for people who always book continuously and receive points for each booking.',
      name: 'Onboardingdesc2',
      desc: '',
      args: [],
    );
  }

  /// `rating & find partner`
  String get OnboardingTitle3 {
    return Intl.message(
      'rating & find partner',
      name: 'OnboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Find out all the impartial reviews of flooring and its workers, and also find a partner for me to play in an easy way`
  String get Onboardingdesc3 {
    return Intl.message(
      'Find out all the impartial reviews of flooring and its workers, and also find a partner for me to play in an easy way',
      name: 'Onboardingdesc3',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Onboarding_Skip_Text {
    return Intl.message(
      'Skip',
      name: 'Onboarding_Skip_Text',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get Onboarding_Get_started_Text {
    return Intl.message(
      'Get started',
      name: 'Onboarding_Get_started_Text',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Onboarding_Next_Text {
    return Intl.message(
      'Next',
      name: 'Onboarding_Next_Text',
      desc: '',
      args: [],
    );
  }

  /// `Login to Your Account`
  String get sign_in_Head {
    return Intl.message(
      'Login to Your Account',
      name: 'sign_in_Head',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_in_Email {
    return Intl.message(
      'Email',
      name: 'sign_in_Email',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get sign_in_password {
    return Intl.message(
      'password',
      name: 'sign_in_password',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get sign_in_Forget_Password {
    return Intl.message(
      'Forget Password',
      name: 'sign_in_Forget_Password',
      desc: '',
      args: [],
    );
  }

  /// ` Sign in `
  String get sign_in_Sign_in_button {
    return Intl.message(
      ' Sign in ',
      name: 'sign_in_Sign_in_button',
      desc: '',
      args: [],
    );
  }

  /// ` Or Sign in with`
  String get sign_in_Sign_in_with_button {
    return Intl.message(
      ' Or Sign in with',
      name: 'sign_in_Sign_in_with_button',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have An Account ?`
  String get sign_in_Dont_Have_An_Account_button {
    return Intl.message(
      'Don\'t Have An Account ?',
      name: 'sign_in_Dont_Have_An_Account_button',
      desc: '',
      args: [],
    );
  }

  /// ` Sign Up`
  String get sign_in_Sign_Up_button {
    return Intl.message(
      ' Sign Up',
      name: 'sign_in_Sign_Up_button',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Account`
  String get register_Head {
    return Intl.message(
      'Create Your Account',
      name: 'register_Head',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get register_Username {
    return Intl.message(
      'Username',
      name: 'register_Username',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get register_Phone {
    return Intl.message(
      'Phone',
      name: 'register_Phone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get register_Email {
    return Intl.message(
      'Email',
      name: 'register_Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get register_Password {
    return Intl.message(
      'Password',
      name: 'register_Password',
      desc: '',
      args: [],
    );
  }

  /// ` Sign Up `
  String get register_Sign_Up_button {
    return Intl.message(
      ' Sign Up ',
      name: 'register_Sign_Up_button',
      desc: '',
      args: [],
    );
  }

  /// ` Or Sign in with`
  String get register_Sign_in_with_button {
    return Intl.message(
      ' Or Sign in with',
      name: 'register_Sign_in_with_button',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account ?`
  String get register_Already_Have_An_Account_button {
    return Intl.message(
      'Already Have An Account ?',
      name: 'register_Already_Have_An_Account_button',
      desc: '',
      args: [],
    );
  }

  /// ` Sign in`
  String get register_Sign_in_button {
    return Intl.message(
      ' Sign in',
      name: 'register_Sign_in_button',
      desc: '',
      args: [],
    );
  }

  /// `Verify your account`
  String get Verify_email_Head {
    return Intl.message(
      'Verify your account',
      name: 'Verify_email_Head',
      desc: '',
      args: [],
    );
  }

  /// `Click The Button to Receive a Verification Link `
  String get Verify_email_Desc {
    return Intl.message(
      'Click The Button to Receive a Verification Link ',
      name: 'Verify_email_Desc',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get Verify_email_Verify_Dialog_title {
    return Intl.message(
      'Verify Email',
      name: 'Verify_email_Verify_Dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email`
  String get Verify_email_Verify_Dialog_desc {
    return Intl.message(
      'Please verify your email',
      name: 'Verify_email_Verify_Dialog_desc',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get Verification_code_Head {
    return Intl.message(
      'Enter verification code',
      name: 'Verification_code_Head',
      desc: '',
      args: [],
    );
  }

  /// `We are automatically detecting SMS messages sent to your email address.`
  String get Verification_code_Desc {
    return Intl.message(
      'We are automatically detecting SMS messages sent to your email address.',
      name: 'Verification_code_Desc',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get Verification_code_Resend_button {
    return Intl.message(
      'Resend',
      name: 'Verification_code_Resend_button',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get New_Password_Head {
    return Intl.message(
      'New Password',
      name: 'New_Password_Head',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number, and we will send you a confirmation code.`
  String get New_Password_Desc {
    return Intl.message(
      'Please enter your phone number, and we will send you a confirmation code.',
      name: 'New_Password_Desc',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get New_Password_Password {
    return Intl.message(
      'Password',
      name: 'New_Password_Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get New_Password_Confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'New_Password_Confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get New_Password_Change_password_button {
    return Intl.message(
      'Change password',
      name: 'New_Password_Change_password_button',
      desc: '',
      args: [],
    );
  }

  /// `Forget password ?`
  String get forget_password_Head {
    return Intl.message(
      'Forget password ?',
      name: 'forget_password_Head',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email for recovery of your account`
  String get forget_password_Desc {
    return Intl.message(
      'Enter your Email for recovery of your account',
      name: 'forget_password_Desc',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get forget_password_Email {
    return Intl.message(
      'Email',
      name: 'forget_password_Email',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get forget_password_Reset_password_button {
    return Intl.message(
      'Reset password',
      name: 'forget_password_Reset_password_button',
      desc: '',
      args: [],
    );
  }

  /// `All_courts`
  String get All_courts_Head {
    return Intl.message(
      'All_courts',
      name: 'All_courts_Head',
      desc: '',
      args: [],
    );
  }

  /// `Booking Court`
  String get Booking_court_Head {
    return Intl.message(
      'Booking Court',
      name: 'Booking_court_Head',
      desc: '',
      args: [],
    );
  }

  /// `--  Choose Your Date And Time --`
  String get Booking_court_desc {
    return Intl.message(
      '--  Choose Your Date And Time --',
      name: 'Booking_court_desc',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Booking_court_Date {
    return Intl.message(
      'Date',
      name: 'Booking_court_Date',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get Booking_court_Start_Time {
    return Intl.message(
      'Start Time',
      name: 'Booking_court_Start_Time',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get Booking_court_End_Time {
    return Intl.message(
      'End Time',
      name: 'Booking_court_End_Time',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get Booking_court_Booking_button {
    return Intl.message(
      'Booking',
      name: 'Booking_court_Booking_button',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation Booking`
  String get Booking_court_Dialog_success_title {
    return Intl.message(
      'Confirmation Booking',
      name: 'Booking_court_Dialog_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Your booking has been confirmed`
  String get Booking_court_Dialog_success_desc {
    return Intl.message(
      'Your booking has been confirmed',
      name: 'Booking_court_Dialog_success_desc',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Start/End Hour`
  String get Booking_court_Dialog_fail_title {
    return Intl.message(
      'Wrong Start/End Hour',
      name: 'Booking_court_Dialog_fail_title',
      desc: '',
      args: [],
    );
  }

  /// `Your booking has been canceled due to an invalid hour. Please try again`
  String get Booking_court_Dialog_fail_desc {
    return Intl.message(
      'Your booking has been canceled due to an invalid hour. Please try again',
      name: 'Booking_court_Dialog_fail_desc',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get Ground_Type_Head {
    return Intl.message(
      'Sports',
      name: 'Ground_Type_Head',
      desc: '',
      args: [],
    );
  }

  /// `Courts Details`
  String get Details_View_Head {
    return Intl.message(
      'Courts Details',
      name: 'Details_View_Head',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Details_View_desc {
    return Intl.message(
      'Description',
      name: 'Details_View_desc',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get Details_View_Review {
    return Intl.message(
      'Reviews',
      name: 'Details_View_Review',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get Details_View_Booking_button {
    return Intl.message(
      'Booking',
      name: 'Details_View_Booking_button',
      desc: '',
      args: [],
    );
  }

  /// `welcome`
  String get Header_view_Head {
    return Intl.message(
      'welcome',
      name: 'Header_view_Head',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review_head {
    return Intl.message(
      'Review',
      name: 'Review_head',
      desc: '',
      args: [],
    );
  }

  /// `Share Your Feedback`
  String get Review_Share_Your_Feedback {
    return Intl.message(
      'Share Your Feedback',
      name: 'Review_Share_Your_Feedback',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review_Text_Tile {
    return Intl.message(
      'Review',
      name: 'Review_Text_Tile',
      desc: '',
      args: [],
    );
  }

  /// `Add Comment...`
  String get Review_hintText {
    return Intl.message(
      'Add Comment...',
      name: 'Review_hintText',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Review_Send_button {
    return Intl.message(
      'Send',
      name: 'Review_Send_button',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get Booking_view_Dialog_title {
    return Intl.message(
      'Cancel Booking',
      name: 'Booking_view_Dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this appointment?`
  String get Booking_view_Dialog_content {
    return Intl.message(
      'Are you sure you want to cancel this appointment?',
      name: 'Booking_view_Dialog_content',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get Booking_view_head {
    return Intl.message(
      'My Bookings',
      name: 'Booking_view_head',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Booking_view_Cancel_button {
    return Intl.message(
      'Cancel',
      name: 'Booking_view_Cancel_button',
      desc: '',
      args: [],
    );
  }

  /// `Find Players to join`
  String get Booking_view_Find_Players_to_join_button {
    return Intl.message(
      'Find Players to join',
      name: 'Booking_view_Find_Players_to_join_button',
      desc: '',
      args: [],
    );
  }

  /// `Find player`
  String get Find_Player_head {
    return Intl.message(
      'Find player',
      name: 'Find_Player_head',
      desc: '',
      args: [],
    );
  }

  /// `When is the game starting ?`
  String get Find_Player_When_is_the_game_starting {
    return Intl.message(
      'When is the game starting ?',
      name: 'Find_Player_When_is_the_game_starting',
      desc: '',
      args: [],
    );
  }

  /// `How Long the game ?`
  String get Find_Player_How_Long_the_game {
    return Intl.message(
      'How Long the game ?',
      name: 'Find_Player_How_Long_the_game',
      desc: '',
      args: [],
    );
  }

  /// `Number of players needed`
  String get Find_Player_Number_of_players_needed {
    return Intl.message(
      'Number of players needed',
      name: 'Find_Player_Number_of_players_needed',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get Find_Player_Comments {
    return Intl.message(
      'Comments',
      name: 'Find_Player_Comments',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment`
  String get Find_Player_Write_your_comment {
    return Intl.message(
      'Write your comment',
      name: 'Find_Player_Write_your_comment',
      desc: '',
      args: [],
    );
  }

  /// `Find Players`
  String get Find_Player_Find_Players_button {
    return Intl.message(
      'Find Players',
      name: 'Find_Player_Find_Players_button',
      desc: '',
      args: [],
    );
  }

  /// `My favorite courts`
  String get Favorite_head {
    return Intl.message(
      'My favorite courts',
      name: 'Favorite_head',
      desc: '',
      args: [],
    );
  }

  /// `Comment and rate`
  String get Favorite_Comment_and_rate {
    return Intl.message(
      'Comment and rate',
      name: 'Favorite_Comment_and_rate',
      desc: '',
      args: [],
    );
  }

  /// ` Search`
  String get Search_view_head {
    return Intl.message(
      ' Search',
      name: 'Search_view_head',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search_view_Hint {
    return Intl.message(
      'Search',
      name: 'Search_view_Hint',
      desc: '',
      args: [],
    );
  }

  /// `About app`
  String get About_app_head {
    return Intl.message(
      'About app',
      name: 'About_app_head',
      desc: '',
      args: [],
    );
  }

  /// `Request for court reservation application. With the help of this application, users will be able to select the most convenient court in terms of both cost and distance, find out the locations and empty hours, and compare courts with other users to solve the problem of booking well-known courts. Additionally, users will be able to distinguish between users who share the same identity and book courts with new people if they so choose.`
  String get About_app_desc {
    return Intl.message(
      'Request for court reservation application. With the help of this application, users will be able to select the most convenient court in terms of both cost and distance, find out the locations and empty hours, and compare courts with other users to solve the problem of booking well-known courts. Additionally, users will be able to distinguish between users who share the same identity and book courts with new people if they so choose.',
      name: 'About_app_desc',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get Contact_us_head {
    return Intl.message(
      'Contact us',
      name: 'Contact_us_head',
      desc: '',
      args: [],
    );
  }

  /// `Contact info`
  String get Contact_us_info1 {
    return Intl.message(
      'Contact info',
      name: 'Contact_us_info1',
      desc: '',
      args: [],
    );
  }

  /// `Stadium reservations can be made online.`
  String get Contact_us_info2 {
    return Intl.message(
      'Stadium reservations can be made online.',
      name: 'Contact_us_info2',
      desc: '',
      args: [],
    );
  }

  /// `Social media`
  String get Contact_us_Social_media {
    return Intl.message(
      'Social media',
      name: 'Contact_us_Social_media',
      desc: '',
      args: [],
    );
  }

  /// `more inquiries `
  String get Contact_us_more_inquiries_button {
    return Intl.message(
      'more inquiries ',
      name: 'Contact_us_more_inquiries_button',
      desc: '',
      args: [],
    );
  }

  /// `Edit account`
  String get Edit_profile_head {
    return Intl.message(
      'Edit account',
      name: 'Edit_profile_head',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get Edit_profile_Your_name {
    return Intl.message(
      'Your name',
      name: 'Edit_profile_Your_name',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get Edit_profile_Current_password {
    return Intl.message(
      'Current password',
      name: 'Edit_profile_Current_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get Edit_profile_New_Password {
    return Intl.message(
      'New Password',
      name: 'Edit_profile_New_Password',
      desc: '',
      args: [],
    );
  }

  /// `save change`
  String get Edit_profile_save_change_button {
    return Intl.message(
      'save change',
      name: 'Edit_profile_save_change_button',
      desc: '',
      args: [],
    );
  }

  /// `How can I help you`
  String get Help_view_Help1 {
    return Intl.message(
      'How can I help you',
      name: 'Help_view_Help1',
      desc: '',
      args: [],
    );
  }

  /// `Talk to a specialist`
  String get Help_view_Help2 {
    return Intl.message(
      'Talk to a specialist',
      name: 'Help_view_Help2',
      desc: '',
      args: [],
    );
  }

  /// `Reservation cancellation policy`
  String get Help_view_Help3 {
    return Intl.message(
      'Reservation cancellation policy',
      name: 'Help_view_Help3',
      desc: '',
      args: [],
    );
  }

  /// `A problem occurred while using the application`
  String get Help_view_Help4 {
    return Intl.message(
      'A problem occurred while using the application',
      name: 'Help_view_Help4',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get Last_order_Dialog_title {
    return Intl.message(
      'Cancel Booking',
      name: 'Last_order_Dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this appointment?`
  String get Last_order_Dialog_content {
    return Intl.message(
      'Are you sure you want to cancel this appointment?',
      name: 'Last_order_Dialog_content',
      desc: '',
      args: [],
    );
  }

  /// `Last order`
  String get Last_order_head {
    return Intl.message(
      'Last order',
      name: 'Last_order_head',
      desc: '',
      args: [],
    );
  }

  /// `Last book`
  String get Last_order_Last_book {
    return Intl.message(
      'Last book',
      name: 'Last_order_Last_book',
      desc: '',
      args: [],
    );
  }

  /// `Comment and rate`
  String get Last_order_Comment_and_rate {
    return Intl.message(
      'Comment and rate',
      name: 'Last_order_Comment_and_rate',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Last_order_Cancel_button {
    return Intl.message(
      'Cancel',
      name: 'Last_order_Cancel_button',
      desc: '',
      args: [],
    );
  }

  /// `more inquiries`
  String get more_inquiries_head {
    return Intl.message(
      'more inquiries',
      name: 'more_inquiries_head',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get more_inquiries_Subject {
    return Intl.message(
      'Subject',
      name: 'more_inquiries_Subject',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get more_inquiries_Email {
    return Intl.message(
      'Email',
      name: 'more_inquiries_Email',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get more_inquiries_Message {
    return Intl.message(
      'Message',
      name: 'more_inquiries_Message',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get more_inquiries_Submit_button {
    return Intl.message(
      'Submit',
      name: 'more_inquiries_Submit_button',
      desc: '',
      args: [],
    );
  }

  /// `Offers group order`
  String get Offers_group_head {
    return Intl.message(
      'Offers group order',
      name: 'Offers_group_head',
      desc: '',
      args: [],
    );
  }

  /// `Offers group Week'`
  String get Offers_group_Head_offers1 {
    return Intl.message(
      'Offers group Week\'',
      name: 'Offers_group_Head_offers1',
      desc: '',
      args: [],
    );
  }

  /// `Repeated installations per week at the same stadiums receive a discount`
  String get Offers_group_Body_offers1 {
    return Intl.message(
      'Repeated installations per week at the same stadiums receive a discount',
      name: 'Offers_group_Body_offers1',
      desc: '',
      args: [],
    );
  }

  /// `%15`
  String get Offers_group_Percent_offers1 {
    return Intl.message(
      '%15',
      name: 'Offers_group_Percent_offers1',
      desc: '',
      args: [],
    );
  }

  /// `Offers group Month`
  String get Offers_group_Head_offers2 {
    return Intl.message(
      'Offers group Month',
      name: 'Offers_group_Head_offers2',
      desc: '',
      args: [],
    );
  }

  /// `Repeated installations per month at the same stadiums receive a discount `
  String get Offers_group_Body_offers2 {
    return Intl.message(
      'Repeated installations per month at the same stadiums receive a discount ',
      name: 'Offers_group_Body_offers2',
      desc: '',
      args: [],
    );
  }

  /// `%10`
  String get Offers_group_Percent_offers2 {
    return Intl.message(
      '%10',
      name: 'Offers_group_Percent_offers2',
      desc: '',
      args: [],
    );
  }

  /// `Offers group Year`
  String get Offers_group_Head_offers3 {
    return Intl.message(
      'Offers group Year',
      name: 'Offers_group_Head_offers3',
      desc: '',
      args: [],
    );
  }

  /// `Choose the months of the year that are appropriate for me to book at a discount`
  String get Offers_group_Body_offers3 {
    return Intl.message(
      'Choose the months of the year that are appropriate for me to book at a discount',
      name: 'Offers_group_Body_offers3',
      desc: '',
      args: [],
    );
  }

  /// `%5`
  String get Offers_group_Percent_offers3 {
    return Intl.message(
      '%5',
      name: 'Offers_group_Percent_offers3',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get Offers_group_Booking_Button {
    return Intl.message(
      'Booking',
      name: 'Offers_group_Booking_Button',
      desc: '',
      args: [],
    );
  }

  /// `Last order`
  String get profile_view_Last_order_button {
    return Intl.message(
      'Last order',
      name: 'profile_view_Last_order_button',
      desc: '',
      args: [],
    );
  }

  /// `Offers group`
  String get profile_view_Offers_group_button {
    return Intl.message(
      'Offers group',
      name: 'profile_view_Offers_group_button',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get profile_view_About_App_button {
    return Intl.message(
      'About App',
      name: 'profile_view_About_App_button',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get profile_view_Notification_button {
    return Intl.message(
      'Notification',
      name: 'profile_view_Notification_button',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get profile_view_Contact_us_button {
    return Intl.message(
      'Contact us',
      name: 'profile_view_Contact_us_button',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get profile_view_Settings_button {
    return Intl.message(
      'Settings',
      name: 'profile_view_Settings_button',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get profile_view_log_out {
    return Intl.message(
      'Log out',
      name: 'profile_view_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings_head {
    return Intl.message(
      'Settings',
      name: 'Settings_head',
      desc: '',
      args: [],
    );
  }

  /// `Edit account`
  String get Settings_Edit_account_button {
    return Intl.message(
      'Edit account',
      name: 'Settings_Edit_account_button',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get Settings_language_button {
    return Intl.message(
      'language',
      name: 'Settings_language_button',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get Settings_Help_button {
    return Intl.message(
      'Help',
      name: 'Settings_Help_button',
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
