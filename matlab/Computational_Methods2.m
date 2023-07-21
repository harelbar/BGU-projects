clear all
close all
clc

%------------------------------Question 1----------------------------------
%------------------------------Section A-----------------------------------

n = [2,3,4,5]; 
teta_restore = linspace(0,pi,41);                                           %n'+1 = 41 dots.

for j = 1:length(n)                                                         % lagrange interpulation for n=2:5 and r=5 cm
    sampeling_teta = linspace(0,pi,n(j)); 
    for i = 1:length(teta_restore)
        Phi_approx(j,i) = Lagrange_Interpolation(teta_restore(i),sampeling_teta,'A');
    end
end

for i = 1:length(teta_restore)                                              %potential calculation for r=5 cm
   Phi_real(i) = potential(teta_restore(i),'A');
end

figure(1)
p = plot(teta_restore, Phi_real, teta_restore, Phi_approx,'-*');
p(1).LineWidth = 3;
p(1).Color = 'k';
legend('Real Phi','Approx Phi_2:n+1=2','Approx Phi_3:n+1=3','Approx Phi_4:n+1=4','Approx Phi_5:n+1=5','Location','northeast')
title('Question 1 Section A- \phi(\theta)')
xlabel("\theta")
ylabel("\phi(\theta)")
fontsize(gca,30,"pixels")
grid on

%------------------------------Section B-----------------------------------

n_rel_err = 2:2:20;
for j = 1:length(n_rel_err)                                                 % lagrange interpulation for n=2:2:20 and r=5 cm
    sampeling_teta = linspace(0,pi,n_rel_err(j)); 
    for i = 1:length(teta_restore)
        Phi_approx(j,i) = Lagrange_Interpolation(teta_restore(i),sampeling_teta,'A');
    end
end

for i = 1:length(n_rel_err)                                                 % relative eror for r=5 cm
    rel_err_b(i) = sqrt(sum((Phi_approx(i,:)-Phi_real).^2)/sum(Phi_real.^2));
end

figure(2)
semilogy(n_rel_err,rel_err_b,'-*')
title('Question 2 Section B-Relative Error')
xlabel("n+1")
ylabel("Relative Error")
fontsize(gca,30,"pixels")
grid on

%------------------------------Section C-----------------------------------
n = [3,7,11,15]; 

for j = 1:length(n)
    sampeling_teta = linspace(0,pi,n(j)); 
    for i = 1:length(teta_restore)                                          % lagrange interpulation for n=3,7,11,15 and r=4 mm
        Phi_approx_c_a(j,i) = Lagrange_Interpolation(teta_restore(i),sampeling_teta,'C');
    end
end

for i = 1:length(teta_restore)                                              %potential calculation for r=4 mm
   Phi_real_c(i) = potential(teta_restore(i),'C');
end

figure(3)
p = plot(teta_restore, Phi_real_c, teta_restore, Phi_approx_c_a,'-*');
p(1).LineWidth = 3;
p(1).Color = 'k';
legend('Real Phi','Approx Phi_3:n+1=3','Approx Phi_7:n+1=7','Approx Phi_1_1:n+1=11','Approx Phi_15:n+1=15','Location','northeast')
title('Question 1 Section C - \phi(\theta)  r=4mm')
xlabel("\theta")
ylabel("\phi(\theta)")
fontsize(gca,30,"pixels")
grid on

for j = 1:length(n_rel_err)
    sampeling_teta = linspace(0,pi,n_rel_err(j)); 
    for i = 1:length(teta_restore)
        Phi_approx_c_b(j,i) = Lagrange_Interpolation(teta_restore(i),sampeling_teta,'C');
    end
end

for i = 1:length(n_rel_err)                                                  % relative eror for r=4 mm
    rel_err_c(i) = sqrt(sum((Phi_approx_c_b(i,:)-Phi_real_c).^2)/sum(Phi_real_c.^2));
end

figure(4)
semilogy(n_rel_err,rel_err_c,'-*')
title('Question 1 Section C - Relative Error r=4mm')
xlabel("n+1")
ylabel("Relative Error")
fontsize(gca,30,"pixels")
grid on

%------------------------------Section D-----------------------------------

n = [3,7,11,15]; 

for j = 1:length(n)
    sampeling_teta = Chebyshev_Roots(n(j),0,pi); 
    for i = 1:length(teta_restore)
        Phi_approx_d_a(j,i) = Lagrange_Interpolation(teta_restore(i),sampeling_teta,'C');
    end
end

figure(5)
p = plot(teta_restore, Phi_real_c,teta_restore, Phi_approx_d_a,'-*');
p(1).LineWidth = 3;
p(1).Color = 'k';
legend('Real Phi','Approx Phi_3:n+1=3','Approx Phi_7:n+1=7','Approx Phi_1_1:n+1=11','Approx Phi_15:n+1=15','Location','northeast')
title('Question 1 Section D- \phi(\theta) using Chebyshev')
xlabel("\theta")
ylabel("\phi(\theta)")
fontsize(gca,30,"pixels")
grid on

for j = 1:length(n_rel_err)
    sampeling_teta = Chebyshev_Roots(n_rel_err(j),0,pi); 
    for i = 1:length(teta_restore)
        Phi_approx_d_b(j,i) = Lagrange_Interpolation(teta_restore(i),sampeling_teta,'C');
    end
end

for i = 1:length(n_rel_err)                                                 % relative eror for r=4 mm
    rel_err_d(i) = sqrt(sum((Phi_approx_d_b(i,:)-Phi_real_c).^2)/sum(Phi_real_c.^2));
end

figure(6)
semilogy(n_rel_err,rel_err_d,'-*',n_rel_err,rel_err_c,'-*')
legend('Relative error with chebyshev sampeling','Relative error with Uniform Distribution')
title('Question 1 Section D Relative Error')
xlabel("n+1")
ylabel("Relative Error")
fontsize(gca,30,"pixels")
grid on

%------------------------------Question 2----------------------------------
%------------------------------Section B-----------------------------------

n = [2,3,4];

for j = 1:length(n)
    sampeling_teta = linspace(0,pi,n(j));
    for i = 1:length(sampeling_teta)
        y_1(i) = potential(sampeling_teta(i),'Q2');
    end
    [a(j),b(j),c(j)] = Coefficients(sampeling_teta,y_1');                   % calculating the coefficients for the
    Phi_LS_2_B(j,:) = a(j)+b(j)*sin(teta_restore)+c(j)*cos(teta_restore);   % least squers interpulation
end

for i = 1:length(teta_restore)
    Phi_real_2_B(i) = potential(teta_restore(i),'Q2');
end

figure(7)
p = plot(teta_restore, Phi_real_2_B, teta_restore, Phi_LS_2_B,'-*');
p(1).LineWidth = 3;
p(1).Color = 'k';
title("Question 2 Section B- \phi(\theta) using Least Squares")
xlabel("\theta")
ylabel("\phi(\theta)")
legend("real", "n+1=2","n+1=3","n+1=4")
fontsize(gca,30,"pixels")
grid on

%------------------------------Section C-----------------------------------

r0 = 10;
r=r0./(2.^(0:8));                                                           % calculating for differents radiuses
n = 4;
sampeling_teta = linspace(0,pi,n);

for j = 1:length(r)
    for i = 1:length(sampeling_teta)
        y_1(i) = potential_2(sampeling_teta(i),r(j));
    end
    [a(j),b(j),c(j)] = Coefficients(sampeling_teta, y_1');
    Phi_LS_2_C(j,:) = a(j)+b(j)*sin(teta_restore)+c(j)*cos(teta_restore);
    for i = 1:length(teta_restore)
        Phi_real_2_C(j,i) = potential_2(teta_restore(i),r(j));
    end
end

for i = 1:length(r)                                                         % relative eror for different r
    rel_err_2_c(i) = sqrt(sum((Phi_LS_2_C(i,:)-Phi_real_2_C(i,:)).^2)/sum(Phi_real_2_C(i,:).^2));
end

figure(8)
loglog(r', rel_err_2_c, "-o")
title("Question 2 Section C-Relative Error")
xlabel("Radius[m]")
ylabel("relative error")
fontsize(gca,30,"pixels")
grid on

%------------------------------Section D-----------------------------------

delta=[10^-1 10^-4];

for t=1:2

n = 4*2.^(0:16);
y=zeros;

for j = 1:length(n)
    sampeling_teta = linspace(0,pi,n(j)); %theta_j
    for i = 1:length(sampeling_teta)
        y(i) = potential(sampeling_teta(i),'Q2');
    end
    y_error = (1+(rand(1,n(j))-0.5)*delta(t)).*y;
    [a(j),b(j),c(j)] = Coefficients(sampeling_teta, y_error');
    Phi_LS_2_D(j,:) = a(j)+b(j)*sin(teta_restore)+c(j)*cos(teta_restore);
end

Phi_real_2_D=Phi_real_2_B;

for i = 1:length(n)            % relative eror for r=4 mm
    rel_err_2_d(i) = sqrt(sum((Phi_LS_2_D(i,:)-Phi_real_2_D).^2)/sum(Phi_real_2_D.^2));
end

figure(8+t)
loglog(n', rel_err_2_d, '-*')
title("Question 2 Section D-Relative Error")
xlabel("n+1")
ylabel("relative error")
fontsize(gca,30,"pixels")
grid on
end

%------------------------------Question 3----------------------------------
%------------------------------Section A-----------------------------------

clear
format long
a = 0;
b = 1;
Trapezoid_approx = Trapezoid_Integration(a,b,'t');                          % proof of concept for the different
Simpson_approx = Simpson_Integration(a,b,'t');                              % integrations methods
Integral_Real = 1;
Err_Trapezoid = abs((Integral_Real - Trapezoid_approx)/Integral_Real);
Err_Simpson = abs((Integral_Real - Simpson_approx)/Integral_Real);

%------------------------------Section B-----------------------------------

n = [5 9 17 33 65 129 257 513];
a=0;
b=pi; 

for i=1:length(n)
    [t1(i), t2(i), t3(i)]=Trapezoid_composite_Integration(a,b,n(i));
    [s1(i), s2(i), s3(i)]=Simpson_composite_Integration(a,b,n(i));
end

err_t1=abs((t1-t1(end))./t1(end));
err_t2=abs((t2-t2(end))./t2(end));
err_t3=abs((t3-t3(end))./t3(end));

err_s1=abs((s1-s1(end))./s1(end));
err_s2=abs((s2-s2(end))./s2(end));
err_s3=abs((s3-s3(end))./s3(end));

figure(11)
semilogy(n,err_t1, 'bs', n,err_t2,'bo',n,err_t3, 'b^', n,err_s1,'rs',n,err_s2, 'ro', n,err_s3,'r^')
title('Question 3 Section B-Relative Error function of n');
xlabel('n Values');
ylabel('Relative Error');
title('Question 3 Section B-Relative Error as a function of n');
legend('f1=1 - Trapez', 'f2=sin(x) - Trapez', 'f3=cos(x) - Trapez', 'f1=1 - Simpson' , 'f2=sin(x) - Simpson', ...
    'f3=cos(x) - Simpson','Location','southwest');
fontsize(gca,30,"pixels")
grid on;

%--------------------------------------------------------------------------
%---------------------------Functions--------------------------------------
%--------------------------------------------------------------------------

function [f_x] = f_x(x,func)
if func==1
    f_x=potential(x,'Q2')*1;
elseif func==2
    f_x=potential(x,'Q2')*sin(x);
elseif func==3
    f_x=potential(x,'Q2')*cos(x);
elseif func=='t'
    f_x = 4 / (pi*(1+x^2));
end
end

function I = Trapezoid_Integration(a,b,func)
    h = b - a;
    x_1 = a;
    x_2 = b;
    I = (f_x(x_1,func)+f_x(x_2,func)) * (h/2);
end

function I = Simpson_Integration(a,b,func)
    h = (b-a)/2;
    x_1 = a;
    x_2 = (a+b)/2;
    x_3 = b;
    I = (h/3) * (f_x(x_1,func)+4*f_x(x_2,func)+f_x(x_3,func));
end

function [t1, t2, t3]=Trapezoid_composite_Integration(a,b,n)
h=(b-a)/n;
x=a+(0:n)*h;
t1=0; t2=0; t3=0;
for i=1:n
    t1=t1+Trapezoid_Integration(x(i),x(i+1),1);
    t2=t2+Trapezoid_Integration(x(i),x(i+1),2);
    t3=t3+Trapezoid_Integration(x(i),x(i+1),3);
end
end

function [s1, s2, s3]=Simpson_composite_Integration(a,b,n)
h=(b-a)/n;
x=a+(0:n)*h;
s1=0; s2=0; s3=0;
for i=1:n
    s1=s1+Simpson_Integration(x(i),x(i+1),1);
    s2=s2+Simpson_Integration(x(i),x(i+1),2);
    s3=s3+Simpson_Integration(x(i),x(i+1),3);
end
end

function [a,b,c] = Coefficients(theta,y)
    f0 = (zeros(length(theta),1)+1);
    f1 = sin(theta');
    f2 = cos(theta');
    F = [f0 f1 f2];
    Coefficients = (inv(F'*F))*F'*y;
    a = Coefficients(1);
    b = Coefficients(2);
    c = Coefficients(3);
end

function [phi] = potential(x,sec) 
    if sec == 'A'
        r = 5*10^-2;
    elseif sec == 'C'
        r = 4*10^(-3);
    elseif sec == 'Q2'
        r = 10^-1;
    end
    delta = 5 * 10^(-3);
    q_p = sum([1 3 6 1 1 1 1 3]);  % id=313611113
    h=[3 1 3 6 1 1 1 1].^2;
    h=mod(h,10);
    q_n = -sum(h);
    r_p=sqrt((r*cos(x))^2+(r*sin(x) - delta/2)^2);
    r_n=sqrt((r*cos(x))^2+(r*sin(x) + delta/2)^2);
    phi = (q_p/(4*pi*r_p)) + (q_n/(4*pi*r_n));
end

function [L_N] = Lagrange_Interpolation(x,teta,section)
    sum = 0;
    for k = 1:length(teta)
        l_k=1;
        for j = 1:length(teta)
            if (j~=k)
                l_k=l_k.*(x-teta(j))./(teta(k)-teta(j));
            end
        end
        sum = sum + potential(teta(k),section) * l_k;  
    end
    L_N = sum;
end

function [phi] = potential_2(x,r) 
    delta = 5 * 10^(-3);
    q_p = sum([1 3 6 1 1 1 1 3]);  % id=313611113
    h=[3 1 3 6 1 1 1 1].^2;
    h=mod(h,10);
    q_n = -sum(h);
    r_p=sqrt((r*cos(x))^2+(r*sin(x) - delta/2)^2);
    r_n=sqrt((r*cos(x))^2+(r*sin(x) + delta/2)^2);
    phi = (q_p/(4*pi*r_p)) + (q_n/(4*pi*r_n));
end

function [roots] = Chebyshev_Roots(n, a, b) 
x = cos(pi*(2*(1:n)-1)/(2*n));
t = ((b-a)*x+b+a)/2;
roots = t;
end

