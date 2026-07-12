size(250, 250);

pair[] A1; A1[4]=(0,2); A1[1]=(1,3); A1[2]=(3,2); A1[3]=(3,-1.5);
pair[] A2; A2[4]=(0.5,2); A2[1]=(1,2.5); A2[2]=(2.5,1.5); A2[3]=(3,-0.5);
pair[] A3; A3[4]=(-1,1.5); A3[1]=(0.5,3.5); A3[2]=(3.5,2.5); A3[3]=(2.5,-2.5);

path[] c;

c[1] = A1[1]..{(1,0)}A1[2]..{(-1,0)}A1[3]..A1[4]..cycle;
c[2] = A2[1]..{(1,0)}A2[2]..{(-1,0)}A2[3]..A2[4]..cycle;
c[3] = A3[1]..{(1,0)}A3[2]..{(-1,0)}A3[3]..{0.5, 1}A3[4]..cycle;

pen first = heavyred+1bp;
pen second = heavygreen+1bp;
pen third = heavyblue+1bp;


pen level_pen = gray(0.85) + 0.6bp;


path blend(path p1, path p2, real t, int n=100) {
    guide g;
    for(int i=0; i<n; ++i) {
        real x = i * length(p1) / n;
        pair pt1 = point(p1, x);
        pair pt2 = point(p2, x);
        g = g -- ((1-t)*pt1 + t*pt2);
    }
    return g -- cycle;
}


pair center2 = (A2[1]+A2[2]+A2[3]+A2[4])/4.0;
draw(shift(center2)*scale(0.33)*shift(-center2)*c[2], level_pen);
draw(shift(center2)*scale(0.66)*shift(-center2)*c[2], level_pen);


draw(blend(c[2], c[1], 0.25), level_pen);
draw(blend(c[2], c[1], 0.50), level_pen);
draw(blend(c[2], c[1], 0.75), level_pen);


draw(blend(c[1], c[3], 0.25), level_pen);
draw(blend(c[1], c[3], 0.50), level_pen);
draw(blend(c[1], c[3], 0.75), level_pen);


pair center3 = (A3[1]+A3[2]+A3[3]+A3[4])/4.0;
draw(shift(center3)*scale(1.15)*shift(-center3)*c[3], level_pen);


draw(c[1], first);
draw(c[2], second);
draw(c[3], third);

label("$R_{\alpha_1}$", (4.5, -1.5), third);
label("$R_{\alpha_2}$", (4, -0.7), first);
label("$R_{\alpha_3}$", (3.2, 0), second);
label("$(X_1, \ldots, X_n)$", (1.8, -1.8), black);

dot((1.9, -1.3), filltype=FillDraw(1bp), black);
