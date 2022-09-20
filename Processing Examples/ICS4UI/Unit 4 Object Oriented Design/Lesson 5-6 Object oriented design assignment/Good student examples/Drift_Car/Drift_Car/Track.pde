class Track {
    int length, width;
    float curvature;
    Track(int length, int width, float curvature) {
        this.length = length;
        this.width = width;
        this.curvature = curvature;
    }


    void drawTrack() {
        int trackEnd = 1000;
        int trackTop = 0;
        int k = this.width;
        int h = 1000-this.length;
        float t = h/tan(radians(this.curvature));
        noStroke();
        fill(0);
        bezier(0, trackTop, trackEnd-t, trackTop, trackEnd-t, trackTop, trackEnd, trackTop+h);
        beginShape();
        vertex(0, trackTop);
        vertex(0, trackTop+h);
        vertex(trackEnd, trackTop+h);
        endShape();

        rect(trackEnd - k, trackTop+h, trackEnd - k, 1000);

        fill(100, 200, 100);
        bezier(0, trackTop+k, trackEnd-t-k, trackTop+k, trackEnd-t-k, trackTop+k, trackEnd-k, trackTop+h);
        beginShape();
        vertex(0, trackTop+k);
        vertex(0, trackTop+h);
        vertex(trackEnd-k, trackTop+h);
        endShape();
    }
}
