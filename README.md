# Daryo-Mobile

Daryo.uz yangiliklar portalining Flutter'da yozilgan mobil ilovasi (Android va iOS).

- **Versiya:** 5.1.4+1047
- **API:** `https://data.daryo.uz/api/v1/`
- **Figma:** https://www.figma.com/file/BLBEOyuhKsiB1NwHDY8mh2/Online-Bazar?type=design&node-id=1329-3710&mode=design&t=4xPSedqYRyHEpZkY-0

## Imkoniyatlar

- Yangiliklar lentasi, tavsiyalar, kategoriyalar va hashtag bo'yicha qidiruv
- Yangilik tafsilotlari, videolar (YouTube) va Daryo FM
- Yangiliklar tarixi, taqvim, sevimlilar va viktorinalar
- Ro'yxatdan o'tish, Google / Facebook orqali kirish (Firebase Auth)
- Push-bildirishnomalar (Firebase Cloud Messaging)
- To'rt til: o'zbek (lotin va kirill), rus, ingliz
- Shorebird orqali code push yangilanishlari

## Texnologiyalar

| Soha | Kutubxonalar |
| --- | --- |
| State management | `flutter_bloc`, `bloc`, `freezed` |
| DI | `get_it` |
| Navigatsiya | `auto_route` |
| Tarmoq | `dio`, `pretty_dio_logger` |
| Lokal ma'lumotlar | `floor`, `sqflite` |
| Lokalizatsiya | `easy_localization` (CSV) |
| UI | `flutter_screenutil`, `flutter_svg`, `cached_network_image`, `shimmer` |
| Firebase | `firebase_core`, `firebase_auth`, `firebase_messaging` |

## Loyiha tuzilmasi

```
lib/
├── core/            # kesh, enum, extension'lar, generatsiya qilingan asset'lar
├── data/            # datasource (network, db), repository'lar, mapper'lar
├── domain/          # modellar va mapper'lar
├── presentation/
│   ├── application/ # ilova ildizi va DI (get_it)
│   ├── features/    # ekranlar: auth, home, detail, common, common_daryo
│   ├── router/      # auto_route marshrutlari
│   └── widgets/     # umumiy widget'lar
└── main.dart
assets/
├── localization/translations.csv
├── fonts/           # Inter
└── images*/
```

## Ishga tushirish

Flutter versiyasi [FVM](https://fvm.app) orqali qotirilgan (`.fvmrc` → **3.29.3**).

```bash
# 1. Flutter SDK'ni o'rnatish
fvm install

# 2. Paketlarni yuklash
fvm flutter pub get

# 3. Kod generatsiyasi (freezed, json_serializable, auto_route, floor)
fvm dart run build_runner build --delete-conflicting-outputs

# 4. Ishga tushirish
fvm flutter run
```

> `*.g.dart`, `*.freezed.dart` va `*.gr.dart` fayllari git'ga qo'shilmaydi, shuning uchun
> repo'ni klon qilgandan keyin 3-qadamni albatta bajaring.

## Release build

Imzolash kaliti (`*.jks`) va sertifikatlar (`*.pem`) repo'da saqlanmaydi. Ularni jamoadan oling
va lokal joylashtiring.

```bash
fvm flutter build appbundle --release   # Android
fvm flutter build ipa --release         # iOS
```

Shorebird orqali release va patch:

```bash
shorebird release android
shorebird patch android
```
