PImage pg[][];
PImage bk[];
PImage bk2[];
PImage mb1[];
PImage cld[];
PImage dsn[];
PImage tre, guru, can, hari, spr, lad, del, bhar, cur, arr, hata, title1, title2, arr2, rule1, rule2;

void imageSet() {
    pg = new PImage[4][7];
    for (int i=0; i<pg.length; i++) for (int j=0; j<pg[i].length; j++) pg[i][j] = loadImage("players.png").get(j*48, i*70, 48, 70);
    bk = new PImage[7];
    for (int i=0; i<bk.length; i++) bk[i] = loadImage("blocks.png").get(i*30, 0, 30, 30);
    bk2 = new PImage[3];
    for (int i=0; i<bk2.length; i++) bk2[i] = loadImage("block2.png").get(i*30, 0, 30, 30);
    mb1 = new PImage[2];
    for (int i=0; i<mb1.length; i++) mb1[i] = loadImage("mob2.png").get(i*30, 0, 30, 30);
    cld = new PImage[2];
    for (int i=0; i<cld.length; i++) cld[i] = loadImage("kumo.png").get(i*90, 0, 90, 60);
    tre = loadImage("ki.png");
    guru = loadImage("gru.png");
    can = loadImage("cannon.png");
    hari = loadImage("hari.png");
    dsn = new PImage[2];
    for (int i=0; i<dsn.length; i++) dsn[i] = loadImage("mob4.png").get(i*60, 0, 60, 90);
    spr = loadImage("spring.png");
    lad = loadImage("ladder.png");
    del = loadImage("delete.png");
    bhar = loadImage("bhari.png");
    cur = loadImage("cursor.png");
    arr = loadImage("arrow.png");
    hata = loadImage("hata.png");
    title1 = loadImage("title1.png");
    title2 = loadImage("title2.png");
    arr2 = loadImage("arrow2.png");
    rule1 = loadImage("rule1.png");
    rule2 = loadImage("rule2.png");
}

void classSet() {
    player = new Player[game.play];
    block = new ArrayList();
    mob1 = new ArrayList();
    tree = new ArrayList();
    cloud = new ArrayList();
    roll = new ArrayList();
    komei = new ArrayList();
    cannon = new ArrayList();
    bullet = new ArrayList();
    needle = new ArrayList();
    dossun = new ArrayList();
    fall = new ArrayList();
    fNum = 0;
    spring = new ArrayList();
    ladder = new ArrayList();
    lblock = new ArrayList();
    bneedle = new ArrayList();
    for (int i=0; i<game.play; i++)player[i] = new Player(i);
}

void otherSet() {
    select = new ArrayList();
    info = new ArrayList();
}

void debugClass() {
    block.add(new Block(-30, -height, 30, height*2, -1, 0));
    block.add(new Block(width, -height, 30, height*2, -1, 0));
    block.add(new Block(0, 900, 1440, 180, 2, 0));
    block.add(new Block(1440, 360, 480, 720, 2, 0));
    //block.add(new Block(480, 630, 30, 30, 0,0));
    mob1.add(new Mob1(450, 0, 0));
    block.add(new Block(330, 690, 30, 120, 4, 0));
    tree.add(new Tree(720, 840, 0));
    cloud.add(new Cloud(600, 480, 0));
    roll.add(new Roll(300, 510, 0, 0));
    komei.add(new Komei(270, 690, 0));
    cannon.add(new Cannon(600, 870, 1, 0));
    needle.add(new Needle(510, 780, 2, 0));
    dossun.add(new Dossun(810, 480, 0));
    fall.add(new Fall(90, 540, 0));
    spring.add(new Spring(180, 720, 0, 0));
    ladder.add(new Ladder(390, 690, 0));
    lblock.add(new Lblock(1080, 750, 0, 0));
    bneedle.add(new Bneedle(480, 630, 0));
}
