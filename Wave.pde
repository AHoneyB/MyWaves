class Wave {

  ArrayList<Complex> waves;
  float px, py;
  float w,k, st;
  float amp;
  float phase;
  int num;
  int time, x;

  Wave(float px, float py, float a, float k, float w) {
    this.px = px;
    this.py = py;
    this.amp = a;
    phase= HALF_PI;
    this.w=w;
    this.k=k;
    st=4;
    num = 100;

    waves = new ArrayList<Complex>();
    time =0;
    x =0;
  }

  void calcWave() {
    waves.clear();
    Float re, im;
   
    for (int i=0; i<num; i++) {
      float xx = map(i, 0, num, 0, TWO_PI);
      for (int j=0; j<num; j++) {
        float tt = map(j, 0, num, 0, TWO_PI);
        re = amp *  (float)(Math.cos((k*xx-w*tt+phase)));
        im = amp *  (float)(Math.sin((k*xx-w*tt+phase)));
        Complex c = new Complex(re, im);
        waves.add(c);
      }
    }
  }

  void render() {
    //translate(px, py);
    //rotate(radians(-90));
    //translate(-px, -py);
    float xt, yt;
    float wx, wy;

    beginShape();
    noFill();

    stroke(0, 50);
    if (time>=num) 
      time =0;

    if (x>=num) 
      x=0;
    for (int t=0; t<num; t++) {

      vertex(px+waves.get(t+x*num).re, py+st*t+1.5*amp);
    }
    endShape();
    stroke(0);


    xt=waves.get(time).re;
    yt=waves.get(time).im;

    stroke(0, 50);
    strokeWeight(1);
    ellipse(px, py, 2*amp, 2*amp);
    stroke(0);
    strokeWeight(2);
    line(px, py, px+xt, py+yt);





    ellipse(px+xt, py+1.2*amp, 3, 3);



    wx=waves.get(time+x*num).re;
    wy=waves.get(time+x*num).im;

    ellipse(px+wx, py+st*time+1.5*amp, 3, 3);

  // Time phaosr follows wave
    stroke(0, 50);
    strokeWeight(1);
    ellipse(px+wx, py+st*time+1.5*amp, 2*amp, 2*amp);
    stroke(0);
    strokeWeight(2);
    line(px+wx, py+st*time+1.5*amp, px+xt+wx, py+yt+st*time+1.5*amp);

    // Time phaosr follows wave equilibirum
    //stroke(0, 50);
    //strokeWeight(1);
    //ellipse(px, py+st*time+1.5*amp, 2*amp, 2*amp);
    //stroke(0);
    //strokeWeight(2);
    //line(px, py+st*time+1.5*amp, px+xt, py+yt+st*time+1.5*amp);


  
    time +=1;
    x +=1;
  }
}
