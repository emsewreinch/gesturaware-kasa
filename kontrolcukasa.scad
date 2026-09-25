// =============================================================
// GesturAware - KONTROLCU KASASI (Controller Edition)
//
// Oyun kontrolcusunun arkasina takilan premium kasa.
// Dis olculer Cihazkasaguncel.scad ile AYNI: 64.74 x 53.5 x 20.6 mm.
// PCB, USB-C, buton, LED, sensor ve reset konumlari da ayni.
//
// 3 parca, hepsi destek (support) olmadan basilir:
//
//   KAPAK : ust parca. 45 derece pahli ust kenar, buton cevresinde
//           hale halkasi ve iki yanda "(( o ))" jest dalgalari (oyma).
//           Ic dudak govdeye girer, snap toplariyla kilitlenir ve
//           tirnaklariyla PCB'yi yukaridan bastirir.
//   GOVDE : alt parca. USB-C, LED, sensor/reset delikleri, PCB rafi.
//           Sol/sag alt kenarlarda kirlangic (dovetail) kizak profili.
//   KIZAK : kontrolcunun arkasina VHB bantla yapisan ince taban.
//           Kasa arkadan kaydirilir, onde durur, esnek parmaklar
//           "klik" ile kilitler. Cekince cikar (sarj / reset icin).
//
// Tum olculer mm. Z=0 kasanin (govdenin) en alti.
// USB-C on (-Y), LED arka (+Y) duvarda.
// =============================================================

$fa = 4;
$fs = 0.35;


// =============================================================
// BILESEN / PCB OLCULERI  (Cihazkasaguncel.scad ile ayni)
// =============================================================

pcb_edge_usb = 40.5;       // PCB X boyu
pcb_depth    = 46.5;       // PCB Y boyu
pcb_thick    = 1.6;
pcb_comp_h   = 10;         // PCB ustu maksimum komponent yuksekligi

hole_ax = 17;              // PCB montaj delikleri X yari-araligi
hole_ay = 19.5;            // PCB montaj delikleri Y yari-araligi

usb_edge_off = 8.62;       // USB konnektorunun PCB merkezinden X kacikligi
usb_cx       = 1;          // USB-C acikligi kasa merkezine gore +1 mm

usb_w     = 9.2;           // USB-C acikligi X
usb_bos_h = 3.4;           // USB-C acikligi Z
usb_alt   = 4;             // acikligin alt kenari (tabandan)
usb_r     = 1.7;

usb_agiz_w     = 10.5;     // on agiz (kablo govdesi) flare
usb_agiz_h     = 7.0;
usb_agiz_r     = 2.5;
usb_agiz_derin = 2;

side_clr  = 1.5;           // PCB - ic duvar yan boslugu
head_gap  = 3.0;           // komponent ustu bosluk
floor_gap = 2.0;           // PCB alti bosluk

et = 2;                    // duvar kalinligi

buton_cap = 12;            // ust buton deligi
buton_x   = 0;
buton_y   = 0;

sensor_cap = 5.0;          // alt sensor deligi
reset_cap  = 1.0;          // alt reset deligi

led_cap = 5.0;             // arka 5 mm LED
led_x   = 18;
led_z   = 10;


// =============================================================
// TURETILEN OLCULER  (Cihazkasaguncel.scad ile ayni formuller)
// =============================================================

bd_cx   = -usb_edge_off;                  // PCB merkezi X
board_l = bd_cx - pcb_edge_usb / 2;       // -28.87
board_r = bd_cx + pcb_edge_usb / 2;       //  11.63

half_in  = max(-board_l, board_r) + side_clr;
uzunluk  = 2 * (half_in + et);            // 64.74  (X)
inner_y  = pcb_depth + 2 * side_clr;
genislik = inner_y + 2 * et;              // 53.5   (Y)

inner_h     = floor_gap + pcb_thick + pcb_comp_h + head_gap;
toplam_yuks = inner_h + 2 * et;           // 20.6   (Z)

z_rest    = et + floor_gap;               // PCB alt yuzu  (4.0)
z_pcb_top = z_rest + pcb_thick;           // PCB ust yuzu  (5.6)
tavan_z   = toplam_yuks - et;             // tavan ic yuzu (18.6)

usb_z0 = usb_alt;
usb_z1 = usb_alt + usb_bos_h;

hx = uzunluk / 2;                         // dis yari X
hy = genislik / 2;                        // dis yari Y
ix = hx - et;                             // ic yari X
iy = hy - et;                             // ic yari Y


// =============================================================
// TASARIM
// =============================================================

kose_r  = 6;      // plan kose radiusu. 8 -> 6: ic kose r=4 olur, PCB'nin
                  // keskin koseleri bile duvara degmez (0.46 mm pay).
ic_r    = kose_r - et;

ust_pah = 2.0;    // ust kenar 45 derece pah (bed'e bakan yuz, destek gerekmez)
ek_z    = 13;     // kapak/govde birlesimi. USB-C ve LED tamamen govdede kalir.
ek_pah  = 0.6;    // birlesim cizgisindeki V-oluk (golge cizgisi)
giris_pah = 0.5;  // govde ust ic kenari: kapak dudagi icin giris pahi
alt_pah = 0.8;    // on / arka alt kenar pahi

// kapak ic pahi: pah boyunca da duvar kalinligi = et kalsin
ic_pah = max(ust_pah - et * (2 - sqrt(2)), 0.2);


// -------------------------------------------------------------
// Ust yuzey oymalari (kapak ters basildigi icin ilk katmanlarda)
// Renk hilesi: 3. katmanda filament degistir (M600), 4. katmanda
// geri al -> oyuklar renkli gorunur. Cok renkli yazicida "inlay".
// -------------------------------------------------------------

oyma_on    = true;
oyma_derin = 0.4;                 // 2 katman (0.2 mm katmanla)

hale_r = 9;                       // buton cevresi halka (orta cizgi)
hale_w = 0.8;

dalga_r   = [13, 16.5, 20];       // "(( o ))" jest dalgalari
dalga_w   = 0.8;
dalga_aci = 34;                   // her yayin yari acisi (derece)

buton_pah = 0.4;                  // buton deligi ust kenar pahi


// -------------------------------------------------------------
// Kapak ic dudagi + PCB bastirma tirnaklari
// Dudak govde duvari ile PCB kenari arasindaki 1.5 mm bantta durur:
// 0.2 bosluk + 1.0 dudak + 0.3 PCB payi.
// -------------------------------------------------------------

dudak_et     = 1.0;
dudak_bosluk = 0.2;
pcb_ust_pay  = 0.1;               // dudak alti / tirnak ile PCB ustu arasi

tirnak_on       = true;           // PCB bastirma tirnaklari
tirnak_w        = 4;
tirnak_bindirme = 0.7;            // PCB kenarinin ustune binme
// montaj deliklerinin yanina (bakir/komponent bosluk bolgesi)
tirnak_x = [bd_cx - hole_ax + 1, bd_cx + hole_ax + 0.6];

dudak_dis_x = ix - dudak_bosluk;
dudak_dis_y = iy - dudak_bosluk;
dudak_ic_x  = dudak_dis_x - dudak_et;
dudak_ic_y  = dudak_dis_y - dudak_et;
dudak_alt   = z_pcb_top + pcb_ust_pay;
dudak_r     = ic_r - dudak_bosluk;


// -------------------------------------------------------------
// PCB rafi: PCB kenarlarini alttan tasir (sol, on, arka, sag kenar).
// Ic cubuk / kolon yok.
// -------------------------------------------------------------

raf_bindirme = 1.0;               // rafin PCB kenarinin altina girmesi
raf_usb_w    = 12;                // USB konnektoru altinda raf yok


// -------------------------------------------------------------
// Snap - vidasiz kenetlenme (eski dosyadaki ile ayni mantik)
// Kapak dudagindaki toplar, govde ic duvarindaki yuvalara oturur.
// -------------------------------------------------------------

snap_on       = true;
snap_x        = [-20, 24];        // on ve arka duvarda X konumlari
snap_z        = 10;
snap_d        = 2.4;
snap_pocket_d = 2.9;
snap_int      = 0.4;              // sikilik - artir = daha sert klik


// -------------------------------------------------------------
// Kizak (dovetail) profili: govdenin sol/sag alt kenarlari
// Z=0'da kz_taban, Z=kz_h'de kz_boyun kadar iceri kacar (alttan
// kavrama), sonra 45 derece pahla tam genislige doner.
// Oluk on yuzden kz_dur_y'ye kadar gider; arka blok tam kalir ve
// kizagin durdurucusu olur.
// -------------------------------------------------------------

kz_h      = 3.0;
kz_taban  = 1.0;
kz_boyun  = 2.2;
kz_ust    = kz_h + kz_boyun;      // pahin bittigi Z
kz_dur_y  = 20;                   // olugun bittigi Y (arka blok baslangici)


// -------------------------------------------------------------
// Kizak (kontrolcu adaptoru)
// -------------------------------------------------------------

ad_taban    = 2.4;                // taban kalinligi
ad_bosluk   = 0.15;               // ray - govde boslugu
ad_ray_ust  = kz_ust - 0.8;       // ray ustu: govde pahini doldurur, 0.8 mm V-cizgi kalir
ad_sikistir = 0.3;                // taban tumsekleri: tikirtiyi alir (0 = kapali)
ad_sensor   = true;               // sensor deligi hizasinda pencere

kilit_y      = -14;               // klik kilidi Y konumu
kilit_derin  = 0.5;               // govdedeki V-centik derinligi
kilit_sirt   = 0.6;               // parmaktaki V-sirt yuksekligi
parmak_l     = 16;                // esnek parmak boyu
parmak_kesim = 0.6;               // parmak kesim araligi


// -------------------------------------------------------------
// Alt yazi (govde tabaninda, disaridan okunur)
// -------------------------------------------------------------

yazi_on   = true;
yazi      = "GESTURAWARE";
yazi_boy  = 3.2;
yazi_y    = -9;
yazi_font = "Liberation Sans:style=Bold";


// =============================================================
// YARDIMCI MODULLER / FONKSIYONLAR
// =============================================================

module rrect(l, w, r)
{
    rr = max(min(r, l / 2, w / 2), 0.1);

    hull()
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * (l / 2 - rr), sy * (w / 2 - rr)])
                circle(r = rr);
}


module rdilim(l, w, r, z)
{
    translate([0, 0, z])
        linear_extrude(height = 0.01)
            rrect(l, w, r);
}


// kizak cizgisinin (dovetail) Z'ye gore yari genisligi
function kz_lin(z) = (hx - kz_taban) - (kz_boyun - kz_taban) * z / kz_h;


// XZ profilini Y boyunca uzatan prizma
module xz_prizma(noktalar)
{
    rotate([90, 0, 0])
        linear_extrude(height = genislik + 40, center = true)
            polygon(noktalar);
}


// yay bandi, +X ekseni etrafinda -a..+a derece, uclari yuvarlak
module yay2d(r, w, a)
{
    R = 2 * (r + w);

    intersection()
    {
        difference()
        {
            circle(r = r + w / 2, $fn = 200);
            circle(r = r - w / 2, $fn = 200);
        }

        polygon(concat([[0, 0]], [for (t = [-a : 2 : a]) [R * cos(t), R * sin(t)]]));
    }

    for (s = [-1, 1])
        rotate(s * a)
            translate([r, 0])
                circle(d = w, $fn = 24);
}


// =============================================================
// KAPAK (UST PARCA)
// =============================================================

module kapak()
{
    union()
    {
        difference()
        {
            kapak_dis();
            kapak_ic();
            buton_bosluk();

            if (oyma_on)
                ust_oyma();
        }

        dudak();
    }
}


module kapak_dis()
{
    hull()
    {
        // alt kenar: birlesim V-olugunun ust yarisi
        rdilim(uzunluk - 2 * ek_pah, genislik - 2 * ek_pah, kose_r - ek_pah, ek_z);

        translate([0, 0, ek_z + ek_pah])
            linear_extrude(height = toplam_yuks - ust_pah - ek_z - ek_pah)
                rrect(uzunluk, genislik, kose_r);

        // ust yuzey (45 derece pah)
        rdilim(uzunluk - 2 * ust_pah, genislik - 2 * ust_pah, kose_r - ust_pah,
               toplam_yuks - 0.01);
    }
}


module kapak_ic()
{
    hull()
    {
        translate([0, 0, ek_z - 1])
            linear_extrude(height = tavan_z - ic_pah - (ek_z - 1))
                rrect(2 * ix, 2 * iy, ic_r);

        rdilim(2 * (ix - ic_pah), 2 * (iy - ic_pah), ic_r - ic_pah, tavan_z - 0.01);
    }
}


module buton_bosluk()
{
    translate([buton_x, buton_y, tavan_z - 0.1])
        cylinder(h = et + 0.2, d = buton_cap);

    // ust kenar pahi
    translate([buton_x, buton_y, toplam_yuks - buton_pah])
        cylinder(h = buton_pah + 0.01, d1 = buton_cap, d2 = buton_cap + 2 * buton_pah + 0.02);
}


module ust_oyma_2d()
{
    // hale halkasi
    difference()
    {
        circle(r = hale_r + hale_w / 2, $fn = 160);
        circle(r = hale_r - hale_w / 2, $fn = 160);
    }

    // "(( o ))" jest dalgalari - sol ve sag
    for (a = [0, 180])
        rotate(a)
            for (r = dalga_r)
                yay2d(r, dalga_w, dalga_aci);
}


// oyma hacmi (kapaktan cikarilir; cok renkli baskida inlay parcasi)
module ust_oyma()
{
    translate([buton_x, buton_y, toplam_yuks - oyma_derin])
        linear_extrude(height = oyma_derin + 0.01)
            ust_oyma_2d();
}


// -------------------------------------------------------------
// Ic dudak: govdenin icine girer. Ust ucu 45 derece omuzla kapak
// duvarina baglanir (ters baskida sarkma olmaz).
// -------------------------------------------------------------

module dudak()
{
    omuz = dudak_et + dudak_bosluk;

    difference()
    {
        union()
        {
            translate([0, 0, dudak_alt])
                linear_extrude(height = ek_z - dudak_alt + 0.01)
                    rrect(2 * dudak_dis_x, 2 * dudak_dis_y, dudak_r);

            translate([0, 0, ek_z])
                linear_extrude(height = omuz + 0.3)
                    rrect(2 * ix + 0.02, 2 * iy + 0.02, ic_r + 0.01);
        }

        translate([0, 0, dudak_alt - 1])
            linear_extrude(height = ek_z - dudak_alt + 1.01)
                rrect(2 * dudak_ic_x, 2 * dudak_ic_y, dudak_r - dudak_et);

        // 45 derece omuz: dudak ic yuzunden kapak ic duvarina
        hull()
        {
            rdilim(2 * dudak_ic_x, 2 * dudak_ic_y, dudak_r - dudak_et, ek_z);

            translate([0, 0, ek_z + omuz])
                linear_extrude(height = 1)
                    rrect(2 * ix, 2 * iy, ic_r);
        }

        // USB-C konnektoru icin centik
        translate([usb_cx - 5.5, -hy, dudak_alt - 1])
            cube([11, 5, usb_z1 + 1 - (dudak_alt - 1)]);

        // LED govdesi / flansi icin centik
        translate([led_x - 3.5, hy - 5, dudak_alt - 1])
            cube([7, 5, ek_z - (dudak_alt - 1)]);
    }

    snap_toplari();

    if (tirnak_on)
        pcb_tirnaklari();
}


module snap_toplari()
{
    if (snap_on)
        for (sx = snap_x, sy = [-1, 1])
            intersection()
            {
                translate([sx, sy * (iy + snap_int - snap_d / 2), snap_z])
                    sphere(d = snap_d, $fn = 32);

                // sadece disa dogru cikan kisim (PCB tarafina tasmaz)
                translate([sx - snap_d, sy > 0 ? dudak_ic_y : -hy - 1, snap_z - snap_d])
                    cube([2 * snap_d, hy + 1 - dudak_ic_y, 2 * snap_d]);
            }
}


// PCB'yi raf uzerine bastiran kucuk tirnaklar (ustu 45 derece)
module pcb_tirnaklari()
{
    y_uc = pcb_depth / 2 - tirnak_bindirme;
    y_kok = dudak_ic_y + 0.01;
    h0 = 0.2;

    for (tx = tirnak_x, m = [0, 1])
        mirror([0, m, 0])
            translate([tx, 0, 0])
                rotate([90, 0, 90])
                    linear_extrude(height = tirnak_w, center = true)
                        polygon([
                            [y_kok, dudak_alt],
                            [y_uc,  dudak_alt],
                            [y_uc,  dudak_alt + h0],
                            [y_kok, dudak_alt + h0 + (y_kok - y_uc)]
                        ]);
}


// =============================================================
// GOVDE (ALT PARCA)
// =============================================================

module govde()
{
    difference()
    {
        union()
        {
            difference()
            {
                govde_dis();
                govde_ic();
            }

            // raf, kizak bolgesinde dis yuzeyden tasmasin
            intersection()
            {
                pcb_raf();
                govde_dis();
            }
        }

        usb_bosluk();
        led_delik();
        snap_cepleri();
        kilit_centikleri();

        // sensor deligi
        translate([0, 0, -1])
            cylinder(h = et + 2, d = sensor_cap);

        // reset deligi
        translate([bd_cx, -hole_ay - 2, -1])
            cylinder(h = et + 2, d = reset_cap, $fn = 24);

        if (yazi_on)
            alt_yazi();
    }
}


module govde_dis()
{
    difference()
    {
        hull()
        {
            // alt: on/arka kenarlarda pah
            rdilim(uzunluk, genislik - 2 * alt_pah, kose_r, 0);

            translate([0, 0, alt_pah])
                linear_extrude(height = ek_z - ek_pah - alt_pah)
                    rrect(uzunluk, genislik, kose_r);

            // ust: birlesim V-olugunun alt yarisi
            rdilim(uzunluk - 2 * ek_pah, genislik - 2 * ek_pah, kose_r - ek_pah, ek_z - 0.01);
        }

        kizak_olugu();
    }
}


// sol/sag kizak oluklari (govdeden cikarilan hacim)
module kizak_olugu()
{
    difference()
    {
        translate([-hx - 5, -hy - 5, -1])
            cube([uzunluk + 10, kz_dur_y + hy + 5, kz_ust + 1]);

        xz_prizma([
            [-kz_lin(-1), -1],
            [-kz_lin(kz_h), kz_h],
            [-(hx + 5), kz_ust + 5],
            [ (hx + 5), kz_ust + 5],
            [ kz_lin(kz_h), kz_h],
            [ kz_lin(-1), -1]
        ]);
    }
}


module govde_ic()
{
    intersection()
    {
        translate([0, 0, et])
            linear_extrude(height = ek_z + 5)
                rrect(2 * ix, 2 * iy, ic_r);

        // kizak bolgesinde ic duvar, dis profile paralel (et kadar iceride)
        xz_prizma([
            [-(kz_lin(0) - et), 0],
            [-(kz_lin(kz_h) - et), kz_h],
            [-ix, kz_ust],
            [-ix, toplam_yuks + 5],
            [ ix, toplam_yuks + 5],
            [ ix, kz_ust],
            [ (kz_lin(kz_h) - et), kz_h],
            [ (kz_lin(0) - et), 0]
        ]);
    }

    // ust ic kenarda giris pahi: kapak dudagi kolay oturur
    hull()
    {
        rdilim(2 * ix, 2 * iy, ic_r, ek_z - giris_pah);
        rdilim(2 * (ix + giris_pah), 2 * (iy + giris_pah), ic_r + giris_pah, ek_z + 0.01);
    }
}


module pcb_raf()
{
    translate([0, 0, et - 0.01])
        linear_extrude(height = z_rest - et + 0.01)
            difference()
            {
                intersection()
                {
                    rrect(2 * ix, 2 * iy, ic_r);

                    translate([-hx - 1, -hy - 1])
                        square([board_r + raf_bindirme + hx + 1, genislik + 2]);
                }

                translate([board_l + raf_bindirme, -pcb_depth / 2 + raf_bindirme])
                    square([pcb_edge_usb - 2 * raf_bindirme, pcb_depth - 2 * raf_bindirme]);

                // USB konnektoru altinda raf yok
                translate([usb_cx - raf_usb_w / 2, -hy - 1])
                    square([raf_usb_w, hy + 1 - (pcb_depth / 2 - 3)]);
            }
}


// On yuzde ince USB kesit dilimi (flare hull'u icin)
module usb_dilim(y, w, h, r)
{
    translate([usb_cx, y, (usb_z0 + usb_z1) / 2])
        rotate([-90, 0, 0])
            linear_extrude(height = 0.01)
                rrect(w, h, r);
}


module usb_bosluk()
{
    // standart USB-C gecis yuvasi
    translate([usb_cx, -genislik / 2 - 2, (usb_z0 + usb_z1) / 2])
        rotate([-90, 0, 0])
            linear_extrude(height = et + 4)
                rrect(usb_w, usb_bos_h, usb_r);

    // on agiz flare (kablo govdesi icin)
    hull()
    {
        usb_dilim(-genislik / 2 - 0.02, usb_agiz_w, usb_agiz_h, usb_agiz_r);
        usb_dilim(-genislik / 2 + usb_agiz_derin, usb_w, usb_bos_h, usb_r);
    }
}


module led_delik()
{
    translate([led_x, hy + 1, led_z])
        rotate([90, 0, 0])
            cylinder(h = et + 2, d = led_cap, $fn = 48);

    // dis kenar pahi
    translate([led_x, hy + 0.01, led_z])
        rotate([90, 0, 0])
            cylinder(h = 0.5, d1 = led_cap + 1, d2 = led_cap, $fn = 48);
}


module snap_cepleri()
{
    if (snap_on)
        for (sx = snap_x, sy = [-1, 1])
            translate([sx, sy * (iy + snap_int - snap_d / 2), snap_z])
                sphere(d = snap_pocket_d, $fn = 32);
}


// kizak yanlarinda dikey V-centik (kizaktaki parmak buraya oturur)
module v_prizma(x_fn_ofs, derin, ek, y0, z0, z1, s)
{
    hull()
        for (z = [z0, z1])
        {
            x = kz_lin(z) + x_fn_ofs;

            translate([0, 0, z])
                linear_extrude(height = 0.01)
                    polygon([
                        [s * (x - derin), y0],
                        [s * (x + ek), y0 - (derin + ek)],
                        [s * (x + ek), y0 + (derin + ek)]
                    ]);
        }
}


module kilit_centikleri()
{
    for (s = [-1, 1])
        v_prizma(0, kilit_derin, 1, kilit_y, -0.5, kz_h, s);
}


module alt_yazi()
{
    translate([0, yazi_y, -0.01])
        linear_extrude(height = oyma_derin + 0.01)
            mirror([1, 0, 0])
                text(yazi, size = yazi_boy, font = yazi_font,
                     halign = "center", valign = "center", spacing = 1.08);
}


// =============================================================
// KIZAK (KONTROLCU ADAPTORU)
//
// Kontrolcunun arkasina VHB bantla yapisir. Govde arkadan (+Y)
// kaydirilir; govdenin tam arka blogu raylarin arka ucuna dayanir
// (kablo cekilince kasa one kacamaz). Raylardaki esnek parmaklarin
// V-sirtlari govdedeki centiklere "klik" diye oturur.
// =============================================================

module kizak()
{
    difference()
    {
        union()
        {
            // taban
            translate([0, 0, -ad_taban])
                linear_extrude(height = ad_taban)
                    rrect(uzunluk, genislik, kose_r);

            // raylar
            intersection()
            {
                linear_extrude(height = ad_ray_ust)
                    rrect(uzunluk, genislik, kose_r);

                translate([-hx - 1, -hy - 1, -1])
                    cube([uzunluk + 2, kz_dur_y - ad_bosluk + hy + 1, ad_ray_ust + 2]);
            }
        }

        // ray kanali: govdenin kirlangic profili + 45 derece pahi, bosluklu
        pah_ofs = ad_bosluk * sqrt(2);

        xz_prizma([
            [-(kz_lin(-0.01) + ad_bosluk), -0.01],
            [-(kz_lin(kz_h) + ad_bosluk), kz_h],
            [-(hx - kz_boyun + pah_ofs), kz_h],
            [-(hx - kz_boyun + pah_ofs + 10), kz_h + 10],
            [ (hx - kz_boyun + pah_ofs + 10), kz_h + 10],
            [ (hx - kz_boyun + pah_ofs), kz_h],
            [ (kz_lin(kz_h) + ad_bosluk), kz_h],
            [ (kz_lin(-0.01) + ad_bosluk), -0.01]
        ]);

        parmak_kesimleri();

        if (ad_sensor)
            translate([0, 0, -ad_taban - 1])
                cylinder(h = ad_taban + 2, d = sensor_cap + 2);
    }

    kilit_sirtlari();

    if (ad_sikistir > 0)
        sikistirma_tumsekleri();
}


// esnek parmak: kok arkada, serbest uc onde. Ray + tabanin dis
// seridi olarak bed'e kadar iner; yana (X) esner.
module parmak_kesimleri()
{
    y_uc  = kilit_y - 2.5;
    y_kok = y_uc + parmak_l;

    for (s = [-1, 1])
    {
        // serbest uc: enine kesim
        translate([s > 0 ? ix - parmak_kesim - 0.5 : -hx - 1, y_uc - parmak_kesim, -ad_taban - 1])
            cube([hx - ix + parmak_kesim + 1.5, parmak_kesim, ad_taban + ad_ray_ust + 2]);

        // tabandan ayiran boyuna kesim
        translate([s > 0 ? ix - parmak_kesim : -ix, y_uc - parmak_kesim, -ad_taban - 1])
            cube([parmak_kesim, y_kok - y_uc + parmak_kesim, ad_taban + 1.01]);
    }
}


module kilit_sirtlari()
{
    for (s = [-1, 1])
        intersection()
        {
            // sirt: ray yuzeyinden kanala dogru cikar, tabani raya gomulu
            v_prizma(ad_bosluk, kilit_sirt, 0.3, kilit_y, 0.3, kz_h - 0.3, s);

            // sadece parmak uzerinde kalsin
            translate([s > 0 ? 0 : -hx, kilit_y - 3, 0])
                cube([hx, 6, kz_h]);
        }
}


module sikistirma_tumsekleri()
{
    for (p = [[16, -19], [-16, -19], [16, 12], [-16, 12]])
        translate([p[0], p[1], -0.05])
            intersection()
            {
                scale([1.2, 2.5, ad_sikistir + 0.05])
                    sphere(r = 1, $fn = 32);

                translate([-5, -5, 0])
                    cube([10, 10, 5]);
            }
}


// =============================================================
// PCB HAYALETI (sadece gorsel kontrol icin)
// =============================================================

module pcb_hayalet()
{
    color([0.05, 0.35, 0.2, 0.9])
        translate([board_l, -pcb_depth / 2, z_rest])
            cube([pcb_edge_usb, pcb_depth, pcb_thick]);

    color([0.9, 0.9, 0.9, 0.35])
        translate([board_l + 1, -pcb_depth / 2 + 1, z_pcb_top])
            cube([pcb_edge_usb - 2, pcb_depth - 2, pcb_comp_h]);

    color("Silver")
        translate([usb_cx - 4.47, -pcb_depth / 2 - 0.7, (usb_z0 + usb_z1) / 2 - 1.6])
            cube([8.94, 7.35, 3.2]);
}


// =============================================================
// GORUNUM SECICI
//
// "montaj"      = kasa kizaga takili (varsayilan)
// "kasa"        = kapak + govde (kizaksiz)
// "patlatilmis" = parcalar ayrik, ust uste
// "kesit"       = montajin X=... kesiti (ic yapi kontrolu)
// "kapak" / "govde" / "kizak" = tek parca, montaj konumunda
// "baski"       = uc parca baski yonunde yan yana
// "kapak_baski" / "govde_baski" / "kizak_baski" = tek parca, STL icin
// "inlay_baski" = oyma dolgusu (cok renkli baski, kapak_baski ile hizali)
// "yok"         = hicbir sey (include ile kullanim icin)
// =============================================================

goster = "montaj";

pcb_goster = false;          // montaj gorunumlerinde PCB hayaleti

renk_kapak = [0.16, 0.17, 0.19];
renk_govde = [0.24, 0.25, 0.28];
renk_kizak = [0.10, 0.10, 0.11];
renk_vurgu = [0.00, 0.85, 1.00];


module renkli_kapak()
{
    color(renk_kapak) kapak();

    if (oyma_on)
        color(renk_vurgu)
            translate([0, 0, -0.02])
                ust_oyma();
}


module kapak_baski_yonu()
{
    translate([0, 0, toplam_yuks])
        rotate([180, 0, 0])
            children();
}


if (goster == "kapak")
{
    renkli_kapak();
}
else if (goster == "govde")
{
    color(renk_govde) govde();
}
else if (goster == "kizak")
{
    color(renk_kizak) kizak();
}
else if (goster == "kasa")
{
    renkli_kapak();
    color(renk_govde) govde();

    if (pcb_goster) pcb_hayalet();
}
else if (goster == "patlatilmis")
{
    translate([0, 0, 22]) renkli_kapak();
    color(renk_govde) govde();
    translate([0, 0, -14]) color(renk_kizak) kizak();

    if (pcb_goster) translate([0, 0, 9]) pcb_hayalet();
}
else if (goster == "kesit")
{
    difference()
    {
        union()
        {
            renkli_kapak();
            color(renk_govde) govde();
            color(renk_kizak) kizak();
        }

        translate([-hx - 5, 0, -10])
            cube([uzunluk + 10, hy + 5, toplam_yuks + 20]);
    }

    if (pcb_goster) pcb_hayalet();
}
else if (goster == "kapak_baski")
{
    kapak_baski_yonu() kapak();
}
else if (goster == "inlay_baski")
{
    // oyma hacmi, kapak yuzeyiyle tam hizali (0 .. oyma_derin)
    kapak_baski_yonu()
        intersection()
        {
            ust_oyma();

            translate([-hx, -hy, toplam_yuks - oyma_derin])
                cube([uzunluk, genislik, oyma_derin]);
        }
}
else if (goster == "govde_baski")
{
    govde();
}
else if (goster == "kizak_baski")
{
    translate([0, 0, ad_taban]) kizak();
}
else if (goster == "yok")
{
    // hicbir sey cizme (include ile kullanim / testler icin)
}
else if (goster == "baski")
{
    translate([-(uzunluk + 6), 0, 0]) color(renk_kapak) kapak_baski_yonu() kapak();
    color(renk_govde) govde();
    translate([uzunluk + 6, 0, ad_taban]) color(renk_kizak) kizak();
}
else
{
    // montaj: kasa kizaga takili
    renkli_kapak();
    color(renk_govde) govde();
    color(renk_kizak) kizak();

    if (pcb_goster) pcb_hayalet();
}


// =============================================================
// BILGI
// =============================================================

echo(str("KASA DIS: ", uzunluk, " X ", genislik, " X ", toplam_yuks, " mm"));
echo(str("KIZAKLA TOPLAM YUKSEKLIK: ", toplam_yuks + ad_taban, " mm"));
echo(str("PCB X = [", board_l, " .. ", board_r, "]  USB X = ", usb_cx));
