// =============================================================
//  Cihaz Kasasi - iki parcali (ust kasa + alt kapak)  v4
//  Apple/minimalist. USB-C UZUN (on) duvarda TAM ORTADA.
//
//  Yerlesim (ustten):
//    [ PCB (EN SOLDA) ] [ gap ] [ LED (sagda) ]
//  Kart, USB kenari one bakacak sekilde; kart SOLA dayanir,
//  konnektor tam kasa merkezine gelir -> USB acikligi ortada,
//  gercek konnektorle HIZALI. Sag tarafta LED icin bosluk kalir.
//
//  KRITIK: usb_edge_off = konnektorun kart on-kenari merkezinden
//  ic tarafa (saga) kacikligi. kapaklar.scad'den 8.62 alindi.
//  Gercek kartta farkliysa TEK burayi degistir; kasa kendini ayarlar.
//
//  Tum olculer mm. z=0 tabanin en alti.
// =============================================================

$fn = 100;

/* ============================================================
   =  BILESENLER (olculen)                                     =
   ============================================================ */
pcb_edge_usb = 40.5;   // kartin USB kenari boyu -> kasa X
pcb_depth    = 46.5;   // kartin diger boyutu    -> kasa Y (en/derinlik)
pcb_thick    = 1.6;
pcb_comp_h   = 10;     // kart ustu en yuksek komponent payi
hole_ax      = 17;     // montaj deligi yari-araligi (kasa X)
hole_ay      = 19.5;   // montaj deligi yari-araligi (kasa Y)

usb_edge_off = 8.62;   // <-- konnektor, kart on-kenari merkezinden saga kacik (kapaklar.scad)
usb_w        = 9.2;    // Type-C acikligi X (uzun duvar boyunca)
usb_h        = 3.4;    // Type-C acikligi Z (yukseklik)
usb_dz       = 1.2;    // konnektor merkezinin kart USTUNDEN yuksekligi

led_ekle     = true;   // sagdaki bosluga LED modulu (hayalet + yer)
led_X        = 15;
led_Y        = 25;
led_h        = 16;

/* ============================================================
   =  YERLESIM / BOSLUKLAR                                     =
   ============================================================ */
side_clr   = 1.5;
comp_gap   = 2.0;
head_gap   = 3.0;
floor_gap  = 2.0;

/* ============================================================
   =  ESTETIK / KASA                                           =
   ============================================================ */
et            = 2;
kose_r        = 8;
taban_yuks    = 7;
lip_yuks      = 4;
lip_bosluk    = 0.3;
lip_et        = 1.5;
chamfer_inset = 2.5;

buton_cap     = 16;    // ustteki basilabilir buton deligi
havuz_cap     = 20;
havuz_derin   = 1.2;
buton_x       = 0;     // buton konumu: 0 = UST YUZEYIN TAM ORTASI (X=0 halen PCB uzerinde)
buton_y       = 0;

sutun_cap     = 5.5;
boss_cap      = 6.0;
vida_ic_cap   = 2.2;
pilot_derin   = 12;
kapak_delik   = 2.8;
havsa_ust_cap = 5.0;
havsa_derin   = 2.2;

sensor_cap    = 5.0;
reset_cap     = 1.0;
lastik_r_dis  = 15;
lastik_r_ic   = 13;
lastik_derin  = 1.0;

/* ============================================================
   =  TURETILEN OLCULER + KONUMLAR                             =
   ============================================================ */
usb_cx = 0;                 // USB acikligi tam ortada
bd_cx  = -usb_edge_off;     // kart merkezi -> konnektor X=0'a gelsin (kart sola kayar)
bd_cy  = 0;

board_l = bd_cx - pcb_edge_usb/2;   // kart sol kenari (en solda)
board_r = bd_cx + pcb_edge_usb/2;   // kart sag kenari

led_l  = board_r + comp_gap;        // LED sag bosluga
led_cx = led_l + led_X/2;
led_r  = led_l + led_X;

// Kabuk X=0 etrafinda SIMETRIK -> USB tam ortada, sol bosluk yok
right_ext = led_ekle ? max(board_r, led_r) : board_r;
half_in   = max(-board_l, right_ext) + side_clr;   // ic kavite yari-X
uzunluk   = 2*(half_in + et);                      // X (dis)

inner_y  = pcb_depth + 2*side_clr;
genislik = inner_y + 2*et;                          // Y (dis)
inner_h  = max(led_h, floor_gap + pcb_thick + pcb_comp_h) + head_gap;
toplam_yuks = inner_h + 2*et;

z_floor_top = et;
z_rest      = z_floor_top + floor_gap;
z_pcb_top   = z_rest + pcb_thick;
tavan_z     = toplam_yuks - et;
seam_z      = taban_yuks;
usb_cz      = z_pcb_top + usb_dz;

cc = 0;   // kabuk merkezi (simetrik)

hole_positions = [ for (sx=[-1,1], sy=[-1,1]) [bd_cx + sx*hole_ax, sy*hole_ay] ];

/* =============================================================
                     YARDIMCI MODULLER
   ============================================================= */
module rrect(l, w, r) {
    rr = max(min(r, l/2, w/2), 0.1);
    hull() for (sx = [-1, 1], sy = [-1, 1])
        translate([sx*(l/2 - rr), sy*(w/2 - rr)]) circle(r = rr);
}
module rbox(l, w, h, r) { linear_extrude(height = h) rrect(l, w, r); }

/* =============================================================
                        UST KASA
   ============================================================= */
module ust_kasa() {
    union() {
        difference() {
            translate([cc, 0, seam_z])
                rbox(uzunluk, genislik, toplam_yuks - seam_z, kose_r);
            translate([cc, 0, seam_z - 1])
                rbox(uzunluk - 2*et, genislik - 2*et,
                     tavan_z - (seam_z - 1), kose_r - et);
            buton_bosluk();     // PCB merkezi uzerinde
            usb_bosluk();       // on (-Y) uzun duvar, tam ortada
        }
        ust_standoffs();
    }
}

module buton_bosluk() {
    translate([buton_x, buton_y, toplam_yuks - havuz_derin])
        cylinder(h = havuz_derin + 0.1, d = havuz_cap);
    translate([buton_x, buton_y, tavan_z - 0.1])
        cylinder(h = et + 0.2, d = buton_cap);
}

// USB kesimi: -Y (on) duvarda, X=usb_cx (orta), stadyum slot
module usb_bosluk() {
    r = usb_h / 2;
    translate([usb_cx, -genislik/2, usb_cz])
        hull()
            for (dx = [-(usb_w/2 - r), (usb_w/2 - r)])
                translate([dx, 0, 0])
                    rotate([90, 0, 0])
                        cylinder(h = et + 4, r = r, center = true, $fn = 48);
}

module ust_standoffs() {
    for (p = hole_positions)
        translate([p[0], p[1], z_pcb_top])
            difference() {
                cylinder(h = tavan_z - z_pcb_top, d = sutun_cap);
                translate([0, 0, -0.1]) cylinder(h = pilot_derin, d = vida_ic_cap);
            }
}

/* =============================================================
                        ALT KAPAK
   ============================================================= */
module alt_kapak() {
    difference() {
        union() {
            difference() { etek_solid(); skirt_ic(); }
            lip();
            alt_bosslar();
        }
        kapak_vida_delikleri();
        usb_bosluk();   // USB seam'i asar -> alt kabukta da acilir
        translate([cc, 0, -1]) cylinder(h = et + 2, d = sensor_cap);
        translate([bd_cx, -hole_ay - 2, -1]) cylinder(h = et + 2, d = reset_cap);
        lastik_olugu();
    }
}

module etek_solid() {
    translate([cc, 0, 0]) hull() {
        linear_extrude(height = 0.1)
            rrect(uzunluk - 2*chamfer_inset, genislik - 2*chamfer_inset,
                  kose_r - chamfer_inset);
        translate([0, 0, seam_z - 0.1])
            linear_extrude(height = 0.1) rrect(uzunluk, genislik, kose_r);
    }
}
module skirt_ic() {
    translate([cc, 0, 0]) hull() {
        translate([0, 0, et]) linear_extrude(height = 0.1)
            rrect(uzunluk - 2*chamfer_inset - 2*et,
                  genislik - 2*chamfer_inset - 2*et,
                  max(kose_r - chamfer_inset - et, 0.5));
        translate([0, 0, seam_z]) linear_extrude(height = 0.1)
            rrect(uzunluk - 2*et, genislik - 2*et, kose_r - et);
    }
}
module lip() {
    translate([cc, 0, et]) linear_extrude(height = (seam_z - et) + lip_yuks)
        difference() {
            rrect(uzunluk - 2*et - 2*lip_bosluk, genislik - 2*et - 2*lip_bosluk,
                  kose_r - et - lip_bosluk);
            rrect(uzunluk - 2*et - 2*lip_bosluk - 2*lip_et,
                  genislik - 2*et - 2*lip_bosluk - 2*lip_et,
                  max(kose_r - et - lip_bosluk - lip_et, 0.5));
        }
}
module alt_bosslar() {
    for (p = hole_positions)
        translate([p[0], p[1], et]) cylinder(h = z_rest - et, d = boss_cap);
}
module kapak_vida_delikleri() {
    for (p = hole_positions)
        translate([p[0], p[1], 0]) {
            translate([0, 0, -0.1]) cylinder(h = z_rest + 1, d = kapak_delik);
            translate([0, 0, -0.1])
                cylinder(h = havsa_derin + 0.1, d1 = havsa_ust_cap, d2 = kapak_delik);
        }
}
module lastik_olugu() {
    translate([cc, 0, -0.01]) linear_extrude(height = lastik_derin + 0.01)
        difference() { circle(r = lastik_r_dis); circle(r = lastik_r_ic); }
}

/* =============================================================
              BILESEN HAYALETLERI (fit-check)
   ============================================================= */
module pcb_ghost() {
    color([0.10, 0.45, 0.15, 0.65]) {
        translate([bd_cx, 0, z_rest + pcb_thick/2])
            cube([pcb_edge_usb, pcb_depth, pcb_thick], center = true);
        translate([bd_cx, 0, z_pcb_top + pcb_comp_h/2])
            cube([pcb_edge_usb - 8, pcb_depth - 8, pcb_comp_h], center = true);
    }
    // USB konnektor govdesi (on kenar, ORTA)
    color([0.7, 0.7, 0.7, 0.85])
        translate([usb_cx, -pcb_depth/2 - 1, usb_cz])
            cube([usb_w, 6, usb_h], center = true);
}
module led_ghost() {
    color([0.95, 0.85, 0.2, 0.7])
        translate([led_cx, 0, z_floor_top + led_h/2])
            cube([led_X, led_Y, led_h], center = true);
}

/* =============================================================
                    GORUNUM SECICI
   ============================================================= */
goster = "montaj";

if (goster == "ust")            color("WhiteSmoke") ust_kasa();
else if (goster == "alt")       color("Silver")     alt_kapak();
else if (goster == "yerlesim")  { %ust_kasa(); %alt_kapak(); pcb_ghost(); if (led_ekle) led_ghost(); }
else if (goster == "baski") {
    translate([0, -(genislik/2 + 4), 0]) ust_kasa();
    translate([0,  (genislik/2 + 4), 0]) alt_kapak();
}
else if (goster == "acilim") {
    color("WhiteSmoke") translate([0, 0, 14]) ust_kasa();
    color("Silver")     alt_kapak();
}
else { color("WhiteSmoke") ust_kasa(); color("Silver") alt_kapak(); }

echo(str("KASA DIS: ", uzunluk, " (boy/X) x ", genislik, " (en/Y) x ", toplam_yuks, " mm"));
echo(str("USB X=", usb_cx, " (orta)  kart merkezi X=", bd_cx, "  kart X[", board_l, "..", board_r, "]"));
