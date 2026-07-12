// settings.outformat = "png";
settings.render = 0; 
settings.prc = false;
import three;

// Подключаем стандартный пакет для математики
texpreamble("\usepackage{amsmath}");

// Общий размер холста 800x400
size(800, 400);

picture pic_ordinary, pic_js;
// Строго задаем размер каждой 3D сцены (400x400)
size(pic_ordinary, 400, 400);
size(pic_js, 400, 400);

projection proj = perspective(12, 6, 5);

// Настройки параметров
triple true_theta = (2.5, 2.5, 2.5); 
real shrink_c = 16.0;
real max_axis = 6.0;

triple[] pts_ord;
triple[] pts_js;

int n_r = 6;
int n_theta = 10;
int n_phi = 16;

// Генерация массивов точек (для быстрой компиляции)
for (int i = 1; i <= n_r; ++i) {
    real r = i * 0.45;
    for (int j = 1; j < n_theta; ++j) {
        real th = j * pi / n_theta;
        for (int k = 0; k < n_phi; ++k) {
            real ph = k * 2 * pi / n_phi;
            triple p = true_theta + (r*sin(th)*cos(ph), r*sin(th)*sin(ph), r*cos(th));
            
            pts_ord.push(p); 
            
            real norm_sq = p.x^2 + p.y^2 + p.z^2;
            real factor = max(0.0, 1.0 - shrink_c / norm_sq);
            pts_js.push(factor * p); 
        }
    }
}

// Настройка сцен
void setup_scene(picture pic) {
    // Черные оси на белом фоне
    draw(pic, O--max_axis*X, black + linewidth(1), Arrow3);
    draw(pic, O--max_axis*Y, black + linewidth(1), Arrow3);
    draw(pic, O--max_axis*Z, black + linewidth(1), Arrow3);
    
    // НЕВИДИМАЯ РАМКА: рисуем прозрачную линию, которая охватывает все возможные точки.
    // Это заставляет компилятор думать, что обе 3D-модели абсолютно одинакового размера.
    // Из-за этого масштабирование и центрирование обоих кадров будут 100% идентичны!
    draw(pic, (-2, -2, -2) -- (7.5, 7.5, 7.5), nullpen);
}

// === ЛЕВЫЙ ГРАФИК ===
setup_scene(pic_ordinary);
dot(pic_ordinary, pts_ord, blue + linewidth(2.5)); // Синие точки
dot(pic_ordinary, true_theta, red + linewidth(8));

// === ПРАВЫЙ ГРАФИК ===
setup_scene(pic_js);
dot(pic_js, pts_js, blue + linewidth(2.5)); // Синие точки
dot(pic_js, true_theta, red + linewidth(8));

// ==========================================
// СБОРКА ИТОГОВОГО 2D ИЗОБРАЖЕНИЯ
// ==========================================

// Заливаем фон белым цветом
fill(box((0,0), (800,400)), white);

// Накладываем кадры. 
// pic_ordinary ставим в начало координат (0,0), он займет левую половину (0..400)
// pic_js сдвигаем на 400 вправо (400,0), он займет правую половину (400..800)
add(shift(0, 0) * pic_ordinary.fit(proj));
add(shift(400, 0) * pic_js.fit(proj));

// Надписи (поставили ровно по центру над каждой половиной, 200 и 600 пикселей:)
label(scale(3) * "$\widehat{\boldsymbol{\theta}}$", (100, 360), red);
label(scale(3) * "$\widetilde{\boldsymbol{\theta}}$", (600, 360), heavygreen);

