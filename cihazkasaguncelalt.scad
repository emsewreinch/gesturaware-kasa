// =============================================================
// GESTURAWARE - ALT KAPAK
// Tek parca alt kapak
// Apple / minimalist
//
// Tum olculer mm.
// Z=0 tabanin en alti
// =============================================================

$fn = 100;


// =============================================================
// PCB OLCULERI
// =============================================================

pcb_edge_usb = 40.5;
pcb_depth    = 46.5;

side_clr = 1.5;

et = 2;
kose_r = 8;

taban_yuks = 7;


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
// VIDA / MONTAJ
// =============================================================

hole_ax = 17;
hole_ay = 19.5;

kapak_delik = 2.8;

havsa_ust_cap = 5.0;
havsa_derin   = 2.2;


// =============================================================
// ALT DELIKLER
// =============================================================

sensor_cap = 5.0;
reset_cap  = 1.0;


// =============================================================
// ALT KAPAK LASTIK OLGUSU
// =============================================================

lastik_r_dis = 15;
lastik_r_ic  = 13;
lastik_derin = 1.0;


// =============================================================
// KASA AYARLARI
// =============================================================

lip_yuks   = 4;
lip_bosluk = 0.3;
lip_et     = 1.5;

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
// TURETILEN OLCULER
// =============================================================

// PCB merkezi
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


// Birlesim seviyesi
seam_z = taban_yuks;


// =============================================================
// VIDA POZISYONLARI
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
// YARDIMCI MODUL
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


// =============================================================
// ALT KAPAK
// =============================================================

module alt_kapak()
{
    difference()
    {
        union()
        {
            // Ana govde
            difference()
            {
                etek_solid();
                skirt_ic();
            }

            // Ic gecme lip'i
            lip();

            // Vidasiz snap toplari
            snap_bumps();
        }


        // -----------------------------------------------------
        // VIDA DELIKLERI
        // -----------------------------------------------------

        kapak_vida_delikleri();


        // -----------------------------------------------------
        // USB-C DELIGI
        // -----------------------------------------------------

        usb_bosluk();


        // -----------------------------------------------------
        // SENSOR DELIGI
        // -----------------------------------------------------

        translate(
            [
                0,
                0,
                -1
            ]
        )
        cylinder(
            h = et + 2,
            d = sensor_cap
        );


        // -----------------------------------------------------
        // RESET DELIGI
        // -----------------------------------------------------

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


        // -----------------------------------------------------
        // LASTIK OLGUSU
        // -----------------------------------------------------

        lastik_olugu();
    }
}


// =============================================================
// ALT KAPAK DIS GOVDESI
// =============================================================

module etek_solid()
{
    translate([0, 0, 0])
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
    translate([0, 0, 0])
    hull()
    {
        // Alt ic kisim
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


        // Ust ic kisim
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
// IC LIP
// =============================================================

module lip()
{
    translate(
        [
            0,
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
// USB-C DELIGI
// =============================================================

usb_z0 = usb_alt;
usb_z1 = usb_alt + usb_bos_h;

usb_cx = 1;   // merkeze gore 1 mm saga (+X) kaydirildi


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
// VIDA DELIKLERI
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
            translate(
                [
                    0,
                    0,
                    -0.1
                ]
            )
            cylinder(
                h = 10,
                d = kapak_delik
            );


            // Havsa
            translate(
                [
                    0,
                    0,
                    -0.1
                ]
            )
            cylinder(
                h = havsa_derin + 0.1,
                d1 = havsa_ust_cap,
                d2 = kapak_delik
            );
        }
    }
}


// =============================================================
// LASTIK OLGUSU
// =============================================================

module lastik_olugu()
{
    translate(
        [
            0,
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
// SNAP TOPLARI (lip uzerine eklenir)
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


// =============================================================
// MODEL
// =============================================================

alt_kapak();


// =============================================================
// BILGI
// =============================================================

echo(
    str(
        "ALT KAPAK DIS: ",
        uzunluk,
        " X ",
        genislik,
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