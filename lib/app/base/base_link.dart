class BaseLink {
  static String domain = 'https://clownfish-app-wvth5.ondigitalocean.app';
  static String register = '$domain/auth/register-collector';
  static String login = '$domain/auth/login';

  static String fetchListMaterial = '$domain/material/get-all-material';
  static String fetchListScheduleByStatus =
      '$domain/collector/get-list-collection-schedule-by-status';
  static String fetchListScheduleUserByStatus =
      '$domain/schedule/get-list-collection-schedule-by-user-by-status';

  static String regisSchdule =
      '$domain/collector/accept-colecttion-schedule-by-id';
  static String fetchScheduleById = '$domain/schedule/get-schedule-by-id';

  static String createQrPayment =
      '$domain/collector/create-collector-resident-payment';

  static String scheduleDetailById = '$domain/schedule/get-schedule-by-id';
  static String paymentDetailByScheduleId =
      '$domain/collector/get-payment-cr-by-schedule-id';
  static String confirmPayment =
      '$domain/recycling-depot/update-success-payment-by-id';

  static String getPoints = '$domain/user/get-point-by-user';
  static String createMoneyLink =
      '$domain/payment/create-collectors-payment-url';
  static String sendPoint = '$domain/payment/change-point-to-user';
}
