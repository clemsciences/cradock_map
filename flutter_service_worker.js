'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/images/cassini-tours-langeais.jpg": "4545489701d8b7fb715645698bd242fe",
"assets/assets/images/carrosse.png": "0faa7f344034c851d2bdfe4cf562ec3e",
"assets/assets/images/extrait.jpg": "020172b478c0b7e8006274cded9a505c",
"assets/assets/focus/1-edition/1-manuscrit-original-3.png": "11efe533260d570459112ef7333b7159",
"assets/assets/focus/1-edition/1-manuscrit-original-1.png": "809c08504e187049485a16dbb683ebce",
"assets/assets/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution.png": "2eeff0ee1a7d16efaed7c7e3223ef312",
"assets/assets/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution-juin-2023.png": "6cd5e0d0ae153969902f5f17a732efdb",
"assets/assets/focus/1-edition/1-manuscrit-original-2.png": "e61a66861c8466ae28ae88ce9b4006a1",
"assets/assets/focus/7-hotel-du-faisan/banquet-50-eme-anniversaire.png": "8293712132fe0010d56cc846943d831a",
"assets/assets/focus/7-hotel-du-faisan/1940.png": "d28878b3ca14c7c197aec7d76fb1c12f",
"assets/assets/focus/7-hotel-du-faisan/carte-hotel-du-faisan.png": "339d96063e31d3cbc47ccba49c99c0e6",
"assets/assets/focus/7-hotel-du-faisan/annees-1930.png": "1f78187ef1b060d973019a85c3700250",
"assets/assets/focus/7-hotel-du-faisan/terrier-saint-julien.png": "a5c2389ffea3dea038df3db1dc78f08c",
"assets/assets/focus/5-pont-neuf/projet-rue-neuve-facade.jpg": "118c8b0b3cc117ad673627c6243a3628",
"assets/assets/focus/5-pont-neuf/carte-entree-de-tours.png": "f1b997d59927bead398cb420e60e3e37",
"assets/assets/focus/5-pont-neuf/lithographie-pont.jpg": "6c55d41dce10bb74006fc23d736dae57",
"assets/assets/focus/5-pont-neuf/plan-1756-quais.jpg": "79b1026076941b84ceebf946027c6ef5",
"assets/assets/focus/5-pont-neuf/pont-route-de-saumure.jpg": "f8f463372d59ffea396a0d3775c8457d",
"assets/assets/focus/5-pont-neuf/plan-1756-nord-loire.jpg": "2d1f088f58f9252539f09168fa010481",
"assets/assets/focus/5-pont-neuf/pont-neuf-amont.jpg": "6e23aab9a5c7e869690b804e4740ca1a",
"assets/assets/focus/5-pont-neuf/pont-nord-sud.jpg": "abb4a24c4d3e1b1516210686e26d6eff",
"assets/assets/focus/5-pont-neuf/plan-1756-rue-neuve.jpg": "9fce85ad6f104ad0efdb2416d5c61f64",
"assets/assets/focus/5-pont-neuf/projet-pont-neuf-route-d-espagne.jpg": "fb876cae148b9477a6f0a9d7e3894192",
"assets/assets/focus/9-archeveche/turner-cathedrale-archeveche.jpeg": "586f6255ce90ceee0227a6d30c4bd92a",
"assets/assets/focus/9-archeveche/palais-des-archeveques.jpeg": "25ef1649aefd81b941b72eb7a15ff43e",
"assets/assets/focus/9-archeveche/portail-archeveche.jpg": "66cd37376ca4a0904290fb638219ac8b",
"assets/assets/focus/9-archeveche/moise.png": "ce674442301afdd2d04c251063ad387b",
"assets/assets/focus/9-archeveche/lithographie-gusman.JPG": "f46ede8da943cec11c0e61c8ce49f82f",
"assets/assets/focus/12-saint-martin/carte-saint-martin.png": "9832435893834acee1e0fc93b934c4f5",
"assets/assets/focus/12-saint-martin/grille-ia-3d.png": "c77abe7f8626456d236fe192abc05d6c",
"assets/assets/focus/12-saint-martin/grille-ia-lithographie.png": "e9078b1d5ef1208334defaf04b7c713d",
"assets/assets/focus/12-saint-martin/revismartin-exterieur.png": "f953b729ce2ec465d82adc9fb25d194b",
"assets/assets/focus/12-saint-martin/grille-ia-coupole.png": "cf88a81bb5cccace7b0b7086187333da",
"assets/assets/focus/12-saint-martin/basilique-fin-18e.jpg": "46649295abf44abbe8e9512cecfe53be",
"assets/assets/focus/12-saint-martin/revismartin-interieur.png": "6f3a1463995db7b94c06bd1b4c3ade3b",
"assets/assets/focus/2-family/acte-naissance-anna-francisca-cradock.jpg": "9a893b085014685cfbfb4c507223687e",
"assets/assets/focus/2-family/joseph-cradock.gif": "2d2aa58f7e59298b695d06ef4d5f7084",
"assets/assets/focus/2-family/distribution-wolsey.jpeg": "f04b45083a903696f609e05b77179fec",
"assets/assets/focus/2-family/cradock-genealogie.jpg": "d10ce1538206138a4f5da73c80670b42",
"assets/assets/focus/2-family/merevale-leicester.jpg": "8fa9b7ac51f31d816027812034ffe6bb",
"assets/assets/focus/2-family/carte-angleterre.jpeg": "3f3f91131ebe363d6b05d4d16bb8d441",
"assets/assets/focus/2-family/the-fall-of-wosley.jpg": "f04b45083a903696f609e05b77179fec",
"assets/assets/focus/2-family/portrait-cradock.gif": "784a4979c4111b1fc93e9f0075fb784c",
"assets/assets/focus/2-family/merevale-hall.jpg": "688f99044ed7a306d491db5229beca53",
"assets/assets/focus/2-family/anna-francesca-cradock.jpg": "9d04af962d638a4c7a2032ea926dc49d",
"assets/assets/focus/2-family/dr-heberden.jpg": "08508127837c63fd2b3693935bcd129a",
"assets/assets/focus/2-family/gumley-hall-3.jpg": "2e0cfbcfb3dd9521d85c580deafecd73",
"assets/assets/focus/2-family/gumley-hall.jpg": "a27deb87942ff3a40aa2e61e28423673",
"assets/assets/focus/2-family/memoire-cradock.jpg": "990b941817c22fbf851cab743a8856f4",
"assets/assets/focus/2-family/zobeide.jpeg": "38300ca9a832b7c1908ca3b35a6faf31",
"assets/assets/focus/2-family/saint-martin-leicester.jpg": "13083ce8b3faad386f813f643686221d",
"assets/assets/focus/2-family/cradock-vaccination.jpg": "94f689a558a4675969ecf0cd7ff0693a",
"assets/assets/focus/2-family/gumley-hall-2.jpg": "34560b9aea9539332cbb2b37624c7f94",
"assets/assets/focus/2-family/lettre-voltaire-j-cradock.jpg": "fd204b3c1755a042614088776414aa93",
"assets/assets/focus/2-family/sepulture-joseph-cradock.jpeg": "215e6795db9c070563562aa299b5f54d",
"assets/assets/focus/3-langeais-chateau/gravure-chateau.jpg": "16d80c41f0a33b65978de804804b9ce1",
"assets/assets/focus/3-langeais-chateau/carte-langeais.png": "8cf43a8a0d4a5a81a0ce333d43bdcbfa",
"assets/assets/focus/3-langeais-chateau/carte-cinq-mars.png": "e09b89ac0a02c4b7333a989b359e44f3",
"assets/assets/focus/3-langeais-chateau/pile-de-cinq-mars.png": "d3b94d4e1f2f1ad99729be44a3d139a4",
"assets/assets/focus/3-langeais-chateau/chateau-3.jpg": "18dcdc84b045144e4e820f37a38e4f76",
"assets/assets/focus/3-langeais-chateau/chateau-4.jpg": "7c9daced5924d8eb49b95e1357746b4f",
"assets/assets/focus/3-langeais-chateau/chateau-2.jpg": "d3cca4d129fa3587018ee6d83e1c2999",
"assets/assets/focus/3-langeais-chateau/carte-langeais-tours.png": "501895e7414acd911ab7dba40d43025e",
"assets/assets/focus/6-rue-royale/facades-est-2.jpg": "bfc6b22e39ed1bbbf5a86df3776530b4",
"assets/assets/focus/6-rue-royale/ancien-musee-des-beaux-arts.jpg": "bcb5e2f55e9dd1821ee50fe82254f946",
"assets/assets/focus/6-rue-royale/plan.jpg": "24be7c614db84212c2d8fef6f83c9f89",
"assets/assets/focus/6-rue-royale/rue-royale.jpg": "e163a3b10a42549cbc6fc0b178f4b159",
"assets/assets/focus/6-rue-royale/portes-de-fer-detail.png": "a9286b5ad9b1450ed585a5751b554a00",
"assets/assets/focus/6-rue-royale/portes-de-fer-pringot.jpeg": "f7de7b89894adb14f058e17d90b90e53",
"assets/assets/focus/6-rue-royale/place-jean-jaures-2023.jpg": "3c8cb602913220d8a62a979cb83976c3",
"assets/assets/focus/6-rue-royale/plan-place-sud-1781.png": "a860f9d458417af290a08a44a540d835",
"assets/assets/focus/6-rue-royale/maison-d-enfance-de-balzac.jpg": "e211530372567d05f61af05ff8ab76da",
"assets/assets/focus/6-rue-royale/facades-est-1.jpg": "a602b9c245dcb5023bc058d0ef1df66d",
"assets/assets/focus/4-chaise-de-poste/chaise-de-poste-et-postillon.png": "cafa59c7e2c477784acb7278920a39f3",
"assets/assets/focus/4-chaise-de-poste/chaise-de-poste.jpg": "926ad0d7fd31e6fbafcd42c06f4180b7",
"assets/assets/focus/4-chaise-de-poste/changement-de-chevaux.jpg": "fabf52d34b21f881c738b1e8b74df7ed",
"assets/assets/focus/4-chaise-de-poste/relais-langeais-amboise.png": "8ba20ac0c8e6c0ea18c28cb0ca378752",
"assets/assets/focus/8-cathedrale/cheval-horloge-tours.jpg": "f0199f4a4d8be7a53d97f415abdd73a4",
"assets/assets/focus/8-cathedrale/carte-cathedrale.png": "e52621cff0954c7002e6a1c5d69e8d29",
"assets/assets/focus/8-cathedrale/chevaux-horloge-tours.png": "bcd3ad68b207c69a7580ef3a74af7594",
"assets/assets/focus/8-cathedrale/lettre-signature.jpg": "7e2ea45106e2b4a6297bd0110c2f24a4",
"assets/assets/focus/8-cathedrale/horloge-bourges-mecanisme.JPG": "10df5d12d8702b5a1858dd4dc53be165",
"assets/assets/focus/8-cathedrale/lettre-reparation-horloge.jpg": "3043b2cb3b507a18a95ee9244c8c6c63",
"assets/assets/focus/8-cathedrale/cathedrale.jpg": "beb2a43d23d7d33aa40ac2d28eaaca8b",
"assets/assets/focus/8-cathedrale/horloge-chartres.jpg": "6eda12a5e9b44d6222096b70f8177f3e",
"assets/assets/focus/8-cathedrale/statue-horloge-portative-detail.jpg": "7165301f5f77e7a76893175c9ca5330e",
"assets/assets/focus/8-cathedrale/inscription-le-roy-tours-1698.jpg": "9e55c3a5fae12ee55a311f4e0aa24016",
"assets/assets/focus/8-cathedrale/roue-dentee-le-roy.jpeg": "78f0ee85d140eb79739e9a795b0bce0a",
"assets/assets/focus/8-cathedrale/horloge-chartres-cadran-exterieur.jpg": "eb01e212334a4328ddb950f0ee233917",
"assets/assets/focus/8-cathedrale/horloge-bourges.jpg": "575285e86c38661ca838209895233304",
"assets/assets/focus/8-cathedrale/personnage-horloge-tours-2.jpeg": "744314b8c18e08e73a09f1cc54836b6f",
"assets/assets/focus/8-cathedrale/horloge-chartres-cadran-interieur.jpg": "5af69419ffd09dd3da704ef05323b771",
"assets/assets/focus/8-cathedrale/interieur.jpg": "c9c973d5816464f969651e7ca819d0de",
"assets/assets/focus/8-cathedrale/personnage-horloge-tours-1.jpeg": "4863b9efc4651bba35d740073dbc2c35",
"assets/assets/focus/8-cathedrale/statue-horloge-portative.jpg": "a3b2f3f2a6740cbbb28abfd0a12f6e86",
"assets/assets/focus/8-cathedrale/cavalier-horloge-tours.png": "17f1f144d051a315161aa75a1547f962",
"assets/assets/focus/8-cathedrale/horloge-astronomique-de-lyon.jpg": "c1f8b229db88309f72f31bd75fc38ddb",
"assets/assets/focus/11-mails/passage-rue-neuve-pringot.jpeg": "904f4e35ff079c15be10e7db6cd646d4",
"assets/assets/focus/11-mails/plan-prolongement-mail-detail.png": "6572935ec8b8b08f27b298be9870f252",
"assets/assets/focus/11-mails/carte-mails.png": "7230ea150233457a559fff80cf04a768",
"assets/assets/focus/11-mails/boulevard-heurteloup-parfait.jpeg": "14f0e9612c34f09548780e5e57757e0f",
"assets/assets/focus/11-mails/plan-de-tours-1739.jpg": "d5409a74922c3909378ce735ba86e3fa",
"assets/assets/focus/11-mails/plan-prolongement-mail.jpg": "28a7d4e57064e4ef1dbe700e63d92f18",
"assets/assets/focus/14-chanteloup/carte-chanteloup.png": "ac47a9fcead52f0ed161d6df2438c4a4",
"assets/assets/focus/14-chanteloup/carte-amboise-chanteloup.png": "4c74f801aef2852ad106c5777b2b3a86",
"assets/assets/focus/14-chanteloup/chateau-de-chanteloup-lithographie.JPG": "1b9e0a003beab1b201091afc341b04f1",
"assets/assets/focus/14-chanteloup/chateau-de-chanteloup.JPG": "fb8d53e46f5d5374bae26daf409f3436",
"assets/assets/focus/14-chanteloup/pagode-de-chanteloup.JPG": "4a073819a814ad07e87d96d2fe50954b",
"assets/assets/focus/14-chanteloup/carte-vers-amboise.png": "eb3548daa358f8a256e1717ac304ca57",
"assets/assets/focus/14-chanteloup/manuscrit-chanteloup.jpeg": "6fbc69919107b61536aaf7167647df5e",
"assets/assets/focus/13-marmoutier/pernot-1852.jpg": "901f965ccfb4f023feb58413c8533a21",
"assets/assets/focus/13-marmoutier/rougeot.jpg": "df2564b99768be69ae8ae9682281e18c",
"assets/assets/focus/13-marmoutier/gaignieres-1699.png": "cd8caee6f7dd5c83d07c87606c85dea7",
"assets/assets/focus/13-marmoutier/morillon-1802-2.JPG": "a0401292d79f4e32635fb258fe3998eb",
"assets/assets/focus/13-marmoutier/entree-pringot-1781.jpeg": "36908ba46a585ba2a037a46815b963d5",
"assets/assets/focus/13-marmoutier/carte-marmoutier.png": "10faeb365e5af3e9842b18b6149714cb",
"assets/assets/focus/13-marmoutier/morillon-1802-1.JPG": "0a3286bb5b6e4aa269f439df44ad50c4",
"assets/assets/focus/13-marmoutier/dom-quinquet.jpg": "2bb7d2bacc0d4cd4dc955f557bca99d2",
"assets/assets/focus/10-manuscrits/pentateuque-1.jpeg": "57b2a22119d07feeb76d4e7aca530e12",
"assets/assets/focus/10-manuscrits/evangeliaire-2.png": "057c8646f73dca2017a9a4dcd148eb38",
"assets/assets/focus/10-manuscrits/pentateuque-3.jpeg": "3354d291994ee57a72c349b07504445a",
"assets/assets/focus/10-manuscrits/evangeliaire-1.png": "995c44f5897d4a55a31126ed3a2f353d",
"assets/assets/focus/10-manuscrits/pentateuque-2.jpeg": "27d387ca8db8ba09f5bd212d6d8a33c1",
"assets/assets/icons/SAT-couleur-1000.png": "11f355be629adea9116b05f2ff40c3f6",
"assets/assets/previews/images/carrosse.png": "1ed3c67dbc662787d3f8532dbacd5244",
"assets/assets/previews/focus/1-edition/1-manuscrit-original-1.jpg": "7d864f5bff143c1c98d8124d07d2ea91",
"assets/assets/previews/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution.png": "97c1e918212123c935150db2590de866",
"assets/assets/previews/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution-juin-2023.png": "654fc4f26f02cf6ef0a3c682f2e20cb2",
"assets/assets/previews/focus/1-edition/1-manuscrit-original-3.jpg": "c9b1cedc93e74b2c208d4f5c09c6af9c",
"assets/assets/previews/focus/1-edition/1-manuscrit-original-2.jpg": "173f559fa2e16258950a821bb8f18023",
"assets/assets/previews/focus/7-hotel-du-faisan/banquet-50-eme-anniversaire.png": "97c131ef9b3e88dc8737f2da2aa91c4e",
"assets/assets/previews/focus/7-hotel-du-faisan/1940.png": "fb7d812484acaeef38ff820f9999875d",
"assets/assets/previews/focus/7-hotel-du-faisan/carte-hotel-du-faisan.png": "f1856a1a0d2aba7807a27a304438e06d",
"assets/assets/previews/focus/7-hotel-du-faisan/annees-1930.png": "87f2f3049d70ed963e055875d1749f4c",
"assets/assets/previews/focus/7-hotel-du-faisan/terrier-saint-julien.png": "6e2c689878a01fb9978557cdd2ed2111",
"assets/assets/previews/focus/5-pont-neuf/projet-rue-neuve-facade.jpg": "9ba4d556bdc8963f4c8c67124b4a19c9",
"assets/assets/previews/focus/5-pont-neuf/carte-entree-de-tours.png": "150f027f278156f80d3c42ab3bc720a3",
"assets/assets/previews/focus/5-pont-neuf/lithographie-pont.jpg": "7442b5f14832e31390e6a87107dc6643",
"assets/assets/previews/focus/5-pont-neuf/plan-1756-quais.jpg": "bf1352ba840d92dc58d7024f92539094",
"assets/assets/previews/focus/5-pont-neuf/pont-route-de-saumure.jpg": "2251c9a55f4862511bfdd4ca030c953f",
"assets/assets/previews/focus/5-pont-neuf/plan-1756-nord-loire.jpg": "d979af00e77efbf1e15abed14d6ec93d",
"assets/assets/previews/focus/5-pont-neuf/pont-neuf-amont.jpg": "e9b1164d8b26a878514a7c620c97f383",
"assets/assets/previews/focus/5-pont-neuf/pont-nord-sud.jpg": "c6ccb1de13090607ccdd8555cd39145a",
"assets/assets/previews/focus/5-pont-neuf/plan-1756-rue-neuve.jpg": "64c2d630924ba3b61e3245e05059bbd6",
"assets/assets/previews/focus/5-pont-neuf/projet-pont-neuf-route-d-espagne.jpg": "1b701fe88fdb0d3f4580960839a2aeb8",
"assets/assets/previews/focus/9-archeveche/lithographie-gusman.jpg": "c304c08b3b6ff5f39c0c9156fc33f525",
"assets/assets/previews/focus/9-archeveche/portail-archeveche.jpg": "7df735093bdb3d75ddc5e6c111cbef17",
"assets/assets/previews/focus/9-archeveche/moise.png": "48b6a0b6d5227fc0f9c116e2d8e46b11",
"assets/assets/previews/focus/9-archeveche/turner-cathedrale-archeveche.jpg": "ed033424e33810d82d6e2ec8618a4680",
"assets/assets/previews/focus/9-archeveche/palais-des-archeveques.jpg": "5b3356c477ed96267c3e532f316c8f3a",
"assets/assets/previews/focus/12-saint-martin/grille-ia-3d.jpg": "aa22ff3c2988100c8838d6ed899bb4cf",
"assets/assets/previews/focus/12-saint-martin/carte-saint-martin.png": "54045f95bfdd6bd036e1695e64036b3b",
"assets/assets/previews/focus/12-saint-martin/grille-ia-coupole.jpg": "f9ba3252bfe1e31990f25223e9f2fb6c",
"assets/assets/previews/focus/12-saint-martin/revismartin-exterieur.png": "94d46accadf109c57f8cc141940efa68",
"assets/assets/previews/focus/12-saint-martin/basilique-fin-18e.jpg": "c4c523d24e762cc1a21f09a5749aed0e",
"assets/assets/previews/focus/12-saint-martin/revismartin-interieur.png": "ff432d2a811542171cf886c700dad7bc",
"assets/assets/previews/focus/12-saint-martin/grille-ia-lithographie.jpg": "43f96923294c72f2bc227e0e8d71002b",
"assets/assets/previews/focus/2-family/acte-naissance-anna-francisca-cradock.jpg": "d33fb9fd12ad36aa7fa4f1886df32edb",
"assets/assets/previews/focus/2-family/cradock-genealogie.jpg": "de40dff7d0d56f1fc4b3ec09c8f92334",
"assets/assets/previews/focus/2-family/merevale-leicester.jpg": "fcf9f886d932ede3f8059d8dc6046216",
"assets/assets/previews/focus/2-family/joseph-cradock.png": "4ca503ad29ac2baf3402f7c3912dd079",
"assets/assets/previews/focus/2-family/sepulture-joseph-cradock.jpg": "37ed67feb8889a8bd85650595d5b9130",
"assets/assets/previews/focus/2-family/carte-angleterre.jpg": "fd53cee035edbdeb918cdc5e17ef372d",
"assets/assets/previews/focus/2-family/the-fall-of-wosley.jpg": "72db2b255d956a82b2e362c51b2d9a5e",
"assets/assets/previews/focus/2-family/merevale-hall.jpg": "dc3efac5ab054efd3decd62dc96582d8",
"assets/assets/previews/focus/2-family/anna-francesca-cradock.jpg": "0de66aa4b217ec8274c1e96ca088901f",
"assets/assets/previews/focus/2-family/dr-heberden.jpg": "53f4e1c1986c39754ebfb085ae9a5dc7",
"assets/assets/previews/focus/2-family/portrait-cradock.png": "9501214483bcc65c33a4de0e59ed5b75",
"assets/assets/previews/focus/2-family/gumley-hall-3.jpg": "46f85ef5304d3be966094d103db2bc28",
"assets/assets/previews/focus/2-family/gumley-hall.jpg": "18604a443c054932e37486ad25a24012",
"assets/assets/previews/focus/2-family/zobeide.jpg": "ed022e323c37e097347a6a9666961cc7",
"assets/assets/previews/focus/2-family/memoire-cradock.jpg": "61bf6f69910499e92c318b07c9b368c5",
"assets/assets/previews/focus/2-family/distribution-wolsey.jpg": "72db2b255d956a82b2e362c51b2d9a5e",
"assets/assets/previews/focus/2-family/saint-martin-leicester.jpg": "5b64b9fa3cbb24a7cdb14cdaad9b854b",
"assets/assets/previews/focus/2-family/cradock-vaccination.jpg": "4f956dd50a4c0ba88615136b2fef788d",
"assets/assets/previews/focus/2-family/gumley-hall-2.jpg": "a2386c81bf73ff5a793e68d4aae8c6e3",
"assets/assets/previews/focus/2-family/lettre-voltaire-j-cradock.jpg": "b43dd98b08d39bb78b699493032c89e2",
"assets/assets/previews/focus/3-langeais-chateau/gravure-chateau.jpg": "435fa0be50e45f86f8ec01cd9ae0f76d",
"assets/assets/previews/focus/3-langeais-chateau/carte-langeais.png": "710237c42ea8aab8fedb757008894f7d",
"assets/assets/previews/focus/3-langeais-chateau/carte-cinq-mars.png": "5d258793036d04a0618e55c2f33c70f2",
"assets/assets/previews/focus/3-langeais-chateau/pile-de-cinq-mars.png": "5d285d2102ae14c8f44b820b159113a5",
"assets/assets/previews/focus/3-langeais-chateau/chateau-3.jpg": "6069107bde9d9fa5eaf5323c206a68ae",
"assets/assets/previews/focus/3-langeais-chateau/chateau-4.jpg": "be1629398c6572dfc2f78258e21c5481",
"assets/assets/previews/focus/3-langeais-chateau/chateau-2.jpg": "bc2f8cd15398975da6c3ada45639fc2a",
"assets/assets/previews/focus/3-langeais-chateau/carte-langeais-tours.png": "a58d9d73954094c27ef0dd78918bd0b7",
"assets/assets/previews/focus/6-rue-royale/facades-est-2.jpg": "06aa519a6c1daa6afbfd73b554e5b43f",
"assets/assets/previews/focus/6-rue-royale/ancien-musee-des-beaux-arts.jpg": "cf00dbc7092029be7e42749386a9afe5",
"assets/assets/previews/focus/6-rue-royale/portes-de-fer-pringot.jpg": "a07d56d4930ae0c55f750780dbf4ec51",
"assets/assets/previews/focus/6-rue-royale/plan.jpg": "e8007cdcd12c39d0dd67d75ca6c9eb8b",
"assets/assets/previews/focus/6-rue-royale/rue-royale.jpg": "5daa784a615989d50d697283a24773bd",
"assets/assets/previews/focus/6-rue-royale/portes-de-fer-detail.png": "665c7cc00b536ecf748d52d35327e817",
"assets/assets/previews/focus/6-rue-royale/place-jean-jaures-2023.jpg": "ff4eeb29d29f96857eddc9e2143a2732",
"assets/assets/previews/focus/6-rue-royale/plan-place-sud-1781.png": "3b76ed8a96af80dd384ef233306bf9d0",
"assets/assets/previews/focus/6-rue-royale/maison-d-enfance-de-balzac.jpg": "4f20867b38c54b575b6482875c3532c0",
"assets/assets/previews/focus/6-rue-royale/facades-est-1.jpg": "34a7687a5dccad9ce681405ebc5f8614",
"assets/assets/previews/focus/4-chaise-de-poste/chaise-de-poste-et-postillon.png": "75a2abe32bd5f98746f2ec31f9b5baab",
"assets/assets/previews/focus/4-chaise-de-poste/chaise-de-poste.jpg": "3c513a825fe12ea10e4c0ccf54e8d7a6",
"assets/assets/previews/focus/4-chaise-de-poste/changement-de-chevaux.jpg": "56ff14fb777e289a3db301b597794e1e",
"assets/assets/previews/focus/4-chaise-de-poste/relais-langeais-amboise.png": "4d761d5f84cd16f1f6eb05c9d150750f",
"assets/assets/previews/focus/8-cathedrale/cheval-horloge-tours.jpg": "a2512c9b3a8a4c95ec2fee4352868c55",
"assets/assets/previews/focus/8-cathedrale/horloge-bourges-mecanisme.jpg": "afe9f53d86b314bf3cf852597b8024ce",
"assets/assets/previews/focus/8-cathedrale/carte-cathedrale.png": "f0c8491730a7148055fdfa87a2bd1023",
"assets/assets/previews/focus/8-cathedrale/chevaux-horloge-tours.png": "683e33b342f7bd504a08c4ffa695edec",
"assets/assets/previews/focus/8-cathedrale/roue-dentee-le-roy.jpg": "1dfe60c3ddcd25888260e1912c6cfbd0",
"assets/assets/previews/focus/8-cathedrale/lettre-signature.jpg": "bab62bd10d0410960e47a9468ebf6cf8",
"assets/assets/previews/focus/8-cathedrale/personnage-horloge-tours-2.jpg": "4d65c3d0d3545463a6e2f9666421b68b",
"assets/assets/previews/focus/8-cathedrale/lettre-reparation-horloge.jpg": "d9a6ac53225debe3ef6f5a0836c24936",
"assets/assets/previews/focus/8-cathedrale/cathedrale.jpg": "fed6c8a650853b525a9098d3604e8f81",
"assets/assets/previews/focus/8-cathedrale/horloge-chartres.jpg": "3336360c1767b262c6a64298112f307d",
"assets/assets/previews/focus/8-cathedrale/statue-horloge-portative-detail.jpg": "5cc88172c42b142aca14b3af8fa192f4",
"assets/assets/previews/focus/8-cathedrale/inscription-le-roy-tours-1698.jpg": "cbeb23c0cc70aa7be9220cb223c048fe",
"assets/assets/previews/focus/8-cathedrale/horloge-chartres-cadran-exterieur.jpg": "af52e72cbd4bb332f792c8968f863d5b",
"assets/assets/previews/focus/8-cathedrale/horloge-bourges.jpg": "ade2755694fa85e80a98857993a14ecd",
"assets/assets/previews/focus/8-cathedrale/horloge-chartres-cadran-interieur.jpg": "600a9a42fe2daa95f9e5cb2078c9b9e2",
"assets/assets/previews/focus/8-cathedrale/personnage-horloge-tours-1.jpg": "5ff2364993020bffec2e8aa5056d420a",
"assets/assets/previews/focus/8-cathedrale/interieur.jpg": "1de59118dab9530295a5e70590885a8c",
"assets/assets/previews/focus/8-cathedrale/statue-horloge-portative.jpg": "7cd0c36a678dc213401734b884b8db43",
"assets/assets/previews/focus/8-cathedrale/cavalier-horloge-tours.png": "824d04b5a664a7ee9dcd76d38dd7eaec",
"assets/assets/previews/focus/8-cathedrale/horloge-astronomique-de-lyon.jpg": "5ec32c97ff2302b3e3ebd13f194640b5",
"assets/assets/previews/focus/11-mails/plan-prolongement-mail-detail.png": "db9962593fdfd66b57df62403448bc78",
"assets/assets/previews/focus/11-mails/carte-mails.png": "180222510d08f1dd6ac576ffa0aa0a63",
"assets/assets/previews/focus/11-mails/boulevard-heurteloup-parfait.jpg": "3ec54c5b5b13614691273024549dcb33",
"assets/assets/previews/focus/11-mails/plan-de-tours-1739.jpg": "e26a7453fa972bf16d04110fcf0bc62d",
"assets/assets/previews/focus/11-mails/plan-prolongement-mail.jpg": "12595788c3e49c3587afb81696cb597a",
"assets/assets/previews/focus/11-mails/passage-rue-neuve-pringot.jpg": "4e0311f5b0541cbff17aa149655ce907",
"assets/assets/previews/focus/14-chanteloup/chateau-de-chanteloup.jpg": "e6d752469dce87de4366cecbd95fd50f",
"assets/assets/previews/focus/14-chanteloup/chateau-de-chanteloup-lithographie.jpg": "139407df98913f07a52cbba81345cb35",
"assets/assets/previews/focus/14-chanteloup/carte-chanteloup.png": "393626df4c63d57e75c1dbd1e8f9eb0e",
"assets/assets/previews/focus/14-chanteloup/pagode-de-chanteloup.jpg": "da50783f23cf46c0ca2b03a9abebf4d5",
"assets/assets/previews/focus/14-chanteloup/carte-amboise-chanteloup.png": "43c1baaa09abbe9d99bc0c2ccd5928ef",
"assets/assets/previews/focus/14-chanteloup/manuscrit-chanteloup.jpg": "93670d2ea42d76fc74a13d7ec15ec033",
"assets/assets/previews/focus/14-chanteloup/carte-vers-amboise.png": "d1cb7db4b877c6faf94cfd5124e66ba3",
"assets/assets/previews/focus/13-marmoutier/pernot-1852.jpg": "0dbe6d1804c73db91eea17b6b4b8d8f7",
"assets/assets/previews/focus/13-marmoutier/rougeot.jpg": "5f5b10f150ddfa85ed81a787df8d49d1",
"assets/assets/previews/focus/13-marmoutier/gaignieres-1699.png": "e0479f36158a97ccee1ea6d7f53aed91",
"assets/assets/previews/focus/13-marmoutier/entree-pringot-1781.jpg": "f723061869b425b431f39e1d9aacb42c",
"assets/assets/previews/focus/13-marmoutier/carte-marmoutier.png": "21b48f132268dfc020e31279323a4f4b",
"assets/assets/previews/focus/13-marmoutier/morillon-1802-1.jpg": "a96d5eb6678d4a75df4d97187b4cbd00",
"assets/assets/previews/focus/13-marmoutier/morillon-1802-2.jpg": "3508e5de5996bf9731534cde39f15650",
"assets/assets/previews/focus/13-marmoutier/dom-quinquet.jpg": "149d8adabce1ac334bc39167fc75d2ea",
"assets/assets/previews/focus/10-manuscrits/pentateuque-2.jpg": "0645eaec87a44b70b1bd7f033d5821b2",
"assets/assets/previews/focus/10-manuscrits/pentateuque-1.jpg": "92d10d44b1b89f7a86d74be8711beaed",
"assets/assets/previews/focus/10-manuscrits/evangeliaire-2.png": "c4ca66e1653744917c8bf0b5880ff695",
"assets/assets/previews/focus/10-manuscrits/evangeliaire-1.png": "a398132ae009bcb9e85daaa3bbec42a9",
"assets/assets/previews/focus/10-manuscrits/pentateuque-3.jpg": "84b7603727fcd4d89bf457ee58c1150d",
"assets/assets/data/communes.geojson": "094b856cf6c49fc12141b8b3f24974b4",
"assets/NOTICES": "809849b1a663961ae5c2868678d0a0b0",
"assets/fonts/MaterialIcons-Regular.otf": "d1210cdc228adec55d0b3c256d557a72",
"assets/AssetManifest.json": "00ab8c90bdf600dd318048e47d358913",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "035f58811ffa1a2213666afe4193934f",
"assets/AssetManifest.bin": "b18f1fa991135dec07f3060c0b5443a7",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/SAT-couleur-1000.png": "11f355be629adea9116b05f2ff40c3f6",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "48f8301c0e537a00f398f87e4ba2aff8",
"manifest.json": "e2cecf5e19b5d43d43687fa3c59510a2",
"main.dart.js": "a0f811fabc862719d65a3c764cc28567",
"splash/img/light-2x.png": "4873afcfc84e5020ef0b75a6fa26e596",
"splash/img/light-1x.png": "eec54f5e2fcb72aafd797b873f4c2f8c",
"splash/img/dark-4x.png": "02e88731b8ea1df33bcbe01c8e2fe43d",
"splash/img/light-4x.png": "02e88731b8ea1df33bcbe01c8e2fe43d",
"splash/img/dark-1x.png": "eec54f5e2fcb72aafd797b873f4c2f8c",
"splash/img/dark-3x.png": "1145ef61f62a883ef6e0904e49f09ede",
"splash/img/light-3x.png": "1145ef61f62a883ef6e0904e49f09ede",
"splash/img/dark-2x.png": "4873afcfc84e5020ef0b75a6fa26e596",
"index.html": "8390037f3be34621c7e97d83cc1fce3b",
"/": "8390037f3be34621c7e97d83cc1fce3b",
"version.json": "bf45f0194110849fc1961003d09010dd",
"flutter_bootstrap.js": "78da431ccdb2b05f60ce436084c71d3f"};
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
