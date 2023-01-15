// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_hook_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$WebHookControllerRouter(WebHookController service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.webkook,
  );
  router.add(
    'POST',
    r'/secunds',
    service.webkookBayleys,
  );
  return router;
}
