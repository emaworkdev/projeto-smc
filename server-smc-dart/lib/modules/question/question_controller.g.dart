// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$QuestionControllerRouter(QuestionController service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.created,
  );
  router.add(
    'DELETE',
    r'/',
    service.delete,
  );
  return router;
}
