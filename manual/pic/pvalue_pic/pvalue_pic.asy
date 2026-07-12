import graph;
import math;
import patterns; 

size(0,100);


add("alpha_hatch", hatch(1mm, NW, heavyred + 1.2bp));
add("pvalue_hatch", hatch(1mm, NE, heavygreen + 1.2bp));


real sigma2 = 0.1;
real l = -1.5;
real r = 1.5;
real alpha = 0.45;
real p_value = 0.2;

real rho(real x) {return exp(-x * x / 2 / sigma2) / sqrt(2 * pi * sigma2);}

path rho_graph = graph(rho, l, r, operator..);
path alpha_graph = graph(rho, alpha, r, operator..);
path pvalue_graph = graph(rho, p_value, r, operator..);

path fill_alpha = alpha_graph -- (r,0) -- (alpha,0) -- cycle;
path fill_pvalue = pvalue_graph -- (r,0) -- (p_value,0) -- cycle;


fill(fill_pvalue, pattern("pvalue_hatch"));
fill(fill_alpha, pattern("alpha_hatch"));


draw(fill_pvalue, heavygreen + 1.2bp);
draw(fill_alpha, heavyred + 1.2bp);


label("$\alpha$", (0.65, 0.2), NE, red);
label("$c_{\alpha}$", (alpha, 0), S, red);
label(scale(0.7)*"$T(\mathbf X)$", (p_value, 0), S, heavygreen);
label("$\textrm{p-value}(\mathbf X)$", (0.4, 0.5), NE, heavygreen);
draw(rho_graph, black + 0.8bp);

xaxis(EndArrow, xmin=l, xmax=r);


real sh = 3.3;

real rho_sh(real x) {return rho(x - sh);}

sigma2 = 0.1;
l = -1.5;
r = 1.5;
alpha = 0.45;
p_value = 0.7;

rho_graph = graph(rho_sh, l + sh, r + sh, operator..);
alpha_graph = graph(rho_sh, alpha + sh, r + sh, operator..);
pvalue_graph = graph(rho_sh, p_value + sh, r + sh, operator..);

fill_alpha = alpha_graph -- (r + sh,0) -- (alpha + sh,0) -- cycle;
fill_pvalue = pvalue_graph -- (r + sh,0) -- (p_value + sh,0) -- cycle;


fill(fill_alpha, pattern("alpha_hatch"));
fill(fill_pvalue, pattern("pvalue_hatch"));

draw(fill_alpha, heavyred + 1.2bp);
draw(fill_pvalue, heavygreen + 1.2bp);


label("$\alpha$", (0.65 + sh, 0.2), NE, red);
label("$c_{\alpha}$", (alpha + sh, 0), S, red);
label(scale(0.7)*"$T(\mathbf X)$", (p_value + sh, 0), S, heavygreen);
label("$\textrm{p-value}(\mathbf X)$", (0.85 + sh, 0.05), NE, heavygreen);
draw(rho_graph, black + 0.8bp);

xaxis(EndArrow, xmin=l+sh, xmax=r+sh);
