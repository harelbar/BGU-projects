clear;
clc;
%-------------------------Q1---------------------------------------
a = 1;
b = 5;
I1 = 313611113; 
I2 = I1;
e_max = 10^(-12); 
s = 3^(1/4); 
x0 = a + (I1/(I1+I2))*(b-a);
format long 
[x_n1,err,x_d1] = Newton_Raphson(x0,e_max,s,1,'f1');
figure(1)
x_axis = log(err(1:end-1)); %log(epsilon_(n-1))
y_axis = log(err(2:end));  %log(epsilon_(n))
plot(x_axis,y_axis,'-o');
title('Question 1: Newton Raphson Method');
xlabel('log(\bf\epsilon_n_-_1))'); 
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;
n = 1:length(err); 
T1 = table(n',x_n1', err', x_d1','VariableNames',{'n','x_n','x_n eror','x_n difference'});
disp(T1); 

%--------------------------Q2--------------------------------------
x1 = x0 + (b-x0)*(I1/(I1+I2)); 
[x_n2,err,x_d2] = Secant_method(x0,x1,e_max,s);
figure(2)
x_axis = log(err(1:end-1));
y_axis = log(err(2:end));
plot(x_axis,y_axis,'-o');
xlim tight;
ylim tight;
title('Question 2: Secant Method');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;
n = 1:length(err); 
T2 = table(n',x_n2', err', x_d2','VariableNames',{'n','x_n','x_n eror','x_n difference'});
disp(T2); 

%---------------------------Q3-A-----------------------------
x0 = 5;
[x_n_3_A,err3A,x_d3_A] = Newton_Raphson(x0,e_max,2,1,'f2'); 
n = 1:length(err3A);
T3_A = table(n',x_n_3_A', err3A', x_d3_A','VariableNames',{'n','x_n','x_n eror','x_n difference'});
fprintf('%60s\n','<strong> NR0 </strong>'); %disp title to table
disp(T3_A); %Display the table in the command window.

%---------------------------Q3-B-----------------------------
x0 = 5;
[x_n_3_B,err3B,x_d3_B] = Newton_Raphson(x0,e_max,2,1,'u'); 
n = 1:length(err3A); %For table
x_n_3_Bt=x_n_3_B;
x_n_3_Bt(end:length(x_n_3_A))=x_n_3_Bt(end);
err3Bt=err3B;
err3Bt(end:length(err3A))=err3Bt(end);
x_d3_Bt=x_d3_B;
x_d3_Bt(end:length(x_d3_A))=err3Bt(end);
T3_B = table(n',x_n_3_A', err3A', x_d3_A',x_n_3_Bt', err3Bt', x_d3_Bt','VariableNames',{'n','x_n_A','x_n eror_A','x_n_A difference','x_n_B','x_n eror_B','x_n_B difference'});
fprintf('%60s\n','<strong> NR1 </strong>'); %disp title to table
disp(T3_B); %Display the table in the command window.

%---------------------------Q3-C-----------------------------
[x_n_3_C,err3C,x_d3_C] = Newton_Raphson(x0,e_max,2,2.999,'f2'); 
n = 1:length(err3A);
x_n_3_Ct=x_n_3_C;
x_n_3_Ct(end:length(x_n_3_A))=x_n_3_Ct(end);
err3Ct=err3C;
err3Ct(end:length(err3A))=err3Bt(end);
x_d3_Ct=x_d3_C;
x_d3_Ct(end:length(x_d3_A))=err3Ct(end);
T3_C = table(n',x_n_3_A', err3A', x_d3_A',x_n_3_Bt', err3Bt', x_d3_Bt',x_n_3_Ct', err3Ct', x_d3_Ct','VariableNames',{'n','x_n_A','x_n eror_A','x_n_A difference','x_n_B','x_n eror_B','x_n_B difference','x_n_C','x_n eror_C','x_n difference_C'});
fprintf('%60s\n','<strong> NR2 </strong>');
disp(T3_C);

%---------------------------Q4-A-----------------------------
x0 = pi/2;
s4 = 1.895494267034;
[x_n_4_A,err4A,x_d4_A] = Fixed_Point(x0,e_max,s4,'gA');
n = 1:length(err4A);
T4_A = table(n',x_n_4_A', err4A', x_d4_A','VariableNames',{'n','x_n','x_n eror','x_n difference'});
fprintf('%60s\n','<strong> NR2 </strong>'); 
disp(T4_A);

%---------------------------Q4-B-----------------------------
[x_n_4_B,err4B,x_d4_B] = Newton_Raphson(x0,e_max,s4,1,'gB'); %Run NewtonRaphson Method function
n = 1:length(err4B);
T4_B = table(n',x_n_4_B', err4B', x_d4_B','VariableNames',{'n','x_n','x_n eror','x_n difference'});
disp(T4_B); %Display the table in the command window.

%---------------------------Q4-D-----------------------------
s4_D=0;
x0 = 1/2;
[x_n_4_D,err4D,x_d4_D] = Fixed_Point(x0,e_max,s4_D,'g2'); %Run NewtonRaphson Method function
n = 1:length(err4D);
T4_D = table(n',x_n_4_D', err4D', x_d4_D','VariableNames',{'n','x_n','x_n eror','x_n difference'});
disp(T4_D); 

%%---------------------PLOTS---------------------
figure(3)
subplot(3,1,1)
x_axis = log(err3A(1:end-1));
y_axis = log(err3A(2:end)); 
plot(x_axis,y_axis,'-o');
title('Question 3 Part A: Newton Raphson Multiple Sqrt');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;
subplot(3,1,2)
x_axis = log(err3B(1:end-1));
y_axis = log(err3B(2:end)); 
plot(x_axis,y_axis,'-o');
title('Question 3 Part B: Newton Raphson Multiple Sqrt');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;
subplot(3,1,3)
x_axis = log(err3C(1:end-1)); 
y_axis = log(err3C(2:end)); 
plot(x_axis,y_axis,'-o');
title('Question 3 Part C: Newton Raphson Multiple Sqrt');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;

figure(4)
subplot(3,1,1)
x_axis = log(err4A(1:end-1));
y_axis = log(err4A(2:end)); 
plot(x_axis,y_axis,'-o');
title('Question 4 Part A: Fixed Point Method');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;
subplot(3,1,2)
x_axis = log(err4B(1:end-1)); %log(epsilon_(n-1))
y_axis = log(err4B(2:end)); %log(epsilon_(n))
plot(x_axis,y_axis,'-o');
title('Question 4 Part B: Newton Raphson Method');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;
subplot(3,1,3)
x_axis = log(err4D(1:end-1)); %log(epsilon_(n-1))
y_axis = log(err4D(2:end)); %log(epsilon_(n))
plot(x_axis,y_axis,'-o');
title('Question 4 Part D: Fixed Point Method');
xlabel('log(\bf\epsilon_n_-_1))');
ylabel('log(\bf\epsilon_n)');
xlim tight;
ylim tight;
grid on;
grid minor;

function [x_n,err,x_n_dif] = Newton_Raphson(x0,e_max,s,mult,func)
    i = 2;
    c=1;
    err = zeros; 
    x_n_dif = zeros; 
    h=step(x0,func);
    x_n(1) = x0; 
    x_n(2) = x0-mult*h;
    x_n_dif(1)=0;
    x_n_dif(2) = abs(x_n(2)-x_n(1)); %|x_(n)-x_(n-1)|;
    err(1) = abs(x_n(1) - s);
    err(2) = abs(x_n(2) - s); %|x_n - s|
    while (x_n_dif(i) > e_max)&&c~=0
        h=step(x_n(i),func);
        x_n(i+1) = x_n(i) - mult*h;
        x_n_dif(i+1) = abs(x_n(i+1)-x_n(i)); 
        err(i+1) = abs(x_n(i+1) - s); 
        c=any(err(i+1));
        i=i+1; 
        if (err(i)>=err(i-1))&&i>2
            temp1=x_n;
            x_n=zeros;
            x_n=temp1(1:end-1);
            temp2=err;
            err=zeros;
            err=temp2(1:end-1);
            temp3=x_n_dif;
            x_n_dif=zeros;
            x_n_dif=temp3(1:end-1);
            break;
        end
    end
end

function [x_n,err,x_n_dif] = Secant_method(x0, x1, e_max,s)
    i = 2;
    c=1;
    err = zeros;
    x_n_dif = zeros; 
    x_n(1) = x0;
    x_n(2) = x1;
    x_n_dif(1)=0;
    x_n_dif(2) = abs(x_n(2)-x_n(1)); 
    err(1) = abs(x_n(1) - s);
    err(2) = abs(x_n(2) - s);
    while (x_n_dif(i) > e_max)&&c~=0
        x_n(i+1) = x_n(i) - f1(x_n(i))*(x_n(i)-x_n(i-1))/(f1(x_n(i))-f1(x_n(i-1)));
        x_n_dif(i+1) = abs(x_n(i+1)-x_n(i)); 
        err(i+1) = abs(x_n(i+1) - s);  
        c=any(err(i+1));
        i=i+1; 
    end
end


function [x_n,err,x_n_dif] = Fixed_Point(x0,e_max,s,func)
    i = 2;
    err = zeros;
    x_n_dif = zeros;
    x_n(1) = x0;
    x_n(2) = step(x_n(1), func);
    x_n_dif(1)=0;
    x_n_dif(2) = abs(x_n(2)-x_n(1)); 
    err(1) = abs(x_n(1) - s);
    err(2) = abs(x_n(2) - s); 
    while x_n_dif(i) >= e_max
        x_n(i+1) = step(x_n(i), func);
        x_n_dif(i+1) = abs(x_n(i+1)-x_n(i));  
        err(i+1) = abs(x_n(i+1) - s);         
        i=i+1;
    end
end

function y = step(x,func)  %choose h depents in the section
    if func == 'f1'
        y = f1(x) / df1(x);
    elseif func == 'f2'
        y = f2(x) / df2(x);
    elseif func == 'u'
        y = u(x)/du(x);  
    elseif func == 'gA'
        y = gA(x);
    elseif func == 'gB'
        y = gB(x)/dgB(x);
    elseif func == 'g2'
        y = g2(x);
    end   
end
function y = f1(x) 
        y = x^4-3;
end
function y = df1(x) 
        y = 4*x^3;
end

function y = f2(x)  %f2(x)
    y = x^5-6*x^4+14*x^3-20*x^2+24*x-16;
end
function y = df2(x) %f2'(x)
    y = 5*x^4-24*x^3+42*x^2-40*x+24;
end
function y = d2f2(x) %f''(x)
    y = 20*x^3-72*x^2+84*x-40;
end

function y = u(x) % u = f(x) / f'(x) 
    y = f2(x) / df2(x);
end
function y = du(x) % u = f(x) / f'(x) 
    y = 1-f2(x)*d2f2(x)/(df2(x))^2;
end

function y = gA(x) 
        y = 2*sin(x);
end

function y = g2(x) 
        y = asin(x/2);
end

function y = gB(x) 
        y = x-2*sin(x);
end
function y = dgB(x) 
        y = 1-2*cos(x);
end








