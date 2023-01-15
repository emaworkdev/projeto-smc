'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "c81e079634de71df2d0f9e86a1e82dbc",
"assets/assets/images/bg.png": "294f7257cf4fe426e69a99af763786bb",
"assets/assets/images/contact.png": "7b762b5fd522d1bf15390144b5e0b9d7",
"assets/assets/images/email.png": "894f8ac1e78a4cab1991eaa617930a58",
"assets/assets/images/emawork.png": "39aa7211f7d7a4f67354afec88420962",
"assets/assets/images/github.png": "73f6facb5690334ce00e33382c60bda6",
"assets/assets/images/google.png": "66047864288a9df7b69c6bc3c94d16f5",
"assets/assets/images/logo.png": "9f8217f5db7850cd625578c3b73be5a2",
"assets/assets/images/logo36.png": "2dea3a25c661d9a599f6bca0d4540605",
"assets/assets/images/profile.png": "de952863765ad57ebf239dc23f7ab35d",
"assets/assets/images/secret.png": "cd665c8e332598f0f2d231f6df374ed5",
"assets/assets/images/smc.png": "8181536bc455927d7a5c8747ba6c1d60",
"assets/assets/images/Thumbs.db": "6f64ff9850acb0f2d34d93b3b5629557",
"assets/assets/images/youtube.png": "81cea6fc47a319de6ad49c00eda309e4",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "4f6218ab9933338d921470f391e2dbe9",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/rive/error.riv": "e74e21f8b53de4b541dd037c667027c1",
"assets/packages/awesome_dialog/assets/rive/info.riv": "2a425920b11404228f613bc51b30b2fb",
"assets/packages/awesome_dialog/assets/rive/info_reverse.riv": "c6e814d66c0e469f1574a2f171a13a76",
"assets/packages/awesome_dialog/assets/rive/question.riv": "00f02da4d08c2960079d4cd8211c930c",
"assets/packages/awesome_dialog/assets/rive/success.riv": "73618ab4166b406e130c2042dc595f42",
"assets/packages/awesome_dialog/assets/rive/warning.riv": "0becf971559a68f9a74c8f0c6e0f8335",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "99f29024aee8f4672a47cc3a81b9b84a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "48ce1bb8a42776caa951cb782d277730",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d8e9b6203ce2657c991f0b339ccb3a6d",
"assets/packages/getwidget/icons/dribble.png": "1e36936e4411f32b0e28fd8335495647",
"assets/packages/getwidget/icons/facebook.png": "293dc099a89c74ae34a028b1ecd2c1f0",
"assets/packages/getwidget/icons/google.png": "596c5544c21e9d6cb02b0768f60f589a",
"assets/packages/getwidget/icons/line.png": "da8d1b531d8189396d68dfcd8cb37a79",
"assets/packages/getwidget/icons/linkedin.png": "822742104a63a720313f6a14d3134f61",
"assets/packages/getwidget/icons/pinterest.png": "d52ccb1e2a8277e4c37b27b234c9f931",
"assets/packages/getwidget/icons/slack.png": "19155b848beeb39c1ffcf743608e2fde",
"assets/packages/getwidget/icons/twitter.png": "caee56343a870ebd76a090642d838139",
"assets/packages/getwidget/icons/wechat.png": "ba10e8b2421bde565e50dfabc202feb7",
"assets/packages/getwidget/icons/whatsapp.png": "30632e569686a4b84cc68169fb9ce2e1",
"assets/packages/getwidget/icons/youtube.png": "1bfda73ab724ad40eb8601f1e7dbc1b9",
"assets/shaders/ink_sparkle.frag": "a3322434b6400654a06efa4d3b908aad",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.ico": "def635e21256602aabf20f65fc7b986d",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/ico/android-icon-144x144.png": "84f84bfe510647beb2afd227ec6f1c01",
"icons/ico/android-icon-192x192.png": "b8d893d20a0f10067960c0b4172b5cf7",
"icons/ico/android-icon-36x36.png": "2dea3a25c661d9a599f6bca0d4540605",
"icons/ico/android-icon-48x48.png": "3df6fb7f56ec484c518c010f1035fd20",
"icons/ico/android-icon-72x72.png": "7bace07686dad0c8a9e6129b3d795c18",
"icons/ico/android-icon-96x96.png": "c4964d636bee1191bf5007467a55d787",
"icons/ico/apple-icon-114x114.png": "06571fac15b59199dc9cb167ab750b90",
"icons/ico/apple-icon-120x120.png": "ac0806c625b8f6041128b204b3b4dfbb",
"icons/ico/apple-icon-144x144.png": "84f84bfe510647beb2afd227ec6f1c01",
"icons/ico/apple-icon-152x152.png": "95a4fe6ff9777ec3642c6b87dc7c6541",
"icons/ico/apple-icon-180x180.png": "ad607875fadc494e6817dcd793624cb0",
"icons/ico/apple-icon-57x57.png": "8d65f5736da5b0c8607b864fe794b709",
"icons/ico/apple-icon-60x60.png": "41421545de84018b7283ece865b33c3c",
"icons/ico/apple-icon-72x72.png": "7bace07686dad0c8a9e6129b3d795c18",
"icons/ico/apple-icon-76x76.png": "15905e62e7d406777bc256cdd16780ca",
"icons/ico/apple-icon-precomposed.png": "5fd411b9e5aaa7f4c76f1416904b1482",
"icons/ico/apple-icon.png": "5fd411b9e5aaa7f4c76f1416904b1482",
"icons/ico/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/ico/favicon-16x16.png": "fa542c92e6b6ccf45da3acc5f3b9749a",
"icons/ico/favicon-32x32.png": "074876ac9b45ea161da4945676df9832",
"icons/ico/favicon-96x96.png": "c4964d636bee1191bf5007467a55d787",
"icons/ico/favicon.ico": "def635e21256602aabf20f65fc7b986d",
"icons/ico/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/ico/ms-icon-144x144.png": "84f84bfe510647beb2afd227ec6f1c01",
"icons/ico/ms-icon-150x150.png": "0becc20cf5fb2f7610b8ac9eb53bb252",
"icons/ico/ms-icon-310x310.png": "d9eefb0fbbc7fffac2d1707cd5d9a535",
"icons/ico/ms-icon-70x70.png": "f8122e90ed3b768020b3f2c83e84a617",
"icons/Icon-192.png": "38bd2ad2fac7cdc2d36549559a40832b",
"icons/Icon-512.png": "9f8217f5db7850cd625578c3b73be5a2",
"icons/Icon-maskable-192.png": "38bd2ad2fac7cdc2d36549559a40832b",
"icons/Icon-maskable-512.png": "9f8217f5db7850cd625578c3b73be5a2",
"index.html": "9c39f1b8101a490233c15ebac2ebb220",
"/": "9c39f1b8101a490233c15ebac2ebb220",
"main.dart.js": "3d4c2afadaf30db74142db40898f5f36",
"manifest.json": "43d277a6ebf4de365ac85d4217d1d6d6",
"version.json": "7248f230598448f5b9725a7d48c9a061"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
