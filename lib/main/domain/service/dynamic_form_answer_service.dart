import '../interface/i_dynamic_form_answer_repository.dart';
import '../model/dynamic_form_answer.dart';

class DynamicFormAnswerService {
  final IDynamicFormAnswerRepository iDynamicFormAnswerRepository;

  DynamicFormAnswerService({required this.iDynamicFormAnswerRepository});

  Future<bool> setDynamicFormAnswer(
      List<DynamicFormAnswer> dynamicFormAnswer) async {
    return await iDynamicFormAnswerRepository
        .setDynamicFormAnswer(dynamicFormAnswer);
  }
}
