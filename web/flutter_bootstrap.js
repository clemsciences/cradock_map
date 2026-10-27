// Startup of the Flutter web app with a visible status under the SAT logo
// (see #app-loader in index.html): the first visit downloads several MB.
{{flutter_js}}
{{flutter_build_config}}

(function () {
  const loader = document.getElementById("app-loader");
  const text = document.getElementById("app-loader-text");

  function setStatus(message) {
    if (text) text.textContent = message;
  }

  // The app covers the logo with its first frame: the indicator goes away then.
  window.addEventListener("flutter-first-frame", function () {
    loader?.remove();
    // The app has its own accessibility tree: the text of the page must not
    // be read twice (it stays in the page for search engines).
    document.getElementById("page-content")?.setAttribute("aria-hidden", "true");
  }, { once: true });

  // A script that fails to download (main.dart.js, CanvasKit) does not reject
  // the loader's promise: its "error" event only reaches window in capture.
  window.addEventListener("error", function (event) {
    if (event.target instanceof HTMLScriptElement) showError(event.target.src);
  }, true);

  setStatus("Téléchargement de l'application…");
  _flutter.loader.load({
    // The rendering engine is served with the site rather than by Google's CDN
    // (fewer third parties, see the legal notice).
    config: { canvasKitBaseUrl: "canvaskit/" },
    onEntrypointLoaded: async function (engineInitializer) {
      try {
        setStatus("Préparation de l'affichage…");
        const appRunner = await engineInitializer.initializeEngine();
        setStatus("Ouverture du site…");
        await appRunner.runApp();
      } catch (error) {
        showError(error);
      }
    },
  }).catch(showError);

  function showError(error) {
    if (!loader?.isConnected) return; // the app is already displayed
    console.error("Startup failed:", error);
    loader?.classList.add("error");
    setStatus("Le site n'a pas pu se charger. Vérifiez votre connexion puis rechargez la page.");
  }
})();
