class Wave {

  ArrayList<Complex> waves;
  float px, py;
  float w, k, st;
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
    calcWave();
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
    // HORIZONTAL Wave
    //translate(px, py);
    //rotate(radians(-90));
    //translate(-px, -py);

    float xt, yt;
    float xx, xy; 
    float wx, wy;
    
     if (time>=num) 
      time =0;
    // Draw wavefrom
    if (x>=num) 
      x=0;
      
    // Coordinates for only Temporal Phasor
    xt=waves.get(time).re;
    yt=waves.get(time).im;  
    
    // Coordinates for only Spatial Phasor
    xt=waves.get(x*num).re;
    yt=waves.get(x*num).im;  
    
    // Coordinates for Wave Phasor (Temporal x Spatial)
    wx=waves.get(time+x*num).re;
    wy=waves.get(time+x*num).im;


    beginShape();
    noFill();
    stroke(0, 50);
    for (int t=0; t<num; t++) {
      vertex(px+waves.get(t+x*num).re, py+st*t+1.5*amp);
    }
    endShape();
    stroke(0);

    

    stroke(0, 50);
    strokeWeight(1);
    ellipse(px, py, 2*amp, 2*amp);
    stroke(0);
    strokeWeight(2);
    line(px, py, px+xt, py+yt);

    ellipse(px+xt, py+1.2*amp, 3, 3);


    

    // Time phaosr follows wave
    //renderPhasor(px+wx,py+st*time+1.5*amp,xt, yt);

    // Time phaosr follows wave equilibirum
    renderPhasor(px, py+st*time+1.5*amp, xt, yt);

    time +=1;
    x +=1;
  }
  
  void renderWaveform(){
  
  }

  void renderPhasor(float centerX, float centerY, float dx, float dy) {
    stroke(0, 50);
    strokeWeight(1);
    ellipse(centerX, centerY, 2*amp, 2*amp);
    stroke(0);
    strokeWeight(2);
    line(centerX, centerY, centerX+dx, centerY+dy);
  }
}
