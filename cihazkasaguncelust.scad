// =============================================================
// GESTURAWARE - UST KASA
// Tek parca ust govde
// Apple / minimalist
// USB-C on (-Y) duvarda TAM ORTADA
//
// Tum olculer mm.
// Z=0 tabanin en alti
// =============================================================

$fn = 100;


// =============================================================
// PCB / KASA OLCULERI
// =============================================================

pcb_edge_usb = 40.5;
pcb_depth    = 46.5;
pcb_thick    = 1.6;
pcb_comp_h   = 10;

side_clr  = 1.5;
head_gap  = 3.0;
floor_gap = 2.0;

et = 2;
kose_r = 8;

taban_yuks = 7;


// =============================================================
// SNAP - VIDASIZ KENETLENME
// Alt kapaktaki detent toplarina denk gelen yuvalar.
// Degerler alt dosya ile AYNI olmali.
// =============================================================

snap_on       = true;
snap_x_off    = 20;
snap_d        = 2.4;
snap_pocket_d = 2.9;
snap_int      = 0.4;


// =============================================================
// USB-C
// =============================================================

usb_edge_off = 8.62;

usb_w     = 9.2;
usb_bos_h = 3.4;
usb_alt   = 4;
usb_r     = 1.7;

usb_agiz_w     = 10.5;
usb_agiz_h     = 7.0;
usb_agiz_r     = 2.5;
usb_agiz_derin = 2;


// =============================================================
// UST BUTON
// =============================================================

buton_cap = 12;

buton_x = 0;
buton_y = 0;

tepe_h     = 3.5;
tepe_r     = 22;
tepe_steps = 48;


// =============================================================
// TURETILEN OLCULER
// =============================================================

// USB-C merkeze gore 1 mm saga (+X) kaydirildi
usb_cx = 1;

// PCB USB konnektorunu merkeze getirmek icin sola kayiyor
bd_cx = -usb_edge_off;


// PCB X sinirlari
board_l = bd_cx - pcb_edge_usb / 2;
board_r = bd_cx + pcb_edge_usb / 2;


// PCB + yan bosluk
right_ext = board_r;

half_in = max(-board_l, right_ext) + side_clr;


// Kasa dis X
uzunluk = 2 * (half_in + et);


// Kasa dis Y
inner_y = pcb_depth + 2 * side_clr;
genislik = inner_y + 2 * et;


// Kasa ic yuksekligi
inner_h =
    floor_gap
    + pcb_thick
    + pcb_comp_h
    + head_gap;


// Toplam yukseklik
toplam_yuks = inner_h + 2 * et;


// Ust tavan ic yuzeyi
tavan_z = toplam_yuks - et;


// USB acikligi
usb_z0 = usb_alt;
usb_z1 = usb_alt + usb_bos_h;


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
                        0,
                        0,
                        taban_yuks
                    ]
                )
                rbox(
                    uzunluk,
                    genislik,
                    toplam_yuks - taban_yuks,
                    kose_r
                );

                // ust_tepe();   // UST TUMSEK KALDIRILDI - duz ust istendi
            }


            // -------------------------------------------------
            // IC BOSLUK
            // -------------------------------------------------

            translate(
                [
                    0,
                    0,
                    taban_yuks - 1
                ]
            )
            rbox(
                uzunluk - 2 * et,
                genislik - 2 * et,
                tavan_z - (taban_yuks - 1),
                kose_r - et
            );


            // -------------------------------------------------
            // BUTON DELIGI
            // -------------------------------------------------

            buton_bosluk();


            // -------------------------------------------------
            // USB-C DELIGI
            // -------------------------------------------------

            usb_bosluk();


            // -------------------------------------------------
            // SNAP YUVALARI
            // -------------------------------------------------

            snap_pockets();
        }
    }
}


// =============================================================
// BUTON DELIGI
// =============================================================

module buton_bosluk()
{
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
// =============================================================

module ust_tepe()
{
    translate([buton_x, buton_y, 0])
    rotate_extrude($fn = 160)
    polygon(
        points = concat(

            // Ic taban
            [
                [0, toplam_yuks - 0.6]
            ],

            // Tepe profili
            [
                for (i = [0 : tepe_steps])
                    let (
                        r = tepe_r * i / tepe_steps
                    )
                    [
                        r,
                        toplam_yuks
                        + tepe_h
                        * pow(
                            1 - i / tepe_steps,
                            2
                        )
                    ]
            ],

            // Dis taban
            [
                [tepe_r, toplam_yuks - 0.6]
            ]
        )
    );
}


// =============================================================
// USB-C DELIGI
// =============================================================

module usb_dilim(y, w, h, r)
{
    translate(
        [
            usb_cx,
            y,
            (usb_z0 + usb_z1) / 2
        ]
    )
    rotate([-90, 0, 0])
    linear_extrude(height = 0.01)
        rrect(w, h, r);
}


module usb_bosluk()
{
    // Standart USB-C gecis deligi
    translate(
        [
            usb_cx,
            -genislik / 2 - 2,
            (usb_z0 + usb_z1) / 2
        ]
    )
    rotate([-90, 0, 0])
    linear_extrude(height = et + 4)
        rrect(
            usb_w,
            usb_bos_h,
            usb_r
        );


    // On agiz flare
    hull()
    {
        usb_dilim(
            -genislik / 2 - 0.02,
            usb_agiz_w,
            usb_agiz_h,
            usb_agiz_r
        );

        usb_dilim(
            -genislik / 2 + usb_agiz_derin,
            usb_w,
            usb_bos_h,
            usb_r
        );
    }
}


// =============================================================
// SNAP YUVALARI (ust duvardan cikarilir)
// =============================================================

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
// MODEL
// =============================================================

ust_kasa();


// =============================================================
// BILGI
// =============================================================

echo(
    str(
        "UST KASA DIS: ",
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