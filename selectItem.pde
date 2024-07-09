ArrayList<Select>select;

class Select {
    String type;
    float data[] = new float[6];
    float[] timer = new float[100];
    float x, y, tagx, tagy;
    int hav;
    Select(String type, float data0, float data1, float data2, float data3, float data4, float data5) {
        this.type = type;
        data[0] = data0;
        data[1] = data1;
        data[2] = data2;
        data[3] = data3;
        data[4] = data4;
        data[5] = data5;
        x = data[0];
        y = data[1];
        hav = -1;
    }
    void update0() {
        for (Player b : player) {
            if (keyboard[b.jk] && game.ca[b.pNum] == true && hav == -1) {
                if (type == "block") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], data[2], data[3])) {
                        game.ca[b.pNum] = false;
                        tagx = x+(data[2]-30)/2;
                        tagy = y;
                        hav = b.pNum;
                        data[5] = hav;
                    }
                }
                if (type == "lblock") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                    } else if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1]-90, 30, 90)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                    } else if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0]-90, data[1], 90, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                    }
                    if (game.ca[b.pNum] == false) {
                        tagx = x+(-90)/2;
                        tagy = y;
                        data[3] = hav;
                    }
                }
                if (type == "fall") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "spring") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[3] = hav;
                    }
                }
                if (type == "ladder") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 120)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "komei") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 60)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "roll") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                    } else if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, x+cos(radians(timer[0]-90))*60+15, y+sin(radians(timer[0]-90))*60+15, 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                    }
                    if (game.ca[b.pNum] == false) {
                        tagx = x;
                        tagy = y;
                        data[3] = hav;
                    }
                }
                if (type == "cannon") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[3] = hav;
                    }
                }
                if (type == "needle") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[3] = hav;
                    }
                }
                if (type == "bneedle") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "mob1") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "cloud") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 90, 60)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x+(90-30)/2;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "tree") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 60)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "dossun") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 60, 90)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x+(60-30)/2;
                        tagy = y;
                        data[2] = hav;
                    }
                }
                if (type == "delete") {
                    if (collision(game.cx[b.pNum], game.cy[b.pNum], 1, 1, data[0], data[1], 30, 30)) {
                        game.ca[b.pNum] = false;
                        hav = b.pNum;
                        tagx = x;
                        tagy = y;
                        data[2] = hav;
                    }
                }
            }
        }
    }
    void drawing0() {
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
        if (type == "delete") {
            image(del, x, y);
        }
    }
    void tag() {
        textAlign(CENTER);
        if (hav == 0)outlineText("１Ｐ", tagx+15, tagy-27, 22, color(255), color(0));
        if (hav == 1)outlineText("２Ｐ", tagx+15, tagy-27, 22, color(255, 85, 89), color(0));
        if (hav == 2)outlineText("３Ｐ", tagx+15, tagy-27, 22, color(0, 162, 232), color(0));
        if (hav == 3)outlineText("４Ｐ", tagx+15, tagy-27, 22, color(255, 242, 0), color(0));
    }
    void update1() {
        if (hav != -1) {
            data[0] = int(int(game.cx[hav])/30)*30;
            data[1] = int(int(game.cy[hav])/30)*30;
            x = int(int(game.cx[hav])/30)*30;
            y = int(int(game.cy[hav])/30)*30;
            if (keyboardd[player[hav].ck]) {
                if (type == "block" && data[4] == 4) {
                    if (data[3] == 30) {
                        data[3] = 120;
                        data[2] = 30;
                    } else {
                        data[3] = 30;
                        data[2] = 120;
                    }
                }
                if (type == "lblock") {
                    data[2] += 1;
                    if (data[2] > 3)data[2] = 0;
                }
                if (type == "spring") {
                    data[2] += 1;
                    if (data[2] > 1)data[2] = 0;
                }
                if (type == "roll") {
                    data[2] += 1;
                    if (data[2] > 1)data[2] = 0;
                }
                if (type == "cannon") {
                    data[2] += 1;
                    if (data[2] > 1)data[2] = 0;
                }
                if (type == "needle") {
                    data[2] += 1;
                    if (data[2] > 3)data[2] = 0;
                }
            }
            if (keyboardd[player[hav].jk]) {
                timer[2] = 0;
                if (type == "block") {
                    for (int i = 0; i < data[2]/30; i++)for (int j = 0; j < data[3]/30; j++)if (game.setb[int(x/30)+i][int(y/30)+j] == false)timer[2]+=1;
                }
                if (type == "lblock") {
                    if (data[2] == 0) {
                        for (int i = -3; i <= 0; i++)if (game.setb[int(x/30)+i][int(y/30)] == false)timer[2] += 1;
                        for (int i = -3; i <= -1; i++)if (game.setb[int(x/30)][int(y/30)+i] == false)timer[2] += 1;
                    }
                    if (data[2] == 1) {
                        for (int i = 0; i <= 3; i++)if (game.setb[int(x/30)+i][int(y/30)] == false)timer[2] += 1;
                        for (int i = -3; i <= -1; i++)if (game.setb[int(x/30)][int(y/30)+i] == false)timer[2] += 1;
                    }
                    if (data[2] == 2) {
                        for (int i = 0; i <= 3; i++)if (game.setb[int(x/30)+i][int(y/30)] == false)timer[2] += 1;
                        for (int i = 1; i <= 3; i++)if (game.setb[int(x/30)][int(y/30)+i] == false)timer[2] += 1;
                    }
                    if (data[2] == 3) {
                        for (int i = -3; i <= 0; i++)if (game.setb[int(x/30)+i][int(y/30)] == false)timer[2] += 1;
                        for (int i = 1; i <= 3; i++)if (game.setb[int(x/30)][int(y/30)+i] == false)timer[2] += 1;
                    }
                }
                if (type == "fall" || type == "spring" || type == "komei" || type == "roll"
                    || type == "cannon" || type == "needle" || type == "bneedle" || type == "mob1") {
                    if (game.setb[int(x/30)][int(y/30)] == false)timer[2] += 1;
                }
                if (type == "ladder") {
                    for (int i = 0; i<4; i++)if (game.setb[int(x/30)][int(y/30)+i] == false)timer[2] += 1;
                }
                if (type == "cloud") {
                    for (int i = 0; i<3; i++)for (int j = 0; j<2; j++)if (game.setb[int(x/30)+i][int(y/30)+j] == false)timer[2] += 1;
                }
                if (type == "tree") {
                    for (int i = 0; i<2; i++)if (game.setb[int(x/30)][int(y/30)+i] == false)timer[2] += 1;
                }
                if (type == "dossun") {
                    for (int i = 0; i<2; i++)for (int j = 0; j<3; j++)if (game.setb[int(x/30)+i][int(y/30)+j] == false)timer[2] += 1;
                }
                if (type == "delete") {
                    if (game.setb[int(x/30)][int(y/30)] == true) {
                        timer[2] += 1;
                    } else {
                        timer[2] += 1;
                        for (int i = info.size()-1; i >= 0; i--) {
                            Info b = info.get(i);
                            b.cUpdate(int(x/30), int(y/30));
                            if (b.br == true) {
                                timer[2] -= 1;
                                b.ffUpdate();
                                info.remove(i);
                            }
                        }
                    }
                }
                if (timer[2] < 1) {
                    game.ca[hav] = false;
                    hav = -1;
                    if (type != "delete") {
                        info.add(new Info(type, data[0], data[1], data[2], data[3], data[4], data[5]));
                        for (Info b : info)b.fUpdate();
                    }
                }
            }
        }
    }
    void drawing1() {
        if (hav != -1) {
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
            if (type == "delete") {
                image(del, x, y);
            }
        }
    }
}
