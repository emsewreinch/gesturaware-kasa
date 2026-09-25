# gesturaware-kasa

GesturAware cihazinin 3D baski kasasi (OpenSCAD).

## Dosyalar

- `Cihazkasaguncel.scad` - iki parcali kasa (ust + alt), birlesik dosya. `goster` degiskeni ile gorunum secilir ("ust" / "alt" / "baski" / "acilim" / "montaj").
- `cihazkasaguncelust.scad` - ust kasa (tek parca, baski icin)
- `cihazkasaguncelalt.scad` - alt kapak (tek parca, baski icin)
- `cihaz_kasasi.scad`, `yenikasaa_ust.scad`, `yenikasaa_alt.scad` - onceki tasarim iterasyonlari

## Ozellikler

- Apple / minimalist tarz, duz ust yuzey
- Ortada 12 mm buton deligi
- On (-Y) duvarda USB-C acikligi (merkeze gore 1 mm saga kaydirilmis)
- Vidasiz snap kenetlenme: alt kapak lip'i uzerinde detent toplari, ust kasa ic duvarinda eslesen yuvalar. Sikilik `snap_int` ile ayarlanir.

## Kullanim

OpenSCAD ile ac, F5 onizleme / F6 render, sonra STL disa aktar (F7).

Dis olculer: ~64.7 x 53.5 x 20.6 mm.
