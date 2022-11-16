import '../model/dynamic_form_answer.dart';

abstract class IDynamicFormAnswerRepository {
  //
  Future<bool> setDynamicFormAnswer(List<DynamicFormAnswer> dynamicFormAnswer);
}
