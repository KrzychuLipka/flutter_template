abstract class GeneralError {
  final String _msgKey;
  final String _technicalMsg;

  GeneralError({
    required String msgKey,
    required String technicalMsg,
  })  : _msgKey = msgKey,
        _technicalMsg = technicalMsg;

  String get msgKey => _msgKey;

  String get technicalMsg => _technicalMsg;
}
