part of 'base_pages.dart';

abstract class Routes {
  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const otpVerification = _Paths.login + _Paths.otpVerification;
  static const forgotPassword = _Paths.forgotPassword;
  static const alertForgotPassword =
      _Paths.forgotPassword + _Paths.alertForgotPassword;
  static const otpChangePassword = _Paths.forgotPassword +
      _Paths.alertForgotPassword +
      _Paths.otpChangePassword;
  static const resetPasswordDeepLink = _Paths.resetPasswordDeepLink;
  static const home = _Paths.home;
  static const userSetting = _Paths.home + _Paths.userSetting;
  static const userInformation =
      _Paths.home + _Paths.userSetting + _Paths.userInformation;
  static const register = _Paths.login + _Paths.register;
  static const taskDetail = _Paths.home + _Paths.taskDetail;
  static const taskPerform = _Paths.home + _Paths.taskPerform;
  static const takePhoto = _Paths.home + _Paths.taskPerform + _Paths.takePhoto;
  static const previewPhoto =
      _Paths.home + _Paths.taskPerform + _Paths.takePhoto + _Paths.previewPhoto;
  static const taskReward = _Paths.home + _Paths.taskReward;
  static const notification = _Paths.home + _Paths.notification;
  static const mysteryBoxDetail = _Paths.home + _Paths.mysteryBoxDetail;
  static const checkInList = _Paths.home + _Paths.checkInList;
  static const tokenInfo = _Paths.home + _Paths.tokenInfo;
  static const passwordSecurity = _Paths.home + _Paths.passwordSecurity;
  static const changePassword =
      _Paths.home + _Paths.passwordSecurity + _Paths.changePassword;
  static const editProfile = _Paths.home + _Paths.editProfile;
  static const helpCenter = _Paths.home + _Paths.helpCenter;
  static const needHelp = _Paths.home + _Paths.helpCenter + _Paths.needHelp;
  static const helpTemplate =
      _Paths.home + _Paths.helpCenter + _Paths.helpTemplate;
  static const voucherDetail = _Paths.home + _Paths.voucherDetail;
  static const voucherDetailQr =
      _Paths.home + _Paths.voucherDetail + _Paths.voucherDetailQr;
  static const voucherHistory = _Paths.home + _Paths.voucherHistory;
  static const boxHistory = _Paths.home + _Paths.boxHistory;
  static const boxDetail = _Paths.home + _Paths.boxHistory + _Paths.boxDetail;
  static const nftDetail = _Paths.home + _Paths.nftDetail;
  static const groupDetail = _Paths.home + _Paths.groupDetail;
  static const group = _Paths.home + _Paths.group;
  static const socialList = _Paths.home + _Paths.socialList;
  static const socialTaskDetail = _Paths.home + _Paths.socialTaskDetail;
  static const myGroupList = _Paths.home + _Paths.myGroupList;
  static const index = _Paths.home + _Paths.index;
  static const qrcode = _Paths.home + _Paths.qrCode;
  static const ticket = _Paths.home + _Paths.ticket;
  static const overview = _Paths.home + _Paths.overview;
  static const listTrendingEvent = _Paths.listTrendingEvent;
  static const listUpcomingEvent = _Paths.listUpcomingEvent;
  static const aboutApp = _Paths.aboutApp;
}

abstract class _Paths {
  static const splash = '/';
  static const login = '/login';
  static const otpVerification = '/otpVerification';
  static const forgotPassword = '/forgotPassword';
  static const alertForgotPassword = '/alertForgotPassword';
  static const otpChangePassword = '/otpChangePassword';
  static const resetPasswordDeepLink = '/:langCode/reset-password';
  static const home = '/home';
  static const userSetting = '/userSetting';
  static const userInformation = '/userInformation';
  static const register = '/register';
  static const taskDetail = '/taskDetail';
  static const taskPerform = '/taskPerform';
  static const takePhoto = '/takePhoto';
  static const previewPhoto = '/previewPhoto';
  static const taskReward = '/taskReward';
  static const notification = '/notification';
  static const mysteryBoxDetail = '/mysteryBoxDetail';
  static const checkInList = '/checkInList';
  static const tokenInfo = '/tokenInfo';
  static const passwordSecurity = '/passwordSecurity';
  static const changePassword = '/changePassword';
  static const editProfile = '/editProfile';
  static const helpCenter = '/helpCenter';
  static const needHelp = '/needHelp';
  static const helpTemplate = '/helpTemplate';
  static const voucherDetail = '/voucherDetail';
  static const voucherDetailQr = '/voucherDetailQr';
  static const voucherHistory = '/voucherHistory';
  static const boxHistory = '/boxHistory';
  static const boxDetail = '/boxDetail';
  static const nftDetail = '/nftDetail';
  static const groupDetail = '/groupDetail';
  static const socialList = '/socialList';
  static const socialTaskDetail = '/socialTaskDetail';
  static const group = '/group';
  static const myGroupList = '/myGroupList';
  static const index = '/index';
  static const qrCode = '/qrcode';
  static const ticket = '/ticket';
  static const overview = '/overview';
  static const listUpcomingEvent = '/listUpcomingEvent';
  static const listTrendingEvent = '/listTrendingEvent';
  static const aboutApp = '/aboutApp';
}
