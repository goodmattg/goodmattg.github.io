%% Define original signal
x = 0:pi/64:6*pi;
y = 0.25*sin(x);

%% Modify a section of the signal
N = length(y);
xind = (floor(0.40*N):floor(0.60*N));
ymod = y;
ymod(xind) = sinc(x(xind));

%% Compute DTW
zg = repmat(y, N, 1);
zgmod = repmat(ymod', 1, N);
d2 = sqrt((zg - zgmod) .^ 2);
[~,ix,iy] = dtw(y, ymod);

%% Plotting
[xg, yg] = meshgrid(1:N);
d2(sub2ind(size(d2), iy, ix)) = 1.5*max(d2(:));
mesh(xg, yg, d2)



