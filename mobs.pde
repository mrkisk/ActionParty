ArrayList<Mob1>mob1;

class Mob1 {
    float x, y, pw, ph, yspd;
    int dir, ply;
    float[] timer = new float[100];
    boolean appear;
    Mob1(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;

        pw = 30;
        ph = 30;
        dir = 0;
        appear = true;
    }
    void moving() {
        if (appear == true) {
            if (timer[1] == 0) {
                if (dir == 0)x += 1;
                else x -= 1;
            } else {
                timer[1] += 1;
                if (timer[1] >= 10)timer[1] = 0;
                if (timer[2] == 0)x -= 6;
                if (timer[2] == 1)x += 6;
            }
            yspd += player[0].fp;
            if (yspd > player[0].jp/3*4)yspd = player[0].jp/3*4;
            y += yspd;
        }
    }
    void update() {
        if (appear == true)for (Player b : player)if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph >= y && b.y+b.ph-b.jp/3*4 < y && b.yspd > 0) {
            appear = false;
            b.chak = 1;
            b.timer[0] = 0;
            b.yspd = -b.jp;
        }
    }
    void dUpdate() {
        if (appear == true)for (Player b : player)if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, x, y, pw, ph)) {
            b.death = true;
            if (ply != b.pNum)game.tr[ply] += 1;
        }
    }
    void drawing() {
        if (appear == true) {
            timer[0] += 1;
            if (timer[0] > 60)timer[0] = 1;
            if (timer[0] <= 30)image(mb1[0], x, y);
            if (timer[0] > 30)image(mb1[1], x, y);
        }
    }
}

ArrayList<Cloud>cloud;

class Cloud {
    float x, y, pw, ph;
    int moves, ply;
    Cloud(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;

        pw = 90;
        ph = 60;
        moves = 0;
    }
    void moving() {
        for (Player b : player) {
            if (b.x+b.pw/3*4 > x && b.x-b.pw/3 < x+pw && b.y >= y + ph)moves = 1;
        }
        if (moves == 1)y += 10;
    }
    void dUpdate() {
        for (Player b : player) {
            if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, x, y, pw, ph)) {
                b.death = true;
                if (ply != b.pNum)game.tr[ply] += 1;
            }
        }
    }
    void drawing() {
        image(cld[moves], x, y);
    }
}

ArrayList<Tree>tree;

class Tree {
    float x, y, pw, ph;
    int ply;
    Tree(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;
        pw = 30;
        ph = 60;
    }
    void update() {
        for (Mob1 b : mob1) {
            if (b.x+b.pw >= x && b.x+b.pw-3 <= x && b.y+b.ph > y && b.y < y + ph) {
                b.x = x-b.pw;
                b.dir = 1;
            }
            if (b.x <= x+pw && b.x+3 >= x+pw && b.y+b.ph > y && b.y < y + ph) {
                b.x = x+pw;
                b.dir = 0;
            }
            if (b.x+b.pw > x && b.x < x+pw && b.y+b.ph >= y && b.y+b.ph-player[0].jp/3*4 < y) {
                b.yspd = 0;
                b.y = y-b.ph;
            }
        }
    }
    void dUpdate() {
        for (Player b : player) {
            if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, x, y, pw, ph)) {
                b.death = true;
                if (ply != b.pNum)game.tr[ply] += 1;
            }
        }
    }
    void drawing() {
        image(tre, x, y);
    }
}

ArrayList<Dossun>dossun;

class Dossun {
    float x, y, tx, ty, pw, ph;
    int mode, ply;
    Dossun(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;
        tx = x;
        ty = y;
        pw = 60;
        ph = 90;
        mode = 0;
    }
    void moving() {
        if (mode == 0) {
            for (Player b : player) {
                if (b.death == false && b.x+b.pw/3*4 > x && b.x-b.pw/3 < x+pw && b.y >= y + ph)mode = 1;
            }
        }
        if (mode == 1) {
            y += 10;
            for (Block b : block) {
                if (x+pw > b.x && x < b.x+b.bw && y+ph >= b.y && y+ph-10 < b.y) {
                    mode = 2;
                }
                //if (x+pw > b.x && x < b.x+b.bw && b.y <= y+bh && b.y+b.jp >= y+bh) {
                //  b.yspd = -b.yspd/5;
                //  b.y = y+bh;
                //  b.timer[0] = b.jt;
                //}
            }
            for (Fall b : fall) {
                if (x+pw > b.x && x < b.x+b.bw && y+ph >= b.y && y+ph-10 < b.y) {
                    mode = 2;
                }
                //if (x+pw > b.x && x < b.x+b.bw && b.y <= y+bh && b.y+b.jp >= y+bh) {
                //  b.yspd = -b.yspd/5;
                //  b.y = y+bh;
                //  b.timer[0] = b.jt;
                //}
            }
            for (Spring b : spring) {
                if (x+pw > b.x && x < b.x+b.pw && y+ph >= b.y && y+ph-10 < b.y) {
                    mode = 2;
                }
                //if (x+pw > b.x && x < b.x+b.bw && b.y <= y+bh && b.y+b.jp >= y+bh) {
                //  b.yspd = -b.yspd/5;
                //  b.y = y+bh;
                //  b.timer[0] = b.jt;
                //}
            }
        }
        if (mode == 2) {
            y -= 1.5;
            if (y <= ty) {
                y = ty;
                mode = 0;
            }
        }
    }
    void dUpdate() {
        for (Player b : player) {
            if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, x, y, pw, ph)) {
                b.death = true;
                if (ply != b.pNum)game.tr[ply] += 1;
            }
        }
    }
    void drawing() {
        if (mode != 1)image(dsn[0], x, y);
        else image(dsn[1], x, y);
    }
}
