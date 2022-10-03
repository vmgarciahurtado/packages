import '../interface/i_delete_form_answer.dart';

class DynamicFormDeleteAnswerService {
  IDeleFormAnswerRepository iDeleFormAnswerRepository;

  DynamicFormDeleteAnswerService({required this.iDeleFormAnswerRepository});

  Future<void> deleteFormAnswer(String context, String codClient) {
    return iDeleFormAnswerRepository.deleteAnswer(context, codClient);
  }
}
