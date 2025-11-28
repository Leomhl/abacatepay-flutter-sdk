/// Base URL for the AbacatePay API.
const String kBaseUrl = 'https://api.abacatepay.com/v1';

/// Default timeout for API requests.
const Duration kDefaultTimeout = Duration(seconds: 30);

/// AbacatePay documentation URL.
const String kDocsUrl = 'https://docs.abacatepay.com';

/// SDK version.
const String kSdkVersion = '0.0.1';

/// User agent string for API requests.
String getUserAgent() => 'AbacatePay-Flutter-SDK/$kSdkVersion';
