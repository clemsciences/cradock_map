import "package:web/web.dart" as web;

const bool canOpen = true;

void open(String url) {
  web.window.open(url, "_blank", "noopener");
}
