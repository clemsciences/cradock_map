#!/usr/bin/env python3
"""Downloads the current boundaries of the communes around the itinerary.

Source: IGN ADMIN EXPRESS COG (full-precision edition of the Code officiel
géographique, not the simplified "CARTO" one), served by the Géoplateforme WFS.
Licence: Etalab Open Licence 2.0 — attribution "IGN – ADMIN EXPRESS".

Usage (from the project root):
    python3 tool/fetch_communes.py
Writes assets/data/communes.geojson. Geometries are kept as-is, only the
coordinates are rounded to 6 decimals (about 10 cm).
"""

import json
import urllib.parse
import urllib.request
from pathlib import Path

# The edition is pinned so that the bundled data is reproducible; bump it when
# a new COG is published (see the WFS GetCapabilities for available years).
EDITION = "2026"
LAYER = f"ADMINEXPRESS-COG.{EDITION}:commune"
# Area of the whole itinerary (Langeais -> Tours -> Amboise: track, steps and
# post houses span lat 47.33-47.42, lon 0.41-0.99) with a margin:
# lat_min, lon_min, lat_max, lon_max.
BBOX = (47.25, 0.33, 47.50, 1.06)
OUTPUT = Path(__file__).resolve().parent.parent / "assets" / "data" / "communes.geojson"


def round_coordinates(value):
    if isinstance(value, float):
        return round(value, 6)
    return [round_coordinates(v) for v in value]


def main():
    params = {
        "SERVICE": "WFS",
        "VERSION": "2.0.0",
        "REQUEST": "GetFeature",
        "TYPENAMES": LAYER,
        "OUTPUTFORMAT": "application/json",
        "SRSNAME": "EPSG:4326",
        "BBOX": ",".join(str(v) for v in BBOX) + ",urn:ogc:def:crs:EPSG::4326",
        "COUNT": "1000",
    }
    url = "https://data.geopf.fr/wfs/ows?" + urllib.parse.urlencode(params)
    with urllib.request.urlopen(url, timeout=120) as response:
        data = json.load(response)

    features = [
        {
            "type": "Feature",
            "properties": {
                "nom": feature["properties"]["nom_officiel"],
                "code_insee": feature["properties"]["code_insee"],
            },
            "geometry": {
                "type": feature["geometry"]["type"],
                "coordinates": round_coordinates(feature["geometry"]["coordinates"]),
            },
        }
        for feature in sorted(data["features"], key=lambda f: f["properties"]["code_insee"])
    ]
    collection = {
        "type": "FeatureCollection",
        "source": f"IGN – ADMIN EXPRESS COG {EDITION}",
        "licence": "Licence Ouverte Etalab 2.0",
        "features": features,
    }
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(collection, ensure_ascii=False, separators=(",", ":")))
    print(f"{len(features)} communes -> {OUTPUT}")


if __name__ == "__main__":
    main()
