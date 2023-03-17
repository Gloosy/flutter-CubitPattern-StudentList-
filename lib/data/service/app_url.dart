class AppUrl {
  static String baseUrl     = "https://api-ds-uat.azurewebsites.net/api/v1";
  static String getArticles = '$baseUrl/search/student?letternumber=00015';
  static String postImage   = '$baseUrl/student/upload-profile';
  static String updateInfo  = '$baseUrl/student/edit';
  static String header      = 'BEB03CD3-7204-405F-BE41-58EC27F2AEBD';
}
