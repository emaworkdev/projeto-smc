// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shots_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ShotsControllerRouter(ShotsController service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.created,
  );
  router.add(
    'POST',
    r'/start',
    service.start,
  );
  router.add(
    'POST',
    r'/pause',
    service.pause,
  );
  router.add(
    'DELETE',
    r'/',
    service.delete,
  );
  return router;
}
