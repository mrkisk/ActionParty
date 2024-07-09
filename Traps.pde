ArrayList<Roll>roll;

class Roll {
    float x, y, rx, ry, pw, ph, dir, dia, spd;
    int rl, ply;
    Roll(float x, float y, int rl, int ply) {
        this.x = x;
        this.y = y;
        this.rl = rl;
        this.ply = ply;
        dia = 60;
        spd = 0;
        pw = 30;
        ph = 30;
        rx = x+cos(radians(spd-90))*dia;
        ry = y+sin(radians(spd-90))*dia;
        block.add(new Block(x, y, 30, 30, 1, ply));
    }
    void moving() {
        if (rl == 0)spd += 1.5;
        else spd -= 1.5;
        rx = x+cos(radians(spd-90))*dia;
        ry = y+sin(radians(spd-90))*dia;
    }
    void dUpdate() {
        for (Player b : player) {
            if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, rx, ry, pw, ph)) {
                b.death = true;
                if (ply != b.pNum)game.tr[ply] += 1;
            }
        }
    }
    void drawing() {
        stroke(63, 72, 204);
        strokeWeight(3);
        line(x+15, y+15, rx+15, ry+15);
        stroke(0);
        strokeWeight(1);
        image(guru, rx, ry);
    }
}

ArrayList<Cannon>cannon;

class Cannon {
    float x, y, pw, ph;
    int rl, ply;
    float[] timer = new float[10];
    Cannon(float x, float y, int rl, int ply) {
        this.x = x;
        this.y = y;
        this.rl = rl;
        this.ply = ply;
        pw = 30;
        ph = 30;
        block.add(new Block(x, y, 30, 30, -2, ply));
    }
    void update() {
    }
    void shot() {
        timer[0] += 1;
        if (timer[0] >= 120) {
            timer[0] = 0;
            if (rl == 0)bullet.add(new Bullet(x-3, y-3, rl, ply));
            if (rl == 1)bullet.add(new Bullet(x+pw+3, y-3, rl, ply));
        }
    }
    void drawing() {
        if (rl == 0)image(can, x, y);
        else {
            scale(-1, 1);
            image(can, -x-pw, y);
            scale(-1, 1);
        }
    }
}

ArrayList<Bullet>bullet;

class Bullet {
    float x, y, pw, ph, yspd;
    int rl, ply;
    boolean appear;
    float[] timer = new float[20];
    Bullet(float x, float y, int rl, int ply) {
        this.x = x;
        this.y = y;
        this.rl = rl;
        this.ply = ply;
        pw = 12;
        ph = 12;
        yspd = -4;
        appear = true;
    }
    void update() {
        if (appear == true) {
            if (rl == 0)x -= 2.5;
            else x += 2.5;
            yspd += 0.04;
            if (yspd >4)yspd = 4;
            y += yspd;
        }
    }
    void dUpdate() {
        if (appear == true) {
            if (y+ph/2 > height) {
                appear = false;
            }
            for (Block b : block) {
                if (collision(b.x, b.y, b.bw, b.bh, x-pw/2, y-ph/2, pw, ph))appear = false;
            }
            for (Fall b : fall) {
                if (collision(b.x, b.y, b.bw, b.bh, x-pw/2, y-ph/2, pw, ph))appear = false;
            }
        }
        if (appear == true) {
            for (Player b : player) {
                if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, x-pw/2, y-ph/2, pw, ph)) {
                    b.death = true;
                    appear = false;
                    if (ply != b.pNum)game.tr[ply] += 1;
                }
            }
        }
    }
    void drawing() {
        if (appear == true) {
            fill(0);
            ellipse(x, y, pw, ph);
        }
    }
}

ArrayList<Needle>needle;

class Needle {
    float x, y, pw, ph, bw, bh, rl;
    int ply;
    Needle(float x, float y, int rl, int ply) {
        this.x = x;
        this.y = y;
        this.rl = rl;
        this.ply = ply;

        if (rl == 0 || rl == 2) {
            pw = 30;
            ph = 25;
            bw = 30;
            bh = 5;
        }
        if (rl == 1 || rl == 3) {
            pw = 30;
            ph = 25;
            bw = 5;
            bh = 30;
        }
        if (rl == 0)y += 25;
        if (rl == 3)x += 25;
        block.add(new Block(x, y, bw, bh, -2, ply));
        if (rl == 0)y -= 25;
        if (rl == 3)x -= 25;
    }
    void update() {
    }
    void dUpdate() {
        if (rl == 1)x += 5;
        if (rl == 2)y += 5;
        for (Player b : player) {
            if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, x, y, pw, ph)) {
                b.death = true;
                if (ply != b.pNum)game.tr[ply] += 1;
            }
        }
        if (rl == 1)x -= 5;
        if (rl == 2)y -= 5;
    }
    void drawing() {
        imageMode(CENTER);
        pushMatrix();
        translate(x+15, y+15);
        rotate(PI/2*rl);
        image(hari, 0, 0);
        popMatrix();
        imageMode(CORNER);
    }
}

ArrayList<Spring>spring;

class Spring {
    float x, y, pw, ph, rl;
    int ply;
    Spring(float x, float y, int rl, int ply) {
        this.x = x;
        this.y = y;
        this.rl = rl;
        this.ply = ply;
        pw = 30;
        ph = 30;
    }
    void update() {
        for (Player b : player) {
            if (rl == 0) {
                if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x-b.pw;
                    b.xspd = 0;
                    if (keyboard[b.rk]) {
                        if (b.yspd > b.jp/4)b.yspd = b.jp/4;
                        if (b.chak != 0 && keyboardd[b.jk] && b.kick == true) {
                            b.xspd = -b.xm;
                            b.chak = 2;
                            b.timer[0] = 12;
                            b.yspd = -b.jp;
                            b.timer[1] = 1;
                            b.timer[2] = 0; //右方向にキック
                        }
                    }
                }
                if (b.x <= x+pw && b.x+b.xm >= x+pw && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x+pw;
                    b.xspd = 0;
                    if (keyboard[b.lk]) {
                        if (b.yspd > b.jp/4)b.yspd = b.jp/4;
                        if (b.chak != 0 && keyboardd[b.jk] && b.kick == true) {
                            b.xspd = b.xm;
                            b.chak = 2;
                            b.timer[0] = 12;
                            b.yspd = -b.jp;
                            b.timer[1] = 1;
                            b.timer[2] = 1; //右方向にキック
                        }
                    }
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph > y && b.y+b.ph-b.jp/3*4 < y) {
                    b.ladd = false;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph >= y && b.y+b.ph-b.jp/3*4 < y && b.yspd >= 0) {
                    b.y = y-b.ph;
                    b.chak = 1;
                    b.timer[0] = 0;
                    b.yspd = -b.jp;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y <= y+ph && b.y+b.jp >= y+ph) {
                    b.yspd = b.jp/2;
                    b.y = y+ph;
                    b.timer[0] = b.jt;
                }
            }
            if (rl == 1) {
                if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x-b.pw;
                    b.xspd = 0;
                    b.timer[1] = 1;
                    b.timer[2] = 0;
                }
                if (b.x <= x+pw && b.x+b.xm >= x+pw && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x+pw;
                    b.xspd = 0;
                    b.timer[1] = 1;
                    b.timer[2] = 1;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph > y && b.y+b.ph-b.jp/3*4 < y) {
                    b.ladd = false;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph >= y && b.y+b.ph-b.jp/3*4 < y) {
                    b.j = y-b.ph;
                    b.y = y-b.ph;
                    b.timer[3] = 0;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y <= y+ph && b.y+b.jp >= y+ph) {
                    b.yspd = -b.yspd/5;
                    b.y = y+ph;
                    b.timer[0] = b.jt;
                }
            }
        }
        for (Mob1 b : mob1) {
            if (rl == 0) {
                if (b.x+b.pw >= x && b.x+b.pw-3 <= x && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x-b.pw;
                    b.dir = 1;
                    //b.timer[1] = 0;
                }
                if (b.x <= x+pw && b.x+3 >= x+pw && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x+pw;
                    b.dir = 0;
                    //b.timer[1] = 0;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph >= y && b.y+b.ph-player[0].jp/3*4 < y) {
                    b.yspd = -player[0].jp;
                    b.y = y-b.ph;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y <= y+ph && b.y+player[0].jp >= y+ph) {
                    b.yspd = player[0].jp/2;
                    b.y = y+ph;
                }
            }
            if (rl == 1) {
                if (b.x+b.pw >= x && b.x+b.pw-3 <= x && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x-b.pw;
                    b.dir = 1;
                    //b.timer[1] = 1;
                    //b.timer[2] = 0;
                }
                if (b.x <= x+pw && b.x+3 >= x+pw && b.y+b.ph > y && b.y < y + ph) {
                    b.x = x+pw;
                    b.dir = 0;
                    //b.timer[1] = 1;
                    //b.timer[2] = 1;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph >= y && b.y+b.ph-player[0].jp/3*4 < y) {
                    b.yspd = 0;
                    b.y = y-b.ph;
                }
                if (b.x+b.pw > x && b.x < x+pw && b.y <= y+ph && b.y+player[0].jp >= y+ph) {
                    b.yspd = -b.yspd/5;
                    b.y = y+ph;
                }
            }
        }
    }
    void drawing() {
        imageMode(CENTER);
        pushMatrix();
        translate(x+15, y+15);
        rotate(PI/2*rl);
        image(spr, 0, 0);
        popMatrix();
        imageMode(CORNER);
    }
}

ArrayList<Ladder>ladder;

class Ladder {
    float x, y, pw, ph;
    int ply;
    Ladder(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;

        pw = 26;
        ph = 120;
    }
    void drawing() {
        for (int i = 0; i<ph; i += 30)image(lad, x, y+i);
    }
}

ArrayList<Bneedle>bneedle;
int nCool = 60;

class Bneedle {
    float x, y, pw, ph, timer, lon;
    int ply;
    Bneedle(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;

        pw = 30;
        ph = 30;
        lon = 0;
        timer = 0;
        block.add(new Block(x, y, pw, ph, -2, ply));
    }
    void update() {
        timer += 1;
        if (timer <= nCool)lon = 0;
        if (timer >= nCool && timer <= nCool+12)lon = (timer-nCool)/2;
        if (timer >= 120-12 && timer <= 120)lon = (120-timer)/2;
        if (timer >= 120)timer = 0;
    }
    void dUpdate() {
        for (Player b : player) {
            if (b.clear == false && b.death == false && (collision(b.x, b.y, b.pw, b.ph, x, y-lon, pw, 6) || collision(b.x, b.y, b.pw, b.ph, x+pw-6+lon, y, 6, ph) || collision(b.x, b.y, b.pw, b.ph, x, y+ph-6+lon, pw, 6) || collision(b.x, b.y, b.pw, b.ph, x-lon, y, 6, ph))) {
                b.death = true;
                if (ply != b.pNum)game.tr[ply] += 1;
            }
        }
    }
    void drawing() {
        for (int i = 0; i < 4; i++) {
            imageMode(CENTER);
            pushMatrix();
            translate(x+15+cos(PI/2*(i-1))*(24+lon), y+15+sin(PI/2*(i-1))*(24+lon));
            rotate(PI/2*i);
            image(bhar, 0, 0);
            popMatrix();
            imageMode(CORNER);
        }
        image(bk[1], x, y);
    }
}
