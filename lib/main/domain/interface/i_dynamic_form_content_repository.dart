import '../model/dynamic_form_content.dart';

abstract class IDynamicFormContentRepository {
  Future<List<DynamicFormContent>> getDynamicFormContent(String idForm);
}
