ArrayList<Block> block;

class Block {
    float x, y, bw, bh;
    int type, ply;
    Block(float x, float y, float bw, float bh, int type, int ply) {
        this.x = x;
        this.y = y;
        this.bw = bw;
        this.bh = bh;
        this.type = type;
        this.ply = ply;
    }
    void update() {
        for (Player b : player) {
            if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + bh) {
                b.x = x-b.pw;
                b.xspd = 0;
                if (keyboard[b.rk] && type != -1) {
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
            if (b.x <= x+bw && b.x+b.xm >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                b.x = x+bw;
                b.xspd = 0;
                if (keyboard[b.lk] && type != -1) {
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
            if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + bh) {
                b.x = x-b.pw;
                b.xspd = 0;
            }
            if (b.x <= x+bw && b.x+b.xm >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                b.x = x+bw;
                b.xspd = 0;
            }
            if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph > y && b.y+b.ph-b.jp/3*4 < y) {
                b.ladd = false;
            }
            if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph >= y && b.y+b.ph-b.jp/3*4 < y) {
                b.j = y-b.ph;
                b.y = y-b.ph;
                b.timer[3] = 0;
            }
            if (b.x+b.pw > x && b.x < x+bw && b.y <= y+bh && b.y+b.jp >= y+bh) {
                b.yspd = -b.yspd/5;
                b.y = y+bh;
                b.timer[0] = b.jt;
            }
        }
        for (Mob1 b : mob1) {
            if (b.x+b.pw >= x && b.x+b.pw-3 <= x && b.y+b.ph > y && b.y < y + bh) {
                b.x = x-b.pw;
                b.dir = 1;
            }
            if (b.x <= x+bw && b.x+3 >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                b.x = x+bw;
                b.dir = 0;
            }
            if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph >= y && b.y+b.ph-player[0].jp/3*4 < y) {
                b.yspd = 0;
                b.y = y-b.ph;
            }
        }
    }
    void drawing() {
        if (type == 0)image(bk[0], x, y);
        if (type == 1)image(bk[1], x, y);
        if (type == 2) {
            for (int i=0; i<bw; i+=30) {
                image(bk[2], x+i, y);
                for (int j=30; j<bh; j+=30) {
                    image(bk[3], x+i, y+j);
                }
            }
        }
        if (type == 3) {
            for (int i=0; i<bw; i+=30) {
                image(bk[4], x+i, y);
                for (int j=30; j<bh; j+=30) {
                    image(bk[5], x+i, y+j);
                }
            }
        }
        if (type == 4) {
            if (bh == 30) {
                for (int i=0; i<bw/30; i++) {
                    int j = 0;
                    if (i == 0)j = 0;
                    if (i > 0 && i < bw/30-1)j = 1;
                    if (i == bw/30-1)j = 2;
                    image(bk2[j], x+i*30, y);
                }
            }
            if (bw == 30) {
                for (int i=0; i<bh/30; i++) {
                    int j = 0;
                    if (i == 0)j = 0;
                    if (i > 0 && i < bh/30-1)j = 1;
                    if (i == bh/30-1)j = 2;
                    pushMatrix();
                    translate(x+15, y+i*30+15);
                    scale(-1, 1);
                    rotate(PI/2);
                    image(bk2[j], -15, -15);
                    popMatrix();
                }
            }
        }
    }
}

ArrayList<Lblock>lblock;

class Lblock {
    float x, y, rl;
    int ply;
    Lblock(float x, float y, int rl, int ply) {
        this.x = x;
        this.y = y;
        this.rl = rl;
        this.ply = ply;
        if (rl == 0) {
            for (int i = -3; i <= 0; i++)block.add(new Block(x+30*i, y, 30, 30, -2, ply));
            for (int i = -3; i <= -1; i++)block.add(new Block(x, y+30*i, 30, 30, -2, ply));
        }
        if (rl == 1) {
            for (int i = 0; i <= 3; i++)block.add(new Block(x+30*i, y, 30, 30, -2, ply));
            for (int i = -3; i <= -1; i++)block.add(new Block(x, y+30*i, 30, 30, -2, ply));
        }
        if (rl == 2) {
            for (int i = 0; i <= 3; i++)block.add(new Block(x+30*i, y, 30, 30, -2, ply));
            for (int i = 1; i <= 3; i++)block.add(new Block(x, y+30*i, 30, 30, -2, ply));
        }
        if (rl == 3) {
            for (int i = -3; i <= 0; i++)block.add(new Block(x+30*i, y, 30, 30, -2, ply));
            for (int i = 1; i <= 3; i++)block.add(new Block(x, y+30*i, 30, 30, -2, ply));
        }
    }
    void drawing() {
        if (rl == 0) {
            for (int i = -3; i <= 0; i++)image(bk[0], x+30*i, y);
            for (int i = -3; i <= -1; i++)image(bk[0], x, y+30*i);
        }
        if (rl == 1) {
            for (int i = 0; i <= 3; i++)image(bk[0], x+30*i, y);
            for (int i = -3; i <= -1; i++)image(bk[0], x, y+30*i);
        }
        if (rl == 2) {
            for (int i = 0; i <= 3; i++)image(bk[0], x+30*i, y);
            for (int i = 1; i <= 3; i++)image(bk[0], x, y+30*i);
        }
        if (rl == 3) {
            for (int i = -3; i <= 0; i++)image(bk[0], x+30*i, y);
            for (int i = 1; i <= 3; i++)image(bk[0], x, y+30*i);
        }
    }
}

ArrayList<Komei>komei;

class Komei {
    float x, y, bw, bh;
    int ply;
    boolean appear;
    Komei(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;
        bw = 30;
        bh = 30;
        appear = false;
    }
    void update() {
        if (appear == false)for (Player b : player) {
            if (appear == false && b.x+b.pw > x && b.x < x+bw && b.y <= y+bh && b.y+b.jp >= y+bh && b.yspd < 0) {
                block.add(new Block(x, y, bw, bh, 0, ply));
            }
        }
    }
}

ArrayList<Fall>fall;
int fNum = 0;

class Fall {
    float x, y, bw, bh, yspd;
    int num, ply;
    Fall(float x, float y, int ply) {
        this.x = x;
        this.y = y;
        this.ply = ply;
        fNum += 1;
        num = fNum;
        bw = 30;
        bh = 30;
    }
    void update() {
        if (yspd == 0) {
            for (Player b : player) {
                if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + bh) {
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
                if (b.x <= x+bw && b.x+b.xm >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x+bw;
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
                if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x-b.pw;
                    b.xspd = 0;
                }
                if (b.x <= x+bw && b.x+b.xm >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x+bw;
                    b.xspd = 0;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph > y && b.y+b.ph-b.jp/3*4 < y) {
                    b.ladd = false;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph >= y && b.y+b.ph-b.jp/3*4 < y) {
                    b.j = y-b.ph;
                    b.y = y-b.ph;
                    yspd += 0.1;
                    b.timer[3] = 0;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y <= y+bh && b.y+b.jp >= y+bh) {
                    b.yspd = -b.yspd/5;
                    b.y = y+bh;
                    b.timer[0] = b.jt;
                }
            }
            for (Mob1 b : mob1) {
                if (b.x+b.pw >= x && b.x+b.pw-3 <= x && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x-b.pw;
                    b.dir = 1;
                }
                if (b.x <= x+bw && b.x+3 >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x+bw;
                    b.dir = 0;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph >= y && b.y+b.ph-player[0].jp/3*4 < y) {
                    b.yspd = 0;
                    b.y = y-b.ph;
                }
            }
        } else {
            yspd += 0.1;
            if (yspd > 10)yspd = 10;
            y += yspd;
            for (Player b : player) {
                if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + bh) {
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
                if (b.x <= x+bw && b.x+b.xm >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x+bw;
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
                if (b.x+b.pw >= x && b.x+b.pw-b.xm <= x && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x-b.pw;
                    b.xspd = 0;
                }
                if (b.x <= x+bw && b.x+b.xm >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x+bw;
                    b.xspd = 0;
                }
                if (b.timer[3] == num) {
                    if (b.chak == 0)b.y = y-b.ph;
                    else b.timer[3] = 0;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph >= y && b.y+b.ph-b.jp/3*4 < y) {
                    b.j = y-b.ph;
                    b.y = y-b.ph;
                    b.timer[3] = num;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y <= y+bh && b.y+b.jp >= y+bh) {
                    b.yspd = -b.yspd/5;
                    b.y = y+bh;
                    b.timer[0] = b.jt;
                }
            }
            for (Mob1 b : mob1) {
                if (b.x+b.pw >= x && b.x+b.pw-3 <= x && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x-b.pw;
                    b.dir = 1;
                }
                if (b.x <= x+bw && b.x+3 >= x+bw && b.y+b.ph > y && b.y < y + bh) {
                    b.x = x+bw;
                    b.dir = 0;
                }
                if (b.x+b.pw > x && b.x < x+bw && b.y+b.ph >= y && b.y+b.ph-player[0].jp/3*4 < y) {
                    b.y = y-b.ph;
                }
            }
        }
    }
    void drawing() {
        image(bk[6], x, y);
    }
}
