Game game;

class Game {
    int mode, play, stage, count, blockN, trapN;
    float[] timer = new float[100];
    float box, boy;
    float[] cx = new float[4];
    float[] cy = new float[4];
    boolean[] ca = new boolean[4];
    boolean[][] setb = new boolean[1920/30+3][1080/30+3];
    boolean[][] rsetb = new boolean[1920/30+3][1080/30+3];
    float clx, cly;
    int clr, tem;
    boolean debug = false;
    int[] scr = new int[4];
    int[] gl = new int[4];
    int[] tr = new int[4];
    int[] clp;
    Game(int play, int stage) {
        this.play = play;
        this.stage = stage;
        mode = 0;
        box = 600;
        boy = 500;
        count = 1;
        clr = 0;
        timer[0] = -90;
        timer[1] = height/2+boy;
        timer[2] = box;
        select = new ArrayList();
        for (int i = 0; i < setb.length; i++)for (int j = 0; j < setb[i].length; j++)setb[i][j] = true;
        for (int i = 0; i < rsetb.length; i++)for (int j = 0; j < rsetb[i].length; j++)rsetb[i][j] = true;

        info.add(new Info("block", -30, -height, 30, height*2, -1, 0));
        info.add(new Info("block", width, -height, 30, height*2, -1, 0));
        if (stage == 0) {
            info.add(new Info("block", 30*0, 30*25, 30*25, 30*6, 2, 0));
            info.add(new Info("block", 30*35, 30*25, 30*10, 30*6, 2, 0));
            info.add(new Info("block", 30*45, 30*20, 30*10, 30*11, 2, 0));
            info.add(new Info("block", 30*50, 30*15, 30*14, 30*16, 2, 0));
        }
        if (stage == 1) {
            info.add(new Info("block", 30*5, 30*20, 30*15, 30*16, 2, 0));
            info.add(new Info("block", 30*25, 30*20, 30*15, 30*16, 2, 0));
            info.add(new Info("block", 30*50, 30*15, 30*14, 30*21, 2, 0));
            clx = 30*60;
            cly = 30*13;
            for (int i = 5; i < 12; i++)for (int j = 0; j < 20; j++) {
                rsetb[i][j] = false;
                setb[i][j] = false;
            }
            for (int i = 58; i < 63; i++)for (int j = 11; j < 15; j++) {
                rsetb[i][j] = false;
                setb[i][j] = false;
            }
        }
    }
    void update() {
        if (mode == 0) {
            //timer[0] = -90;
            //timer[1] = height/2+boy;
            //timer[2] = box;
            //select = new ArrayList();
            //timer[4] = 0;
            //timer[6] = 0;
            timer[0] += 1;
            stageDraw();
            for (Info b : info)b.drawing();
            image(hata, clx, cly);
            noStroke();
            fill(255, 255, 255, 100);
            rect(0, 0, width, height);
            stroke(0);
            if (timer[0] <= 0) {
                textFont(font2);
                textAlign(CENTER);
                if (count < 10)outlineText("Round " + count, width/2, height/2-75, 150, color(255), color(0));
                if (count == 10)outlineText("Final Round", width/2, height/2-75, 150, color(255, 0, 0), color(0));
                textFont(font1);
                textAlign(CORNER);
            }
            if (timer[0] > 0 && timer[0] <= 60) {
                pushMatrix();
                rectMode(CENTER);
                timer[1] /= 1.15;
                strokeWeight(3);
                fill(155, 67, 2);
                translate(width/2, height/2+timer[1]);
                rotate(PI/800*timer[1]);
                rect(0, 0, box, boy);
                fill(207, 89, 2);
                rect(-box/4, 0, box/2, boy);
                rect(box/4, 0, box/2, boy);
                fill(255, 201, 14);
                ellipse(-50, 0, 40, 40);
                ellipse(50, 0, 40, 40);
                rectMode(CORNER);
                strokeWeight(1);
                popMatrix();
            }
            if (timer[0] == 61) { //アイテムの確率
                for (int i = 0; i < play; i++) {
                    cx[i] = width/2-box/2+i*60;
                    cy[i] = height/2-boy/2;
                    ca[i] = true;
                }
                if (count == 1) {
                    trapN = 0;
                    blockN = play+2-trapN;
                }
                if (count == 2) {
                    if (play == 2)trapN = int(random(1, 3));
                    if (play == 3)trapN = int(random(1, 3));
                    if (play == 4)trapN = int(random(2, 4));
                    blockN = play+2-trapN;
                }
                if (count >= 3) {
                    if (clr == play) {
                        if (play == 2)trapN = int(random(2, 5));
                        if (play == 3)trapN = int(random(3, 5));
                        if (play == 4)trapN = int(random(3, 6));
                        blockN = play+2-trapN;
                    }
                    if (clr < play && clr > 0) {
                        if (play == 2)trapN = int(random(1, 4));
                        if (play == 3)trapN = int(random(2, 4));
                        if (play == 4)trapN = int(random(2, 5));
                        blockN = play+2-trapN;
                    }
                    if (tem == 1) {
                        if (play == 2)trapN = int(random(1, 2));
                        if (play == 3)trapN = int(random(1, 3));
                        if (play == 4)trapN = int(random(2, 4));
                        blockN = play+2-trapN-1;
                    }
                    if (tem >= 2) {
                        if (play == 2)trapN = int(random(0, 2));
                        if (play == 3)trapN = int(random(0, 3));
                        if (play == 4)trapN = int(random(0, 3));
                        blockN = play+2-trapN-int(random(1, 3));
                    }
                }
                for (int i = 0; i<blockN; i++) {
                    timer[3] = random(1);
                    if (timer[3] < 1./7)select.add(new Select("block", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 30, 30, 0, 0));
                    else if (timer[3] < 2./7)select.add(new Select("block", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 30, 30, 1, 0));
                    else if (timer[3] < 3./7)select.add(new Select("block", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-120), height/2-boy/2+random(1)*(boy-30), 120, 30, 4, 0));
                    else if (timer[3] < 4./7)select.add(new Select("lblock", width/2-box/2+90+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-120), height/2-boy/2+90+random(1)*(boy-120), 0, 0, 0, 0));
                    else if (timer[3] < 5./7)select.add(new Select("fall", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 6./7)select.add(new Select("spring", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else select.add(new Select("ladder", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-120), 0, 0, 0, 0));
                }
                for (int i = blockN; i<blockN+trapN; i++) {
                    timer[3] = random(1);
                    if (timer[3] < 1./9)select.add(new Select("komei", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 2./9)select.add(new Select("roll", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 3./9)select.add(new Select("cannon", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 4./9)select.add(new Select("needle", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 5./9)select.add(new Select("bneedle", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 6./9)select.add(new Select("mob1", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 0, 0, 0, 0));
                    else if (timer[3] < 7./9)select.add(new Select("cloud", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-90), height/2-boy/2+random(1)*(boy-60), 0, 0, 0, 0));
                    else if (timer[3] < 8./9)select.add(new Select("tree", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-60), 0, 0, 0, 0));
                    else select.add(new Select("dossun", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-60), height/2-boy/2+random(1)*(boy-90), 0, 0, 0, 0));
                }
                for (int i = blockN+trapN; i<play+2; i++)select.add(new Select("delete", width/2-box/2+random(1./(play+2)*i, 1./(play+2)*(i+1))*(box-30), height/2-boy/2+random(1)*(boy-30), 1, 0, 0, 0));
            }
            if (timer[0] > 60 && timer[4] == 0) {
                timer[2] = timer[2]/1.1;
                for (int i = 0; i < play; i++) {
                    if (keyboard[player[i].rk]) {
                        cx[i]+=4;
                    }
                    if (keyboard[player[i].lk])cx[i]-=4;
                    if (keyboard[player[i].dk])cy[i]+=4;
                    if (keyboard[player[i].uk])cy[i]-=4;
                    if (cx[i] < width/2-box/2)cx[i] = width/2-box/2;
                    if (cx[i] > width/2+box/2)cx[i] = width/2+box/2;
                    if (cy[i] < height/2-boy/2)cy[i] = height/2-boy/2;
                    if (cy[i] > height/2+boy/2)cy[i] = height/2+boy/2;
                }
                for (Select b : select)b.update0();

                //image(sel, width/2-box/2, height/2-boy/2, box, boy);
                //rect(width/2, height/2, box, boy);
                fill(123, 53, 2);
                strokeWeight(3);
                rect(width/2-box/3, height/2-boy/3, box/3*2, boy/3*2);
                fill(155, 67, 2);
                quad(width/2-box/2, height/2-boy/2, width/2-box/3, height/2-boy/3, width/2+box/3, height/2-boy/3, width/2+box/2, height/2-boy/2);
                quad(width/2+box/2, height/2-boy/2, width/2+box/3, height/2-boy/3, width/2+box/3, height/2+boy/3, width/2+box/2, height/2+boy/2);
                quad(width/2+box/2, height/2+boy/2, width/2+box/3, height/2+boy/3, width/2-box/3, height/2+boy/3, width/2-box/2, height/2+boy/2);
                quad(width/2-box/2, height/2+boy/2, width/2-box/3, height/2+boy/3, width/2-box/3, height/2-boy/3, width/2-box/2, height/2-boy/2);
                strokeWeight(1);

                for (int i = select.size()-1; i>= 0; i--) {
                    Select b = select.get(i);
                    b.drawing0();
                }
                for (int i = 0; i < play; i++) if (ca[i] == true) {
                    image(cur, cx[i], cy[i]);
                    scale(-1, 1);
                    image(pg[i][2], -cx[i]-player[i].pw-24, cy[i]+12, player[i].pw, player[i].ph);
                    scale(-1, 1);
                }
                for (Select b : select)b.tag();
                strokeWeight(3);
                pushMatrix();
                translate(width/2-box/2, height/2);
                fill(207, 89, 2);
                rect(0, -boy/2, -box/2+timer[2], boy);
                fill(255, 201, 14);
                if (timer[2]>box/2)ellipse((box/2-50)*(timer[2]-box/2)/box*2, 0, 40*(timer[2]-box/2)/box*2, 40);
                popMatrix();
                pushMatrix();
                translate(width/2, height/2);
                rotate(PI);
                translate(-box/2, 0);
                fill(207, 89, 2);
                rect(0, -boy/2, -box/2+timer[2], boy);
                fill(255, 201, 14);
                if (timer[2]>box/2)ellipse((box/2-50)*(timer[2]-box/2)/box*2, 0, 40*(timer[2]-box/2)/box*2, 40);
                //fill(207, 89, 2);
                //rect(-box/2, -boy/2, box/2, boy);
                //fill(255, 201, 14);
                //ellipse(-box/2+50, 0, 40, 40);
                popMatrix();
                strokeWeight(1);
                if (timer[0] > 360+300 && timer[0] <= 660+300) {
                    textAlign(CENTER);
                    textFont(font2);
                    fill(255, 255, 255, 255-((timer[0]-1)%60)/60*255);
                    textSize(200);
                    text(str(int((660+300-timer[0])/60)+1), width/2, height/2+30);
                    textFont(font1);
                    textAlign(CORNER);
                }
                timer[5] = 0;
                for (int i = 0; i<play; i++)if (ca[i] == true)timer[5] += 1;
                if (debug == false)if (timer[5] < 1 || timer[0] == 660+300) {
                    timer[4]=1;
                    timer[2]=box;
                }
                if (debug == true)if (timer[5] < 1 || timer[0] == 70) {
                    timer[4]=1;
                    timer[2]=box;
                }
            } else if (timer[4] >= 1 && timer[4] < 60) {
                timer[2] = timer[2]/1.2;
                for (Select b : select)b.update0();
                fill(123, 53, 2);
                strokeWeight(3);
                rect(width/2-box/3, height/2-boy/3, box/3*2, boy/3*2);
                fill(155, 67, 2);
                quad(width/2-box/2, height/2-boy/2, width/2-box/3, height/2-boy/3, width/2+box/3, height/2-boy/3, width/2+box/2, height/2-boy/2);
                quad(width/2+box/2, height/2-boy/2, width/2+box/3, height/2-boy/3, width/2+box/3, height/2+boy/3, width/2+box/2, height/2+boy/2);
                quad(width/2+box/2, height/2+boy/2, width/2+box/3, height/2+boy/3, width/2-box/3, height/2+boy/3, width/2-box/2, height/2+boy/2);
                quad(width/2-box/2, height/2+boy/2, width/2-box/3, height/2+boy/3, width/2-box/3, height/2-boy/3, width/2-box/2, height/2-boy/2);
                strokeWeight(1);

                for (int i = select.size()-1; i>= 0; i--) {
                    Select b = select.get(i);
                    b.drawing0();
                }
                for (Select b : select)b.tag();
                strokeWeight(3);
                pushMatrix();
                translate(width/2-box/2, height/2);
                fill(207, 89, 2);
                rect(0, -boy/2, box/2-timer[2], boy);
                fill(255, 201, 14);
                if (timer[2]<box/2)ellipse(-(box/2-50)*(timer[2]-box/2)/box*2, 0, 40*(timer[2]-box/2)/box*2, 40);
                popMatrix();
                pushMatrix();
                translate(width/2, height/2);
                rotate(PI);
                translate(-box/2, 0);
                fill(207, 89, 2);
                rect(0, -boy/2, box/2-timer[2], boy);
                fill(255, 201, 14);
                if (timer[2]<box/2)ellipse(-(box/2-50)*(timer[2]-box/2)/box*2, 0, 40*(timer[2]-box/2)/box*2, 40);
                popMatrix();
                strokeWeight(1);
                timer[4] += 1;
            } else if (timer[4] >= 60) {
                pushMatrix();
                stroke(0, 0, 0, 255-timer[6]);
                rectMode(CENTER);
                timer[6] += 5;
                strokeWeight(3);
                fill(155, 67, 2, 255-timer[6]);
                translate(width/2, height/2);
                rotate(PI/200*timer[6]);
                rect(0, 0, box, boy);
                fill(207, 89, 22, 255-timer[6]);
                rect(-box/4, 0, box/2, boy);
                rect(box/4, 0, box/2, boy);
                fill(255, 201, 14, 255-timer[6]);
                ellipse(-50, 0, 40, 40);
                ellipse(50, 0, 40, 40);
                rectMode(CORNER);
                strokeWeight(1);
                stroke(0);
                popMatrix();
                if (timer[6] > 400) {
                    mode = 1;
                    for (int i = 0; i < play; i++) {
                        cx[i] = width/2-play*30+60*i-15;
                        cy[i] = height/2-15;
                        if (ca[i] == false)ca[i] = true;
                        else ca[i] = false;
                        timer[8] = 0;
                    }
                }
            }
        } else if (mode == 1) {
            timer[8] += 1;
            for (int i = 0; i < play; i++) {
                if (keyboard[player[i].rk]) {
                    cx[i]+=4;
                }
                if (keyboard[player[i].lk])cx[i]-=4;
                if (keyboard[player[i].dk])cy[i]+=4;
                if (keyboard[player[i].uk])cy[i]-=4;
                if (cx[i] < 0)cx[i] = 0;
                if (cx[i] > width-1)cx[i] = width-1;
                if (cy[i] < 0)cy[i] = 0;
                if (cy[i] > height-1)cy[i] = height-1;
            }
            for (Select b : select)b.update1();
            stageDraw();
            image(hata, clx, cly);
            for (Info b : info)b.drawing();
            noStroke();
            fill(255, 255, 255, 100);
            rect(0, 0, width, height);
            for (int i = 30; i < width; i+=30) {
                stroke(0, 0, 0, 50);
                if (i%150 == 0)stroke(0);
                line(i, 0, i, height);
            }
            for (int i = 30; i < height; i+=30) {
                stroke(0, 0, 0, 50);
                if (i%150 == 0)stroke(0);
                line(0, i, width, i);
            }
            stroke(0);
            for (int i = 0; i < width/30; i++)for (int j = 0; j < height/30; j++)if (rsetb[i][j] == false) {
                noStroke();
                fill(255, 0, 0, 30);
                rect(i*30, j*30, 30, 30);
                stroke(255, 0, 0, 50);
                line(i*30, j*30, (i+1)*30, (j+1)*30);
                line((i+1)*30, j*30, i*30, (j+1)*30);
                stroke(0);
            }
            for (Select b : select)b.drawing1();
            for (int i = 0; i < play; i++) if (ca[i] == true) {
                image(cur, cx[i], cy[i]);
                scale(-1, 1);
                image(pg[i][2], -cx[i]-player[i].pw-24, cy[i]+12, player[i].pw, player[i].ph);
                scale(-1, 1);
            }
            if (timer[8] > 600 && timer[8] <= 900) {
                textAlign(CENTER);
                textFont(font2);
                fill(0, 0, 0, 255-((timer[8]-1)%60)/60*255);
                textSize(200);
                text(str(int((900-timer[8])/60)+1), width/2, height/2+30);
                textFont(font1);
                textAlign(CORNER);
            }
            timer[5] = 0;
            for (int i = 0; i<play; i++)if (ca[i] == true)timer[5] += 1;
            if (debug == false)if (timer[5] < 1 || timer[8] == 900) {
                mode = 2;
                classSet();
                for (Info b : info)b.setting();
                select = new ArrayList();
                timer[7] = -90;
                timer[9] = 0;
                timer[11] = 0;
                timer[13] = 0;
                for (int i = 0; i < play; i++) {
                    gl[i] = 0;
                    tr[i] = 0;
                }
                clr = 0;
            }
            if (debug == true)if (timer[5] < 1 || timer[8] == 10) {
                mode = 2;
                classSet();
                for (Info b : info)b.setting();
                timer[7] = -90;
                timer[9] = 0;
                timer[11] = 0;
                timer[13] = 0;
                for (int i = 0; i < play; i++) {
                    gl[i] = 0;
                    tr[i] = 0;
                }
                clr = 0;
            }
        } else if (mode == 2) {
            timer[7] += 1;
            if (timer[7] > 0 && timer[9] == 0) {
                for (Player b : player)b.moving();
                for (Mob1 b : mob1)b.moving();
                for (Cloud b : cloud)b.moving();
                for (Roll b : roll)b.moving();

                for (Player b : player)b.jUpdate();
                for (Komei b : komei)b.update();
                for (Block b : block)b.update();
                for (Fall b : fall)b.update();
                for (Tree b : tree)b.update();
                for (Cannon b : cannon)b.update();
                for (Cannon b : cannon)b.shot();
                for (Bullet b : bullet)b.update();
                for (Needle b : needle)b.update();
                for (Mob1 b : mob1)b.update();
                for (Spring b : spring)b.update();
                for (Bneedle b : bneedle)b.update();
                for (Dossun b : dossun)b.moving();

                for (Player b : player)if (b.clear == false && b.death == false && collision(b.x, b.y, b.pw, b.ph, clx, cly, 30, 60)) {
                    b.clear = true;
                    timer[13] += 1;
                    gl[b.pNum] = int(timer[13]);
                }
                for (Player b : player)b.dUpdate();
                for (Mob1 b : mob1)b.dUpdate();
                for (Cloud b : cloud)b.dUpdate();
                for (Roll b : roll)b.dUpdate();
                for (Tree b : tree)b.dUpdate();
                for (Bullet b : bullet)b.dUpdate();
                for (Needle b : needle)b.dUpdate();
                for (Dossun b : dossun)b.dUpdate();
                for (Bneedle b : bneedle)b.dUpdate();
                timer[10] = 0;
                clr = 0;
                for (Player b : player)if (b.clear == true || b.death == true) {
                    timer[10] += 1;
                    if (b.clear == true)clr += 1;
                }
                if (timer[10] == play) {
                    timer[11] += 1;
                }
                if (timer[11] >= 120) {
                    if (clr == 0)tem += 1;
                    else tem = 0;
                    mode = 3;
                    timer[12] = 0;
                    classSet();
                    timer[13] = 0;
                    timer[14] = 0;
                    for (int i = 0; i < play; i++) {
                        if (gl[i] == 0)timer[14] += 1;
                        if (gl[i] == 1)scr[i] += 100;
                        if (gl[i] == 2)scr[i] += 50;
                        if (gl[i] == 3)scr[i] += 30;
                        if (gl[i] == 4)scr[i] += 10;
                    }
                    if (clr != 0)for (int i = 0; i < play; i++)scr[i] += tr[i]*10;
                }
            }
            stageDraw();
            for (Bullet b : bullet)b.drawing();
            for (Mob1 b : mob1)b.drawing();
            for (Tree b : tree)b.drawing();
            for (Cloud b : cloud)b.drawing();
            for (Block b : block)b.drawing();
            for (Lblock b : lblock)b.drawing();
            for (Roll b : roll)b.drawing();
            for (Dossun b : dossun)b.drawing();
            for (Cannon b : cannon)b.drawing();
            for (Needle b : needle)b.drawing();
            for (Spring b : spring)b.drawing();
            for (Ladder b : ladder)b.drawing();
            for (Bneedle b : bneedle)b.drawing();
            for (Fall b : fall)b.drawing();
            for (Player b : player)b.drawing();
            image(hata, clx, cly);
            textAlign(CENTER);
            textFont(font2);
            if (timer[7] <= 0) {
                if ((timer[7]+70)/30*200 < 0)outlineText("READY?", width/2, height/2-100, 200+(timer[7]+70)/20*200, color(255, 0, 0), color(0));
                else outlineText("READY?", width/2, height/2-100, 200, color(255, 0, 0), color(0));
            }
            if (timer[7] > 0 && timer[7] <= 30)outlineText("GO!", width/2, height/2-100, 200, color(255, 0, 0), color(0));
            textFont(font1);
            textAlign(CORNER);
            //for (Player b : player)b.tagDraw();
        } else if (mode == 3) {
            timer[12] += 1;
            stageDraw();
            for (Info b : info)b.drawing();
            image(hata, clx, cly);
            noStroke();
            fill(255, 255, 255, 100);
            rect(0, 0, width, height);
            stroke(0);
            for (int i = 0; i < play; i++) {
                imageMode(CENTER);
                image(pg[i][0], width/2-(play-1)*150+300*i, height/5*2);
                imageMode(CORNER);
                textFont(font2);
                textAlign(CENTER);
                timer[14] = 0;
                for (int j = 0; j < play; j++)if (gl[j] == 0)timer[14] += 1;
                outlineText(scr[i] + " pt", width/2-(play-1)*150+300*i, height/5*3, 50, color(255), color(0));
                if (clr == 0)outlineText("+0", width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                else {
                    if (tr[i] > 0) {
                        if (gl[i] == 1)outlineText("+100+"+tr[i]*10, width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 2)outlineText("+50+"+tr[i]*10, width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 3)outlineText("+30+"+tr[i]*10, width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 4)outlineText("+10+"+tr[i]*10, width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 0)outlineText("+0+"+tr[i]*10, width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                    }
                    if (tr[i] == 0) {
                        if (gl[i] == 1)outlineText("+100", width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 2)outlineText("+50", width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 3)outlineText("+30", width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 4)outlineText("+10", width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                        if (gl[i] == 0)outlineText("+0", width/2-(play-1)*150+300*i+30, height/5*3-50, 40, color(255, 0, 0), color(0));
                    }
                }
                textFont(font1);
                textAlign(CORNER);
            }
            if (timer[12] > 300) {
                select = new ArrayList();
                timer[15] = 0;
                for (int i = 0; i < play; i++)if (scr[i] >= 500)timer[15] += 1;
                if (timer[15] > 0 || count == 10) {
                    mode = 4;
                    timer[16] = 0;
                    timer[22] = 0;
                    for (int i = 0; i < play; i++)if (scr[i] >= timer[16])timer[16] = scr[i];
                    for (int i = 0; i < play; i++)if (scr[i] == timer[16])timer[22] += 1;
                    clp = new int[int(timer[22])];
                    timer[22] = 0;
                    for (int i = 0; i < play; i++)if (scr[i] == timer[16]) {
                        clp[int(timer[22])] = i;
                        timer[22] += 1;
                    }
                } else {
                    count += 1;
                    mode = 0;
                    timer[0] = -90;
                    timer[1] = height/2+boy;
                    timer[2] = box;
                    timer[4] = 0;
                    timer[6] = 0;
                }
            }
        } else if (mode == 4) {
            timer[21] += 1;
            stageDraw();
            for (Info b : info)b.drawing();
            image(hata, clx, cly);
            noStroke();
            fill(255, 255, 255, 100);
            rect(0, 0, width, height);
            if (timer[21] <= 180) {
                stroke(0);
                textFont(font2);
                textAlign(CENTER);
                outlineText("FINISHED!", width/2, height/2-100, 200, color(255, 0, 0), color(0));
                textFont(font1);
                textAlign(CORNER);
            }
            if (timer[21] > 180) {
                textAlign(CENTER);
                outlineText("勝負を制したのは…", width/2, height/2-400, 100, color(255, 0, 0), color(0));
                textAlign(CORNER);
            }
            if (timer[21] > 300) {
                for (int i = 0; i < clp.length; i++) {
                    imageMode(CENTER);
                    image(pg[clp[i]][0], width/2-(clp.length-1)*150+300*i, height/2, pg[i][0].width*2, pg[i][0].height*2);
                    imageMode(CORNER);
                    textAlign(CENTER);
                    outlineText((clp[i]+1) + "Ｐ", width/2-(clp.length-1)*150+300*i, height/2+200, 100, color(255), color(0));
                    textAlign(CORNER);
                }
            }
            if (timer[21] > 360) {
                outlineText("１、２キーで戻る", 1430, 880, 40, color(255), color(0));
                if (keyboardd[83]) {
                    gamen = 0;
                }
            }
        }
    }
}
