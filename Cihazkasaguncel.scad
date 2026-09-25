// =============================================================
// Cihaz Kasasi - iki parcali
// Ust kasa + alt kapak
// Apple / minimalist
// USB-C on (-Y) duvarda TAM ORTADA
//
// Tum olculer mm.
// Z=0 tabanin en alti.
// =============================================================

$fn = 100;


// =============================================================
// BILESEN / PCB OLCULERI
// =============================================================

pcb_edge_usb = 40.5;       // PCB X boyu
pcb_depth    = 46.5;       // PCB Y boyu
pcb_thick    = 1.6;

pcb_comp_h   = 10;         // PCB ustu maksimum komponent yuksekligi

hole_ax = 17;              // Vida delikleri X yari-araligi
hole_ay = 19.5;            // Vida delikleri Y yari-araligi

// USB konnektorunun PCB on kenarindan iceri kacikligi
usb_edge_off = 8.62;

usb_w     = 9.2;           // USB-C acikligi X (evrensel ~9.0-9.2mm)
usb_bos_h = 3.4;           // USB-C acikligi Z (evrensel ~3.2-3.4mm)
usb_alt   = 4;             // acikligin alt kenari tabandan yukseklik (4mm)
usb_r     = 1.7;           // kose yuvarlatma (uclar tam yuvarlak = kapsul)

// On agiz: kablonun GOVDESI (apple type-c) de rahatca otursun diye on yuzde flare
usb_agiz_w     = 10.5;     // on agiz genisligi (apple kablo govde genisligi gibi)
usb_agiz_h     = 7.0;      // on agiz yuksekligi
usb_agiz_r     = 2.5;      // on agiz kose yuvarlatma
usb_agiz_derin = 2;        // flare derinligi (et=2 => tum on katman chamfer)


// =============================================================
// YERLESIM / BOSLUKLAR
// =============================================================

side_clr  = 1.5;           // PCB-kasa yan boslugu
head_gap  = 3.0;           // PCB ustu bosluk
floor_gap = 2.0;           // PCB alt boslugu


// =============================================================
// KASA AYARLARI
// =============================================================

et = 2;                    // Duvar kalinligi

kose_r = 8;                // Dis koselerin radiusu

taban_yuks = 7;            // Alt kapak / seam yuksekligi

lip_yuks  = 4;
lip_bosluk = 0.3;
lip_et = 1.5;

chamfer_inset = 2.5;


// =============================================================
// SNAP - VIDASIZ KENETLENME
// Lip uzerindeki detent toplari, ust kasadaki yuvalara oturur.
// =============================================================

snap_on       = true;   // snap kenetlenme acik/kapali
snap_x_off    = 20;     // snap'lerin merkezden X uzakligi (USB'yi es gecer)
snap_d        = 2.4;    // lip uzerindeki detent topu capi
snap_pocket_d = 2.9;    // ust duvardaki yuva capi (bumptan buyuk)
snap_int      = 0.4;    // sikilik / interferans (mm) - artir = daha sert klik


// =============================================================
// UST BUTON
// =============================================================

buton_cap = 12;
havuz_cap = 20;
havuz_derin = 1.2;

buton_x = 0;
buton_y = 0;

// Ust tumsek (buton meme-ucu gibi durmasin diye)
tepe_h     = 3.5;          // buton cevresi tumsek merkez yuksekligi (duz uste gore)
tepe_r     = 22;           // bu yaricapta duz uste tegetlenir (tumsek yaricapi)
tepe_steps = 48;           // profil cozunurlugu


// =============================================================
// VIDA / MONTAJ
// =============================================================

sutun_cap = 5.5;
boss_cap = 6.0;

vida_ic_cap = 2.2;
pilot_derin = 12;

kapak_delik = 2.8;

havsa_ust_cap = 5.0;
havsa_derin = 2.2;


// =============================================================
// ALT SENSOR / RESET DELIKLERI
// =============================================================

sensor_cap = 5.0;
reset_cap = 1.0;


// =============================================================
// ALT KAPAK LASTIK OLGUSU
// =============================================================

lastik_r_dis = 15;
lastik_r_ic = 13;
lastik_derin = 1.0;


// =============================================================
// ARKA SEFFAF NOKTA (tek-katman isik gecisi)
// =============================================================

nokta_cap   = 1.0;         // nokta capi
nokta_kalan = 0.4;         // ic yuzeyde kalan et (~2 katman; 0.2 = tek katman)
nokta_x     = 0;           // arka (+Y) duvarda X konumu


// =============================================================
// ARKA LED DELIGI (5mm LED - arka +Y duvar, sag)
// =============================================================

led_cap = 5.0;             // 5mm LED icin delik capi
led_x   = 18;              // +X (sag) konum
led_z   = 10;              // yukseklik (tabandan)


// =============================================================
// TURETILEN OLCULER
// =============================================================

// USB-C merkeze gore 1 mm saga (+X) kaydirildi
usb_cx = 1;

// PCB, USB konnektorunu kasa merkezine getirmek icin sola kayiyor
bd_cx = -usb_edge_off;

bd_cy = 0;


// PCB X sinirlari
board_l = bd_cx - pcb_edge_usb / 2;
board_r = bd_cx + pcb_edge_usb / 2;


// PCB'nin en dis noktasi + bosluk
right_ext = board_r;

half_in = max(-board_l, right_ext) + side_clr;


// =============================================================
// KASA DIS X BOYUTU
// =============================================================

uzunluk = 2 * (half_in + et);


// =============================================================
// KASA DIS Y BOYUTU
// =============================================================

inner_y = pcb_depth + 2 * side_clr;

genislik = inner_y + 2 * et;


// =============================================================
// KASA Z BOYUTU
// =============================================================

inner_h =
    floor_gap
    + pcb_thick
    + pcb_comp_h
    + head_gap;

toplam_yuks = inner_h + 2 * et;


// Alt ic taban
z_floor_top = et;

// PCB alt seviyesi
z_rest = z_floor_top + floor_gap;

// PCB ust seviyesi
z_pcb_top = z_rest + pcb_thick;

// Ust tavanin ic yuzeyi
tavan_z = toplam_yuks - et;

// Ust / alt kapak birlesim seviyesi
seam_z = taban_yuks;

// Arka seffaf nokta yuksekligi (seam ile tavan arasi orta)
nokta_z = (seam_z + tavan_z) / 2;


// USB acikligi dikey sinirlari (alt kenar tabandan usb_alt, yukseklik usb_bos_h)
usb_z0 = usb_alt;
usb_z1 = usb_alt + usb_bos_h;


// Kasa merkezi
cc = 0;


// =============================================================
// VIDA DELIK POZISYONLARI
// =============================================================

hole_positions =
[
    for (sx = [-1, 1], sy = [-1, 1])
    [
        bd_cx + sx * hole_ax,
        sy * hole_ay
    ]
];


// =============================================================
// YARDIMCI MODULLER
// =============================================================

module rrect(l, w, r)
{
    rr = max(min(r, l / 2, w / 2), 0.1);

    hull()
    {
        for (sx = [-1, 1], sy = [-1, 1])
        {
            translate(
                [
                    sx * (l / 2 - rr),
                    sy * (w / 2 - rr)
                ]
            )
            circle(r = rr);
        }
    }
}


module rbox(l, w, h, r)
{
    linear_extrude(height = h)
        rrect(l, w, r);
}


// =============================================================
// UST KASA
// =============================================================

module ust_kasa()
{
    union()
    {
        difference()
        {
            // -------------------------------------------------
            // DIS KABUK + UST TUMSEK
            // -------------------------------------------------

            union()
            {
                translate(
                    [
                        cc,
                        0,
                        seam_z
                    ]
                )
                rbox(
                    uzunluk,
                    genislik,
                    toplam_yuks - seam_z,
                    kose_r
                );

                // ust_tepe();   // UST TUMSEK KALDIRILDI - duz ust istendi
            }


            // -------------------------------------------------
            // IC BOSLUK
            // -------------------------------------------------

            translate(
                [
                    cc,
                    0,
                    seam_z - 1
                ]
            )
            rbox(
                uzunluk - 2 * et,
                genislik - 2 * et,
                tavan_z - (seam_z - 1),
                kose_r - et
            );


            // -------------------------------------------------
            // UST BUTON BOSLUGU
            // -------------------------------------------------

            buton_bosluk();


            // -------------------------------------------------
            // USB-C BOSLUGU
            // -------------------------------------------------

            usb_bosluk();


            // -------------------------------------------------
            // ARKA SEFFAF NOKTA - KAPATILDI (istenmiyor)
            // -------------------------------------------------

            // arka_nokta();


            // -------------------------------------------------
            // ARKA LED DELIGI (5mm)
            // -------------------------------------------------

            led_delik();


            // -------------------------------------------------
            // SNAP YUVALARI
            // -------------------------------------------------

            snap_pockets();
        }


        // -----------------------------------------------------
        // PCB MONTAJ KOLONLARI - KALDIRILDI
        // Ic cubuk istenmiyor; ust kolonlar cikarildi.
        // -----------------------------------------------------

        // ust_standoffs();
    }
}


// =============================================================
// BUTON BOSLUGU
// =============================================================

module buton_bosluk()
{
    // Buton gecis deligi (duz ust yuzeyi deler)
    translate(
        [
            buton_x,
            buton_y,
            tavan_z - 0.1
        ]
    )
    cylinder(
        h = et + 0.4,
        d = buton_cap
    );
}


// =============================================================
// UST TUMSEK
//
// Buton cevresinden baslayip kenara dogru egimi azalarak duz uste
// tegetlenen yayvan tepe. Buton artik "meme ucu" gibi tek basina
// cikmaz; genis yumusak bir tepeden dogar.
// =============================================================

module ust_tepe()
{
    translate([buton_x, buton_y, 0])
    rotate_extrude($fn = 160)
    polygon(
        points = concat(
            // ic taban (duz uste 0.6 gomulu -> temiz birlesim)
            [[0, toplam_yuks - 0.6]],

            // tepe profili: merkezde dik, rim'de tegetsel (egim -> 0)
            [
                for (i = [0 : tepe_steps])
                    let (r = tepe_r * i / tepe_steps)
                    [ r, toplam_yuks + tepe_h * pow(1 - i / tepe_steps, 2) ]
            ],

            // dis taban
            [[tepe_r, toplam_yuks - 0.6]]
        )
    );
}


// =============================================================
// ARKA SEFFAF NOKTA
//
// Arka (+Y) duvarda disaridan acilan sig cep; ic yuzeyde nokta_kalan
// kadar ince et birakir. O ince noktadan ic aydinlatma disari sizar.
// =============================================================

module arka_nokta()
{
    translate([nokta_x, genislik / 2 + 0.1, nokta_z])
    rotate([90, 0, 0])
    cylinder(
        h = (et - nokta_kalan) + 0.1,
        d = nokta_cap,
        $fn = 40
    );
}


// =============================================================
// ARKA LED DELIGI (5mm)
//
// Arka (+Y) duvarda, sag tarafta yatay 5mm delik; duvari boydan
// boya gecer, ic ucu duvarin ic yuzune hizali. LED basi icten oturur.
// =============================================================

module led_delik()
{
    // h: dis duvar (et) + lip_bosluk + lip (lip_et) + payi da gecsin ki
    // delik yolu tamamen acik kalsin (lip arkayi kapatmasin).
    translate([led_x, genislik / 2 + 1, led_z])
    rotate([90, 0, 0])
    cylinder(h = et + 7, d = led_cap, $fn = 48);
}


// =============================================================
// USB-C BOSLUGU
//
// On (-Y) duvarda.
// X = 0 yani kasa merkezinde.
// =============================================================

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
    // 1) Standart USB-C gecis yuvasi (metal uc) - on duvari boydan boya deler
    translate(
        [
            usb_cx,
            -genislik / 2 - 2,
            (usb_z0 + usb_z1) / 2
        ]
    )
    rotate([-90, 0, 0])
    linear_extrude(height = et + 4)
    rrect(usb_w, usb_bos_h, usb_r);

    // 2) On agiz flare: dis yuzde genis (kablo govdesi), ic yonde USB-C olcusune
    //    daralir (chamfer). Boylece kablonun basi + govdesi rahatca oturur.
    hull()
    {
        usb_dilim(-genislik / 2 - 0.02, usb_agiz_w, usb_agiz_h, usb_agiz_r);
        usb_dilim(-genislik / 2 + usb_agiz_derin, usb_w, usb_bos_h, usb_r);
    }
}


// =============================================================
// UST PCB MONTAJ KOLONLARI
// =============================================================

module ust_standoffs()
{
    for (p = hole_positions)
    {
        translate(
            [
                p[0],
                p[1],
                z_pcb_top
            ]
        )
        difference()
        {
            // Kolon
            cylinder(
                h = tavan_z - z_pcb_top,
                d = sutun_cap
            );

            // Vida ic deligi
            translate([0, 0, -0.1])
            cylinder(
                h = pilot_derin,
                d = vida_ic_cap
            );
        }
    }
}


// =============================================================
// ALT KAPAK
// =============================================================

module alt_kapak()
{
    difference()
    {
        union()
        {
            difference()
            {
                etek_solid();
                skirt_ic();
            }

            lip();
            // alt_bosslar();  // ic cubuk istenmiyor; boss'lar kaldirildi (delikler acik kaldi)

            // Vidasiz snap toplari
            snap_bumps();
        }


        // Vida delikleri
        kapak_vida_delikleri();


        // USB-C
        usb_bosluk();


        // Arka LED deligi (led_z alt parcaya denk gelirse burada kesilir)
        led_delik();


        // Sensor deligi
        translate(
            [
                cc,
                0,
                -1
            ]
        )
        cylinder(
            h = et + 2,
            d = sensor_cap
        );


        // Reset deligi
        translate(
            [
                bd_cx,
                -hole_ay - 2,
                -1
            ]
        )
        cylinder(
            h = et + 2,
            d = reset_cap
        );


        // Lastik olugu
        lastik_olugu();
    }
}


// =============================================================
// ALT KAPAK DIS GOVDESI
// =============================================================

module etek_solid()
{
    translate([cc, 0, 0])
    hull()
    {
        // Alt kisim
        linear_extrude(height = 0.1)
        rrect(
            uzunluk - 2 * chamfer_inset,
            genislik - 2 * chamfer_inset,
            kose_r - chamfer_inset
        );


        // Ust kisim
        translate(
            [
                0,
                0,
                seam_z - 0.1
            ]
        )
        linear_extrude(height = 0.1)
        rrect(
            uzunluk,
            genislik,
            kose_r
        );
    }
}


// =============================================================
// ALT KAPAK IC BOSLUGU
// =============================================================

module skirt_ic()
{
    translate([cc, 0, 0])
    hull()
    {
        translate(
            [
                0,
                0,
                et
            ]
        )
        linear_extrude(height = 0.1)
        rrect(
            uzunluk
                - 2 * chamfer_inset
                - 2 * et,

            genislik
                - 2 * chamfer_inset
                - 2 * et,

            max(
                kose_r
                    - chamfer_inset
                    - et,
                0.5
            )
        );


        translate(
            [
                0,
                0,
                seam_z
            ]
        )
        linear_extrude(height = 0.1)
        rrect(
            uzunluk - 2 * et,
            genislik - 2 * et,
            kose_r - et
        );
    }
}


// =============================================================
// LIP
// =============================================================

module lip()
{
    translate(
        [
            cc,
            0,
            et
        ]
    )
    linear_extrude(
        height = (seam_z - et) + lip_yuks
    )
    difference()
    {
        // Dis
        rrect(
            uzunluk
                - 2 * et
                - 2 * lip_bosluk,

            genislik
                - 2 * et
                - 2 * lip_bosluk,

            kose_r
                - et
                - lip_bosluk
        );


        // Ic
        rrect(
            uzunluk
                - 2 * et
                - 2 * lip_bosluk
                - 2 * lip_et,

            genislik
                - 2 * et
                - 2 * lip_bosluk
                - 2 * lip_et,

            max(
                kose_r
                    - et
                    - lip_bosluk
                    - lip_et,

                0.5
            )
        );
    }
}


// =============================================================
// ALT KAPAK BOSS'LARI
// =============================================================

module alt_bosslar()
{
    for (p = hole_positions)
    {
        translate(
            [
                p[0],
                p[1],
                et
            ]
        )
        cylinder(
            h = z_rest - et,
            d = boss_cap
        );
    }
}


// =============================================================
// KAPAK VIDA DELIKLERI
// =============================================================

module kapak_vida_delikleri()
{
    for (p = hole_positions)
    {
        translate(
            [
                p[0],
                p[1],
                0
            ]
        )
        {
            // Ana vida deligi
            translate([0, 0, -0.1])
            cylinder(
                h = z_rest + 1,
                d = kapak_delik
            );


            // Havsa
            translate([0, 0, -0.1])
            cylinder(
                h = havsa_derin + 0.1,
                d1 = havsa_ust_cap,
                d2 = kapak_delik
            );
        }
    }
}


// =============================================================
// LASTIK OLGU
// =============================================================

module lastik_olugu()
{
    translate(
        [
            cc,
            0,
            -0.01
        ]
    )
    linear_extrude(
        height = lastik_derin + 0.01
    )
    difference()
    {
        circle(r = lastik_r_dis);
        circle(r = lastik_r_ic);
    }
}


// =============================================================
// SNAP - VIDASIZ KENETLENME MODULLERI
// =============================================================

module snap_bumps()
{
    if (snap_on)
    {
        cy = (genislik - 2 * et) / 2 - snap_d / 2 + snap_int;

        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * snap_x_off, sy * cy, taban_yuks + 1])
            sphere(d = snap_d, $fn = 48);
    }
}


module snap_pockets()
{
    if (snap_on)
    {
        cy = (genislik - 2 * et) / 2 - snap_d / 2 + snap_int;

        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * snap_x_off, sy * cy, taban_yuks + 1])
            sphere(d = snap_pocket_d, $fn = 48);
    }
}


// =============================================================
// GORUNUM SECICI
//
// "ust"     = sadece ust kasa
// "alt"     = sadece alt kapak
// "baski"   = iki parcayi yan yana
// "acilim"  = montajli, ust kapak yukarida
// "montaj"  = normal montajli
// =============================================================

goster = "montaj";


// =============================================================
// GORUNTU
// =============================================================

if (goster == "ust")
{
    color("WhiteSmoke")
        ust_kasa();
}


else if (goster == "alt")
{
    color("Silver")
        alt_kapak();
}


else if (goster == "baski")
{
    // Ust ve alt parcayi baski icin yan yana koy
    translate(
        [
            0,
            -(genislik / 2 + 4),
            0
        ]
    )
    color("WhiteSmoke")
        ust_kasa();


    translate(
        [
            0,
            (genislik / 2 + 4),
            0
        ]
    )
    color("Silver")
        alt_kapak();
}


else if (goster == "acilim")
{
    // Ust kapak yukarida
    color("WhiteSmoke")
    translate(
        [
            0,
            0,
            14
        ]
    )
    ust_kasa();


    // Alt kapak asagida
    color("Silver")
        alt_kapak();
}


else
{
    // Normal montajli gorunum
    color("WhiteSmoke")
        ust_kasa();

    color("Silver")
        alt_kapak();
}


// =============================================================
// BILGI
// =============================================================

echo(
    str(
        "KASA DIS: ",
        uzunluk,
        " X ",
        genislik,
        " X ",
        toplam_yuks,
        " mm"
    )
);

echo(
    str(
        "USB X = ",
        usb_cx,
        " | PCB merkezi X = ",
        bd_cx
    )
);

echo(
    str(
        "PCB X = [",
        board_l,
        " .. ",
        board_r,
        "]"
    )
);