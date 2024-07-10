PFont font1;
PFont font2;
int gamen = 0;
float[] timers = new float[100];

void settings() {
    size(1920, 1080);
    String[] lines = loadStrings("FullScreen.txt");
    if (lines[0].equals("true")) {
        fullScreen();
    }
}

void setup() {
    noCursor();
    frameRate(60);
    font1 = createFont("HGSSoeiKakupoptai", 256);
    font2 = createFont("Arial", 256);
    imageSet();
    //debugClass();
}

void draw() {
    keyboardCheckOnDraw();
    textFont(font1);

    if (gamen == 0) {
        background(190, 255, 255);
        image(title1, 400, 100);
        image(title2, 700, 320);
        for (int i = 0; i < 1920; i+=30) for (int j = 960; j < 1080; j+=30) image(bk[3], i, j);
        for (int i = 0; i < 1920; i+=30) image(bk[2], i, 930);
        textAlign(CENTER);
        outlineText("１Ｐが１、２キーを押してスタート", width/2, 630, 50, color(255), color(0));
        textAlign(CORNER);
        if (keyboardd[83])gamen = 1;
    } else if (gamen == 1) {
        background(190, 255, 255);
        image(title1, 400, 100);
        image(title2, 700, 320);
        for (int i = 0; i < 1920; i+=30)for (int j = 960; j < 1080; j+=30)image(bk[3], i, j);
        for (int i = 0; i < 1920; i+=30)image(bk[2], i, 930);
        outlineText("２人で遊ぶ", width/2, 510, 50, color(255), color(0));
        outlineText("３人で遊ぶ", width/2, 630, 50, color(255), color(0));
        outlineText("４人で遊ぶ", width/2, 750, 50, color(255), color(0));
        outlineText("上下キーで移動", 1400, 810, 40, color(255), color(0));
        if (keyboardd[70]) {
            timers[0] += 1;
            if (timers[0] > 2)timers[0] = 0;
        }
        if (keyboardd[82]) {
            timers[0] -= 1;
            if (timers[0] < 0)timers[0] = 2;
        }
        if (keyboardd[83]) {
            //info = new ArrayList();
            //game = new Game(int(timers[0])+2, 1);
            //for (Info b : info)b.fUpdate();
            //classSet();
            //timers[0] = 0;
            timers[1] = 0;
            gamen = 2;
        }
        image(arr2, width/2-90, timers[0]*120+518);
    } else if (gamen == 2) {
        background(190, 255, 255);
        image(title1, 400, 100);
        image(title2, 700, 320);
        for (int i = 0; i < 1920; i+=30)for (int j = 960; j < 1080; j+=30)image(bk[3], i, j);
        for (int i = 0; i < 1920; i+=30)image(bk[2], i, 930);
        textAlign(CENTER);
        outlineText("操作説明を見ますか？", width/2, 510, 50, color(255), color(0));
        outlineText("はい", width/2, 630, 50, color(255), color(0));
        outlineText("いいえ", width/2, 750, 50, color(255), color(0));
        textAlign(CORNER);
        if (keyboardd[70]) {
            timers[1] += 1;
            if (timers[1] > 1)timers[1] = 0;
        }
        if (keyboardd[82]) {
            timers[1] -= 1;
            if (timers[1] < 0)timers[1] = 1;
        }
        image(arr2, width/2-180, timers[1]*120+640);
        if (keyboardd[83]) {
            if (timers[1] == 0) {
                gamen = 3;
            }
            if (timers[1] == 1) {
                info = new ArrayList();
                game = new Game(int(timers[0])+2, 1);
                for (Info b : info)b.fUpdate();
                classSet();
                timers[0] = 0;
                timers[1] = 0;
                gamen = 5;
            }
        }
    } else if (gamen == 3) {
        timers[2] += 1;
        image(rule1, 0, 0);
        if (timers[2] >= 600) {
            outlineText("１，２キーで次のページ", 1400, 1000, 30, color(255), color(0));
            if (keyboardd[83]) {
                timers[2] = 0;
                gamen = 4;
            }
        }
    } else if (gamen == 4) {
        timers[2] += 1;
        image(rule2, 0, 0);
        if (timers[2] >= 600) {
            outlineText("１，２キーでゲームスタート", 1400, 1000, 30, color(255), color(0));
            if (keyboardd[83]) {
                timers[2] = 0;
                gamen = 5;
                info = new ArrayList();
                game = new Game(int(timers[0])+2, 1);
                for (Info b : info)b.fUpdate();
                classSet();
                timers[0] = 0;
            }
        }
    } else if (gamen == 5) {
        game.update();
    }
}
