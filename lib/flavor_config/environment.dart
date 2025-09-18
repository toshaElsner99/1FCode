enum Environment {
  STAGING,
  PRODUCTION,
}


class Constants {
  static Environment _environment = Environment.PRODUCTION;

  static Environment get environment => _environment;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  // Environment-specific configurations
  static String get appName {
    switch (_environment) {
      case Environment.STAGING:
        return '1FCode Stage';
      case Environment.PRODUCTION:
        return '1FCode';
    }
  }

  static String get baseUrl {
    switch (_environment) {
      case Environment.STAGING:
        return '';
      case Environment.PRODUCTION:
        return '';
    }
  }

  static bool get isProduction => _environment == Environment.PRODUCTION;

  static String get environmentName {
    switch (_environment) {
      case Environment.STAGING:
        return 'stage';
      case Environment.PRODUCTION:
        return 'prod';
    }
  }
}
