// 輪郭付きのテキスト
void outlineText(String txt, float x, float y, float size, color txtColor, color outlineColor) {
    float outlineWidth = (float) (size / 20);
    textSize(size);
    fill(outlineColor);
    text(txt, x - outlineWidth, y + size - outlineWidth);
    text(txt, x + outlineWidth, y + size - outlineWidth);
    text(txt, x - outlineWidth, y + size + outlineWidth);
    text(txt, x + outlineWidth, y + size + outlineWidth);
    fill(txtColor);
    text(txt, x, y + size);
}

// 四角と四角の衝突判定
boolean collision(float x0, float y0, float width0, float height0, float x1, float y1, float width1, float height1) {
    return x0 + width0 > x1 && x1 + width1 > x0 && y0 + height0 > y1 && y1 + height1 > y0;
}
