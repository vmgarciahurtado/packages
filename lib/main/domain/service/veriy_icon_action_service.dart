import '../interface/i_verify_icon_action.dart';

class VerifyIconService {
  IVerifyIconActionRepository iVerifyIconActionRepository;

  VerifyIconService({required this.iVerifyIconActionRepository});

  Future<bool> verifyAction(String codClient, String dynamicForm) {
    return iVerifyIconActionRepository.verifyAction(codClient, dynamicForm);
  }
}
