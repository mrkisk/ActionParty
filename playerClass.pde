Player[] player;

class Player {
    float x, y, pw, ph, xspd, xm, yspd, j, jp, fp;
    int chak, pNum, uk, dk, rk, lk, jk, ck, jt, iNum; //kはKEY
    float[] timer = new float[100];
    boolean death;
    boolean kick;
    boolean ladd;
    boolean clear;
    Player(int pNum) {
        this.pNum = pNum;

        if (pNum == 0) { //rfgdsa
            uk = 82;
            dk = 70;
            rk = 71;
            lk = 68;
            jk = 83;
            ck = 65;
        }
        if (pNum == 1) { //上下左右\/
            uk = 38;
            dk = 40;
            rk = 39;
            lk = 37;
            jk = 92;
            ck = 47;
        }
        if (pNum == 2) { //hnmbvc
            uk = 72;
            dk = 78;
            rk = 77;
            lk = 66;
            jk = 86;
            ck = 67;
        }
        if (pNum == 3) { //@:];lk
            uk = 512;
            dk = 513;
            rk = 93;
            lk = 59;
            jk = 76;
            ck = 75;
        }
        pw = pg[pNum][0].width/3*2;
        ph = pg[pNum][0].height/3*2;
        for (int i=0; i<4; i++) {
            if (pNum == i) {
                if (game.stage == 0) {
                    x = 30*4 + i*30;
                    y = 30*25 - ph;
                }
                if (game.stage == 1) {
                    x = 30*6 + i*30;
                    y = 30*20 - ph;
                }
            }
        }
        j = height-200-pw;
        xm = 4.5; //歩く最大の速さ
        jp = 11; //ジャンプ力
        fp = 0.7; //落ちる速さ
        jt = 12; //押す長さで調整
        death = false;
        kick = true;
        ladd = false;
        clear = false;
    }
    void jUpdate() {
        j = height*2;
    }
    void moving() {
        if (death == false) {
            timer[4] = 0;
            for (Ladder b : ladder)if (collision(x, y, pw, ph, b.x+2, b.y, b.pw, b.ph))timer[4] += 1;
            if (timer[4] == 0) {
                ladd = false;
            } else if (keyboardd[uk]) {
                if (ladd == false) {
                    chak = 0;
                    xspd = 0;
                    yspd = 0;
                    timer[0] = 0;
                    timer[1] = 0;
                    timer[3] = 0;
                    iNum = 6;
                }
                ladd = true;
            }
            if (keyboardd[jk]) {
                if (ladd == true)j = y;
                ladd = false;
            }
            if (ladd == false) {
                if (timer[1] == 0) {
                    if (keyboard[rk] == true && keyboard[lk] == false && death == false)xspd += xm/5;
                    else if (keyboard[rk] == false && keyboard[lk] == true && death == false)xspd -= xm/5;
                    else xspd = xspd/10*7;
                } else {
                    if (timer[2] == 0)xspd = -xm;
                    else xspd = xm;
                    timer[1] += 1;
                    if (timer[1] >= 10)timer[1] = 0;
                }
                if (xspd > xm)xspd = xm;
                if (xspd < -xm)xspd = -xm;
                if (y >= j) {
                    chak = 0;
                    yspd = 0;
                    y = j;
                } else {
                    if (chak != 1)chak = 2;
                }
                kick = true;
                if (keyboardd[jk] && chak == 0 && death == false) {
                    chak = 1;
                    kick = false;
                    timer[0] = 0;
                    yspd = -jp;
                }
                if (chak == 1) {
                    yspd = -jp;
                    timer[0] += 1;
                    if (timer[0] >= jt)chak = 2;
                    if (keyboard[jk] == false)chak = 2;
                }
                if (chak == 2) {
                    yspd += fp;
                    if (yspd > jp/3*4)yspd = jp/3*4;
                }
                if (clear == false && death == false) {
                    x += xspd;
                    y += yspd;
                }
            } else {
                if (keyboard[lk])x -= 3;
                if (keyboard[rk])x += 3;
                if (keyboard[uk])y -= 3;
                if (keyboard[dk]) {
                    y += 3;
                    iNum = 6;
                } else if (keyboard[lk] || keyboard[rk] || keyboard[uk]) {
                    timer[5] += 1;
                    iNum = int(timer[6])+4;
                } else timer[5] = 0;
                if (timer[5] > 12) {
                    if (timer[6] == 0)timer[6] = 1;
                    else timer[6] = 0;
                    timer[5] = 0;
                    iNum = int(timer[6])+4;
                }
            }
        }
    }
    void dUpdate() {
        if (death == false && y >= height)death = true;
    }
    void drawing() {
        if (death == true)image(pg[pNum][3], x, y, pw, ph);
        else if (clear == true) {
            timer[7] += 1;
            if (timer[7] >= 20) {
                scale(-1, 1);
                image(pg[pNum][2], -x-pw, y, pw, ph);
                scale(-1, 1);
            } else {
                image(pg[pNum][2], x, y, pw, ph);
            }
            if (timer[7] >= 40)timer[7] = 0;
        } else {
            if (ladd == false) {
                if (keyboard[rk] == true && keyboard[lk] == false) {
                    if (chak == 0) image(pg[pNum][1], x, y, pw, ph);
                    else image(pg[pNum][2], x, y, pw, ph);
                } else if (keyboard[rk] == false && keyboard[lk] == true) {
                    scale(-1, 1);
                    if (chak == 0) image(pg[pNum][1], -x-pw, y, pw, ph);
                    else image(pg[pNum][2], -x-pw, y, pw, ph);
                    scale(-1, 1);
                } else image(pg[pNum][0], x, y, pw, ph);
            } else {
                image(pg[pNum][iNum], x, y, pw, ph);
            }
        }
    }
    void tagDraw() {
        if (pNum == 0)fill(255);
        if (pNum == 1)fill(255, 85, 89);
        if (pNum == 2)fill(0, 162, 132);
        if (pNum == 3)fill(255, 242, 0);
        textAlign(CENTER);
        outlineText("１Ｐ", x+pw/2, y-15, 12, color(255), color(0));
    }
}
