ArrayList<Info>info;

class Info {
    String type;
    float data[] = new float[6];
    float[] timer = new float[100];
    float x, y;
    boolean br = false;
    Info(String type, float data0, float data1, float data2, float data3, float data4, float data5) {
        this.type = type;
        data[0] = data0;
        data[1] = data1;
        data[2] = data2;
        data[3] = data3;
        data[4] = data4;
        data[5] = data5;
        x = data[0];
        y = data[1];
    }
    void fUpdate() {
        game.setb[int(game.clx/30)][int(game.cly/30)] = false;
        game.setb[int(game.clx/30)][int(game.cly/30)+1] = false;
        if (type == "block" && data[4] >= 0) {
            for (int i = 0; i < data[2]/30; i++)for (int j = 0; j < data[3]/30; j++)game.setb[int(x/30)+i][int(y/30)+j] = false;
        }
        if (type == "lblock") {
            if (data[2] == 0) {
                for (int i = -3; i <= 0; i++)game.setb[int(x/30)+i][int(y/30)] = false;
                for (int i = -3; i <= -1; i++)game.setb[int(x/30)][int(y/30)+i] = false;
            }
            if (data[2] == 1) {
                for (int i = 0; i <= 3; i++)game.setb[int(x/30)+i][int(y/30)] = false;
                for (int i = -3; i <= -1; i++)game.setb[int(x/30)][int(y/30)+i] = false;
            }
            if (data[2] == 2) {
                for (int i = 0; i <= 3; i++)game.setb[int(x/30)+i][int(y/30)] = false;
                for (int i = 1; i <= 3; i++)game.setb[int(x/30)][int(y/30)+i] = false;
            }
            if (data[2] == 3) {
                for (int i = -3; i <= 0; i++)game.setb[int(x/30)+i][int(y/30)] = false;
                for (int i = 1; i <= 3; i++)game.setb[int(x/30)][int(y/30)+i] = false;
            }
        }
        if (type == "fall" || type == "spring" || type == "komei" || type == "roll"
            || type == "cannon" || type == "needle" || type == "bneedle" || type == "mob1") {
            game.setb[int(x/30)][int(y/30)] = false;
        }
        if (type == "ladder") {
            for (int i = 0; i<4; i++)game.setb[int(x/30)][int(y/30)+i] = false;
        }
        if (type == "cloud") {
            for (int i = 0; i<3; i++)for (int j = 0; j<2; j++)game.setb[int(x/30)+i][int(y/30)+j] = false;
        }
        if (type == "tree") {
            for (int i = 0; i<2; i++)game.setb[int(x/30)][int(y/30)+i] = false;
        }
        if (type == "dossun") {
            for (int i = 0; i<2; i++)for (int j = 0; j<3; j++)game.setb[int(x/30)+i][int(y/30)+j] = false;
        }
    }
    void ffUpdate() {
        game.setb[int(game.clx/30)][int(game.cly/30)] = false;
        game.setb[int(game.clx/30)][int(game.cly/30)+1] = false;
        if (type == "block" && data[4] >= 0) {
            for (int i = 0; i < data[2]/30; i++)for (int j = 0; j < data[3]/30; j++)game.setb[int(x/30)+i][int(y/30)+j] = true;
        }
        if (type == "lblock") {
            if (data[2] == 0) {
                for (int i = -3; i <= 0; i++)game.setb[int(x/30)+i][int(y/30)] = true;
                for (int i = -3; i <= -1; i++)game.setb[int(x/30)][int(y/30)+i] = true;
            }
            if (data[2] == 1) {
                for (int i = 0; i <= 3; i++)game.setb[int(x/30)+i][int(y/30)] = true;
                for (int i = -3; i <= -1; i++)game.setb[int(x/30)][int(y/30)+i] = true;
            }
            if (data[2] == 2) {
                for (int i = 0; i <= 3; i++)game.setb[int(x/30)+i][int(y/30)] = true;
                for (int i = 1; i <= 3; i++)game.setb[int(x/30)][int(y/30)+i] = true;
            }
            if (data[2] == 3) {
                for (int i = -3; i <= 0; i++)game.setb[int(x/30)+i][int(y/30)] = true;
                for (int i = 1; i <= 3; i++)game.setb[int(x/30)][int(y/30)+i] = true;
            }
        }
        if (type == "fall" || type == "spring" || type == "komei" || type == "roll"
            || type == "cannon" || type == "needle" || type == "bneedle" || type == "mob1") {
            game.setb[int(x/30)][int(y/30)] = true;
        }
        if (type == "ladder") {
            for (int i = 0; i<4; i++)game.setb[int(x/30)][int(y/30)+i] = true;
        }
        if (type == "cloud") {
            for (int i = 0; i<3; i++)for (int j = 0; j<2; j++)game.setb[int(x/30)+i][int(y/30)+j] = true;
        }
        if (type == "tree") {
            for (int i = 0; i<2; i++)game.setb[int(x/30)][int(y/30)+i] = true;
        }
        if (type == "dossun") {
            for (int i = 0; i<2; i++)for (int j = 0; j<3; j++)game.setb[int(x/30)+i][int(y/30)+j] = true;
        }
    }
    void cUpdate(int lx, int ly) {
        br = false;
        if (type == "block" && data[4] >= 0 && (data[4] != 2 && data[4] != 3)) {
            for (int i = 0; i < data[2]/30; i++)for (int j = 0; j < data[3]/30; j++)if (int(x/30)+i == lx && int(y/30)+j == ly)br = true;
        }
        if (type == "lblock") {
            if (data[2] == 0) {
                for (int i = -3; i <= 0; i++)if (int(x/30)+i == lx && int(y/30) == ly)br = true;
                for (int i = -3; i <= -1; i++)if (int(x/30) == lx && int(y/30)+i == ly)br = true;
            }
            if (data[2] == 1) {
                for (int i = 0; i <= 3; i++)if (int(x/30)+i == lx && int(y/30) == ly)br = true;
                for (int i = -3; i <= -1; i++)if (int(x/30) == lx && int(y/30)+i == ly)br = true;
            }
            if (data[2] == 2) {
                for (int i = 0; i <= 3; i++)if (int(x/30)+i == lx && int(y/30) == ly)br = true;
                for (int i = 1; i <= 3; i++)if (int(x/30) == lx && int(y/30)+i == ly)br = true;
            }
            if (data[2] == 3) {
                for (int i = -3; i <= 0; i++)if (int(x/30)+i == lx && int(y/30) == ly)br = true;
                for (int i = 1; i <= 3; i++)if (int(x/30) == lx && int(y/30)+i == ly)br = true;
            }
        }
        if (type == "fall" || type == "spring" || type == "komei" || type == "roll"
            || type == "cannon" || type == "needle" || type == "bneedle" || type == "mob1") {
            if (int(x/30) == lx && int(y/30) == ly)br = true;
        }
        if (type == "ladder") {
            for (int i = 0; i<4; i++)if (int(x/30) == lx && int(y/30)+i == ly)br = true;
        }
        if (type == "cloud") {
            for (int i = 0; i<3; i++)for (int j = 0; j<2; j++)if (int(x/30)+i == lx && int(y/30)+j == ly)br = true;
        }
        if (type == "tree") {
            for (int i = 0; i<2; i++)if (int(x/30) == lx && int(y/30)+i == ly)br = true;
        }
        if (type == "dossun") {
            for (int i = 0; i<2; i++)for (int j = 0; j<3; j++)if (int(x/30)+i == lx && int(y/30)+j == ly)br = true;
        }
    }
    void drawing() {
        if (type == "block") {
            if (data[4] == 0)image(bk[0], data[0], y);
            if (data[4] == 1)image(bk[1], x, y);
            if (data[4] == 2) {
                for (int i=0; i<data[2]; i+=30) {
                    image(bk[2], x+i, y);
                    for (int j=30; j<data[3]; j+=30) {
                        image(bk[3], x+i, y+j);
                    }
                }
            }
            if (data[4] == 3) {
                for (int i=0; i<data[2]; i+=30) {
                    image(bk[4], x+i, y);
                    for (int j=30; j<data[3]; j+=30) {
                        image(bk[5], x+i, y+j);
                    }
                }
            }
            if (data[4] == 4) {
                if (data[3] == 30) {
                    for (int i=0; i<data[2]/30; i++) {
                        int j = 0;
                        if (i == 0)j = 0;
                        if (i > 0 && i < data[2]/30-1)j = 1;
                        if (i == data[2]/30-1)j = 2;
                        image(bk2[j], x+i*30, y);
                    }
                }
                if (data[2] == 30) {
                    for (int i=0; i<data[3]/30; i++) {
                        int j = 0;
                        if (i == 0)j = 0;
                        if (i > 0 && i < data[3]/30-1)j = 1;
                        if (i == data[3]/30-1)j = 2;
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
        if (type == "lblock") {
            if (data[2] == 0) {
                for (int i = -3; i <= 0; i++)image(bk[0], x+30*i, y);
                for (int i = -3; i <= -1; i++)image(bk[0], x, y+30*i);
            }
            if (data[2] == 1) {
                for (int i = 0; i <= 3; i++)image(bk[0], x+30*i, y);
                for (int i = -3; i <= -1; i++)image(bk[0], x, y+30*i);
            }
            if (data[2] == 2) {
                for (int i = 0; i <= 3; i++)image(bk[0], x+30*i, y);
                for (int i = 1; i <= 3; i++)image(bk[0], x, y+30*i);
            }
            if (data[2] == 3) {
                for (int i = -3; i <= 0; i++)image(bk[0], x+30*i, y);
                for (int i = 1; i <= 3; i++)image(bk[0], x, y+30*i);
            }
        }
        if (type == "fall") {
            image(bk[6], x, y);
        }
        if (type == "spring") {
            imageMode(CENTER);
            pushMatrix();
            translate(x+15, y+15);
            rotate(PI/2*data[2]);
            image(spr, 0, 0);
            popMatrix();
            imageMode(CORNER);
        }
        if (type == "ladder") {
            for (int i = 0; i<120; i += 30)image(lad, x, y+i);
        }
        if (type == "komei") {
            image(bk[0], x, y);
            image(arr, x-5, y+30);
        }
        if (type == "roll") {
            if (data[2] == 0)timer[0] += 1.5;
            else timer[0] -= 1.5;
            image(bk[1], x, y);
            stroke(63, 72, 204);
            strokeWeight(3);
            line(x+15, y+15, x+cos(radians(timer[0]-90))*60+15, y+sin(radians(timer[0]-90))*60+15);
            stroke(0);
            strokeWeight(1);
            image(guru, x+cos(radians(timer[0]-90))*60, y+sin(radians(timer[0]-90))*60);
        }
        if (type == "cannon") {
            if (data[2] == 0)image(can, x, y);
            else {
                scale(-1, 1);
                image(can, -x-30, y);
                scale(-1, 1);
            }
        }
        if (type == "needle") {
            imageMode(CENTER);
            pushMatrix();
            translate(x+15, y+15);
            rotate(PI/2*data[2]);
            image(hari, 0, 0);
            popMatrix();
            imageMode(CORNER);
        }
        if (type == "bneedle") {
            timer[0] += 1;
            if (timer[0] <= nCool)timer[1] = 0;
            if (timer[0] >= nCool && timer[0] <= nCool+12)timer[1] = (timer[0]-nCool)/2;
            if (timer[0] >= 120-12 && timer[0] <= 120)timer[1] = (120-timer[0])/2;
            if (timer[0] >= 120)timer[0] = 0;
            for (int i = 0; i < 4; i++) {
                imageMode(CENTER);
                pushMatrix();
                translate(x+15+cos(PI/2*(i-1))*(24+timer[1]), y+15+sin(PI/2*(i-1))*(24+timer[1]));
                rotate(PI/2*i);
                image(bhar, 0, 0);
                popMatrix();
                imageMode(CORNER);
            }
            image(bk[1], x, y);
        }
        if (type == "mob1") {
            timer[0] += 1;
            if (timer[0] > 60)timer[0] = 1;
            if (timer[0] <= 30)image(mb1[0], x, y);
            if (timer[0] > 30)image(mb1[1], x, y);
        }
        if (type == "cloud") {
            image(cld[0], x, y);
        }
        if (type == "tree") {
            image(tre, x, y);
        }
        if (type == "dossun") {
            image(dsn[0], x, y);
        }
    }
    void setting() {
        if (type == "block")block.add(new Block(data[0], data[1], data[2], data[3], int(data[4]), int(data[5])));
        if (type == "lblock")lblock.add(new Lblock(data[0], data[1], int(data[2]), int(data[3])));
        if (type == "fall")fall.add(new Fall(data[0], data[1], int(data[2])));
        if (type == "komei")komei.add(new Komei(data[0], data[1], int(data[2])));
        if (type == "roll")roll.add(new Roll(data[0], data[1], int(data[2]), int(data[3])));
        if (type == "cannon")cannon.add(new Cannon(data[0], data[1], int(data[2]), int(data[3])));
        if (type == "needle")needle.add(new Needle(data[0], data[1], int(data[2]), int(data[3])));
        if (type == "spring")spring.add(new Spring(data[0], data[1], int(data[2]), int(data[3])));
        if (type == "ladder")ladder.add(new Ladder(data[0], data[1], int(data[2])));
        if (type == "bneedle")bneedle.add(new Bneedle(data[0], data[1], int(data[2])));
        if (type == "mob1")mob1.add(new Mob1(data[0], data[1], int(data[2])));
        if (type == "cloud")cloud.add(new Cloud(data[0], data[1], int(data[2])));
        if (type == "tree")tree.add(new Tree(data[0], data[1], int(data[2])));
        if (type == "dossun")dossun.add(new Dossun(data[0], data[1], int(data[2])));
    }
}
