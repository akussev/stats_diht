settings.render=8;
size(12cm);
import graph;

defaultpen(linewidth(1.2) + fontsize(16pt));

real theta = 4.5;
real tau_theta = 3.0;
pair P = (theta, tau_theta);

real sigma_x = 0.45;
real gauss_x(real x) { return 1.3 * exp(-(x - theta)^2 / (2 * sigma_x^2)); }
path p_curve_x = graph(gauss_x, theta - 1.4, theta + 1.4);
path px = (theta - 1.4, 0) -- p_curve_x -- (theta + 1.4, 0) -- cycle;
fill(px, gray(0.75));

real sigma_y = 0.675;
real gauss_y(real y) { return 1.3 * exp(-(y - tau_theta)^2 / (2 * sigma_y^2)); }
real g_y_param_x(real t) { return gauss_y(t); }
real g_y_param_y(real t) { return t; }
path p_curve_y = graph(g_y_param_x, g_y_param_y, tau_theta - 2.1, tau_theta + 2.1);
path py = (0, tau_theta - 2.1) -- p_curve_y -- (0, tau_theta + 2.1) -- cycle;
fill(py, gray(0.75));

draw((-0.5, 0) -- (8.5, 0), linewidth(1.5), Arrow(size=7));
draw((0, -0.6) -- (0, 6.5), linewidth(1.5), Arrow(size=7)); 

label("$x$", (8.3, -0.2), S, fontsize(18pt));
label("$y$", (-0.2, 6.3), W, fontsize(18pt));
label("$0$", (-0.2, -0.2), SW, fontsize(18pt));

draw(p_curve_x, black + linewidth(1.5));
draw(p_curve_y, black + linewidth(1.5));

real f(real x) { return 0.5 + 5.0 / (1.0 + exp(-1.2 * (x - 4.5))); }
path curve = graph(f, -0.5, 8.0, operator ..);
draw(curve, linewidth(1.8));

real tangent_f(real x) { return 3.0 + 1.5 * (x - 4.5); }
path tangent_line = graph(tangent_f, 2.2, 5.8); 
draw(tangent_line, linewidth(1.5));

draw((theta, 0) -- P -- (0, tau_theta), dashed + linewidth(1.5));

draw((theta, 0.15) -- (theta, -0.15), linewidth(1.5));
draw((0.15, tau_theta) -- (-0.15, tau_theta), linewidth(1.5));

label("$\theta$", (theta, -0.3), S, fontsize(18pt));
label("$\tau(\theta)$", (-0.3, tau_theta), W, fontsize(18pt));

label("$y = \tau(x)$", (7.5, 5.9), fontsize(18pt));

pen flowPen = gray(0.55) + linewidth(0.9);
real arrowSize = 4.5;
real padStart = 0.15;
real padEnd = 0.28; 

real[] multipliers = {-1.2, -0.6, 0.6, 1.2}; 

for(real m : multipliers) {
    real x_val = theta + m * sigma_x;            
    real y_tangent = tangent_f(x_val);           
    real x_target = gauss_y(y_tangent);          
    
    draw((x_val, gauss_x(x_val) + padStart) -- (x_val, y_tangent - padEnd), 
         flowPen, Arrow(size=arrowSize));
         
    draw((x_val - padEnd, y_tangent) -- (x_target + padEnd, y_tangent), 
         flowPen, Arrow(size=arrowSize));
}
