import 'dart:io' show Platform;

const REFRESH_TOKEN_KEY = 'refresh_token';
const BACKEND_TOKEN_KEY = 'backend_token';
const GOOGLE_ISSUER = 'https://accounts.google.com';
const GOOGLE_CLIENT_ID_IOS = '<396464895081-1ftg2anqklh1hk5hbjdo2sasosrdfimj.apps.googleusercontent.com>';
const GOOGLE_REDIRECT_URI_IOS = 'com.googleusercontent.apps.<396464895081-1ftg2anqklh1hk5hbjdo2sasosrdfimj.apps.googleusercontent.com>:/oauthredirect';
const GOOGLE_CLIENT_ID_ANDROID = '<396464895081-5hu9aj2918ip058osmjgdqj0gmno3u04.apps.googleusercontent.com>';
const GOOGLE_REDIRECT_URI_ANDROID = 'com.googleusercontent.apps.<396464895081-5hu9aj2918ip058osmjgdqj0gmno3u04.apps.googleusercontent.com>:/oauthredirect';

String clientID() {
  if(Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if(Platform.isAndroid) {
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}