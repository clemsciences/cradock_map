class TileProviderData {
  static const carteEtatMajor19Century =
      "https://data.geopf.fr/wmts?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&LAYER=GEOGRAPHICALGRIDSYSTEMS.ETATMAJOR40&STYLE=normal&TILEMATRIXSET=PM&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&FORMAT=image/jpeg";
  static const openStreetMap = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  static const modelIgn =
      "https://data.geopf.fr/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER={Couche}&STYLE={Style}&FORMAT={format}&TILEMATRIXSET={TileMatrixSet}&TILEMATRIX={TileMatrix}&TILEROW={TileRow}&TILECOL={TileCol}";
}
