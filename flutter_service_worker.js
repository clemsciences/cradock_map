'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/AssetManifest.bin": "96a353e484586d28d9e39c942bef678f",
"assets/fonts/MaterialIcons-Regular.otf": "def2c998ee400ada7db59b8473498cca",
"assets/AssetManifest.json": "26661b4b0c55b801601f7b35b38b910a",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/focus/2-family/memoire-cradock.jpg": "990b941817c22fbf851cab743a8856f4",
"assets/assets/focus/2-family/merevale-hall.jpg": "688f99044ed7a306d491db5229beca53",
"assets/assets/focus/2-family/merevale-leicester.jpg": "8fa9b7ac51f31d816027812034ffe6bb",
"assets/assets/focus/2-family/cradock-vaccination.jpg": "94f689a558a4675969ecf0cd7ff0693a",
"assets/assets/focus/2-family/gumley-hall.jpg": "a27deb87942ff3a40aa2e61e28423673",
"assets/assets/focus/2-family/the-fall-of-wosley.jpg": "f04b45083a903696f609e05b77179fec",
"assets/assets/focus/2-family/joseph-cradock.gif": "2d2aa58f7e59298b695d06ef4d5f7084",
"assets/assets/focus/2-family/dr-heberden.jpg": "08508127837c63fd2b3693935bcd129a",
"assets/assets/focus/2-family/sepulture-joseph-cradock.jpeg": "215e6795db9c070563562aa299b5f54d",
"assets/assets/focus/2-family/cradock-genealogie.jpg": "d10ce1538206138a4f5da73c80670b42",
"assets/assets/focus/2-family/portrait-cradock.gif": "784a4979c4111b1fc93e9f0075fb784c",
"assets/assets/focus/2-family/saint-martin-leicester.jpg": "13083ce8b3faad386f813f643686221d",
"assets/assets/focus/2-family/lettre-voltaire-j-cradock.jpg": "fd204b3c1755a042614088776414aa93",
"assets/assets/focus/2-family/carte-angleterre.jpeg": "3f3f91131ebe363d6b05d4d16bb8d441",
"assets/assets/focus/2-family/gumley-hall-3.jpg": "2e0cfbcfb3dd9521d85c580deafecd73",
"assets/assets/focus/2-family/gumley-hall-2.jpg": "34560b9aea9539332cbb2b37624c7f94",
"assets/assets/focus/2-family/acte-naissance-anna-francisca-cradock.jpg": "9a893b085014685cfbfb4c507223687e",
"assets/assets/focus/2-family/zobeide.jpeg": "38300ca9a832b7c1908ca3b35a6faf31",
"assets/assets/focus/2-family/distribution-wolsey.jpeg": "f04b45083a903696f609e05b77179fec",
"assets/assets/focus/2-family/anna-francesca-cradock.jpg": "9d04af962d638a4c7a2032ea926dc49d",
"assets/assets/focus/1-edition/1-manuscrit-original-3.png": "11efe533260d570459112ef7333b7159",
"assets/assets/focus/1-edition/1-manuscrit-original-2.png": "e61a66861c8466ae28ae88ce9b4006a1",
"assets/assets/focus/1-edition/1-manuscrit-original-1.png": "809c08504e187049485a16dbb683ebce",
"assets/assets/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution-juin-2023.png": "6cd5e0d0ae153969902f5f17a732efdb",
"assets/assets/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution.png": "2eeff0ee1a7d16efaed7c7e3223ef312",
"assets/assets/icons/SAT-couleur-1000.png": "11f355be629adea9116b05f2ff40c3f6",
"assets/assets/images/extrait.jpg": "020172b478c0b7e8006274cded9a505c",
"assets/assets/images/carrosse.png": "0faa7f344034c851d2bdfe4cf562ec3e",
"assets/assets/images/cassini-tours-langeais.jpg": "4545489701d8b7fb715645698bd242fe",
"assets/NOTICES": "d2704bc9ebe97d8241fd47a546e699cc",
"assets/AssetManifest.bin.json": "8fe257df3332ea080d54c04c11ee2a31",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"manifest.json": "e25bc0789236554ead673d0f6e615cd4",
"index.html": "cadd8a3e44843b88c70579b6766b7b61",
"/": "cadd8a3e44843b88c70579b6766b7b61",
"version.json": "40e96ca93c82dbc480d7e2269aea0771",
"flutter_bootstrap.js": "51d8491d5dec15726acf1df76c3cdaf5",
"main.dart.js": "2cca72228fe6515d68b162d87f55ac8c",
"favicon.png": "48f8301c0e537a00f398f87e4ba2aff8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
