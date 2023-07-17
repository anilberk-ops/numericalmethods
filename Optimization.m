%Rosenbrock's function is a well known function among mathmaticians. Its min. point can be found with steepest ascend method with this matlab code.


clc;
clear;
tic


% Rosenbrock's banana function
rosenbrock = @(x,y) 100*(y - x.^2).^2 + (1 - x).^2;

% the gradient of the function
grad_rosenbrock = @(x,y) [-400*x.*(y - x.^2) - 2*(1 - x); 200*(y - x.^2)];

% Set initial guess and other parameters
x0 = [-1.9; 2];
h = 0.001; % fixed step size
tol = 1e-6; % tolerance for convergence, if the norm of the gradient is too small, stop iteration!
max_iter = 100000; % maximum number of iterations

% Perform steepest descent method
x = x0;
iter = 0;
m  = x;%m is a matrix which records all points where our code pass away.

while norm(grad_rosenbrock(x(1), x(2))) > tol && iter < max_iter
    p = -grad_rosenbrock(x(1), x(2));%minus; since it says descent method
    x = x + h.*p./norm(grad_rosenbrock(x(1), x(2)));%The reason behind of this small operation is that
%we need unit function to multiply with h to provide constant step size. I divide gradient with its norm then multiply with h.    
    iter = iter + 1;
    m = [m x];


end

% Display the results
if iter == max_iter
    disp("Maximum number of iterations reached before convergence.")
else
    disp("Converged to a minimum after " + iter + " iterations.")
end
disp("Minimum value found: " + rosenbrock(x(1), x(2)))
disp("Location of minimum: (" + x(1) + ", " + x(2) + ")")

[X,Y] = meshgrid(-2:0.01:4,-2:0.01:4);
Z = rosenbrock(X,Y);
figure
contour(X,Y,Z,logspace(-2,3,30))
hold on
plot(m(1,:),m(2,:),['r'])
xlabel('x')
ylabel('y')
title('Steepest Descent Method for Rosenbrock''s Banana Function')
toc
