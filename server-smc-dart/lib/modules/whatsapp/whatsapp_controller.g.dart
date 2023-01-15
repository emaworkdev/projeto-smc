// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whatsapp_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$WhatsappControllerRouter(WhatsappController service) {
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
  router.add(
    'POST',
    r'/start',
    service.start,
  );
  router.add(
    'POST',
    r'/close',
    service.close,
  );
  router.add(
    'POST',
    r'/logout',
    service.logout,
  );
  return router;
}
