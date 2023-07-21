clc;
clear all;
epsilon_0=8.85*10^-12;
epsilon_1=3.9*epsilon_0;
epsilon_2 = sqrt(9.75)*epsilon_0;
epsilon_3=2.5*epsilon_0;
miu_0=4*pi*10^-7;
miu_1=miu_0;
miu_2=miu_0;
f_0=40*10^9;
d=2*10^-3;
w_0=2*pi*f_0;
z1=38.18;
z2=42.66;
z3=47.68;
a1=z2-z1;
a2=z2+z1;
a3=a1/a2;
gamma_12 = (z2-z1)/(z2+z1);
gamma_23 = (z3-z2)/(z3+z2);
lamda_2 = 4.25*10^-3;
tao_23 = 2*z3/(z3+z2);
velocity_2 = 1/sqrt(miu_2*epsilon_2);
l_2 = velocity_2/(4*f_0);
v_0=1;

w=linspace(-4*w_0,4*w_0,1024);
tao=600*(10^-12);

delta_w = (8*w_0)/1024;
delta_t = pi/(4*w_0);
N=floor((8*w_0)/delta_w);
v_a=(v_0*tao*sqrt(pi))/2;
a=N*delta_t/2;
t= -a:(delta_t):a-delta_t ; 

g_t=zeros(1,N);

for j=1:N                            %vg(w) and g(t) calculating
    g_t(j)=v_0*exp(-((-N*delta_t/2+j*delta_t)/tao)^2);
end
v0_w=v_a*(exp(-0.25*(tao^2)*((w-w_0).^2))+exp(-0.25*(tao^2)*((w+w_0).^2)));

g_t_d=zeros(1,N);
flag=1;
t_delay=floor( (l_2/velocity_2)/delta_t);                                   % time delay by index


w=linspace(-4*w_0,4*w_0,1024);
tao_13=(4*z2*z3/(z2+z3)).*exp(-1j*(l_2/velocity_2).*w)./(z2.*(1+gamma_23.*exp(1j*(2*l_2/velocity_2).*w))+z1.*(1-gamma_23.*exp(1j*(2*l_2/velocity_2).*w)));
v3_w=v0_w.*tao_13;
betta_2=w/velocity_2;
tao_12=(1 + gamma_12)./(1 + gamma_23*exp(-2i*betta_2*l_2) );

for j=1:N                                                                   %  calculating simultaniously sevral functions and parameters
    if ((j-t_delay)>0)                                                      % calculating the delayed function of g
        g_t_d(j)=g_t(j-t_delay);
    end
    if flag==1&&j>2 && abs(v3_w(j-1))>abs(v3_w(j))&&abs(v3_w(j-1))>abs(v3_w(j-2))  %maximum finding. flags =1 while we haven't found
        max_v3=abs(v3_w(j-1));                                                     
        j_max=j-1;
        flag=0;
    end
    if flag==0&&abs(v3_w(j))<(max_v3/exp(1))                                 %BW calculating
        bw=2*delta_w*(j-j_max);                                              %initiate only after max has found
        bw_w=bw/(2*pi);
        flag=2;                                                              %flag=2 to stop looking for BW or MAX
    end  
end

gam=gamma_23*exp(-1i*2*betta_2*l_2);
gamma_1=(a3+gam)./(1+a3*gam);

% smithplot(gamma_1);
                                                                        %%%  invers furier transform
v3_t=circshift((1/delta_t)*ifft(circshift(v3_w,N/2)),N/2);

a=N*delta_t/2;

% figure;
% plot(t,abs(g_t))
% xlim([-a a])
% title('g_t')
% xlabel('t')
% ylabel('abs(g_t)')
% 
% figure
% plot(t,g_t_d,t,v3_t)
% legend({'g(t-l/v)','v3(t)'},'FontSize',12,'TextColor','blue');
% xlim([-a a])
% title('g_t_d & v3_t')
% xlabel('t')
% ylabel('g_t')

% figure
% plot(t,v3_t)
% xlim([-a a])
% title('v3_t')
% xlabel('w')
% ylabel('v3_t')


% figure;
% plot(w,abs(v0_w))
% xlim([-4*2.6*10^11 4*2.6*10^11])
% title('v0(w)')
% xlabel('w')
% ylabel('abs(vg(w))')
% 
% figure;
% plot(w,abs(tao_13))
% xlim([-10^12 10^12])
% title('tao_13')
% xlabel('w')
% ylabel('abs(tao_13)')

% figure;
% plot(t,abs(betta_2))
% xlim([-4*2.6*10^11 4*2.6*10^11])
% title('betta_2')
% xlabel('w')
% ylabel('abs(betta_2)')

% figure;
% plot(t,abs(tao_12))
% xlim([-4*2.6*10^11 4*2.6*10^11])
% title('tao_12')
% xlabel('w')
% ylabel('abs(tao_12)')

% figure;
% plot(t,abs(v3_w))
% xlim([-4*2.6*10^11 4*2.6*10^11])
% title('v3_w')
% xlabel('w')
% ylabel('abs(v3_w)')

w_c1=(pi/d)/sqrt(epsilon_1*miu_0);
w_c2=(2*pi/d)/sqrt(epsilon_1*miu_0);
w_c3=(3*pi/d)/sqrt(epsilon_1*miu_0);

betta1_w= sign(1.*w-w_c1).*sqrt(w.^2*miu_0*epsilon_1-(1*pi/d)^2);
betta2_w= sign(1.*w-w_c2).*sqrt(w.^2*miu_0*epsilon_1-(2*pi/d)^2);
betta3_w= sign(1.*w-w_c3).*sqrt(w.^2*miu_0*epsilon_1-(3*pi/d)^2);
figure
plot(w,real(betta1_w),w,real(betta2_w),w,real(betta3_w))
legend({'betta 1','betta 2','betta 3'},'FontSize',12,'TextColor','blue');
xlim([-4*2.6*10^11 4*2.6*10^11])
title('betta_w')
xlabel('w')
ylabel('real(betta_w)')

delta_z=(10*10^-3)/N;

v1_zm1w = v0_w.*exp(-1i*betta1_w*1*delta_z);
v1_zm2w = v0_w.*exp(-1i*betta1_w*N/2*delta_z);
v1_zm3w = v0_w.*exp(-1i*betta1_w*N*delta_z);

% figure
% plot( w,log(abs(v1_zm1w)),w,log(abs(v1_zm2w)),w,log(abs(v1_zm3w)) );   
% legend({'| v1( z=0[cm ],w) |','| v1( z=5[cm],w ) |','| v1( z=10[cm],w ) |'},'FontSize',12,'TextColor','blue');
% xlim([-4*2.6*10^11 4*2.6*10^11])
% title('log(|v1_zm|')
% xlabel('w')
% ylabel('log(|v1_zm|')
% 
% figure
% plot(w,angle(v1_zm1w),w,angle(v1_zm2w),w,angle(v1_zm3w));  
% legend({'arg v1( z=0[cm ],w) ',' arg v1( z=5[cm],w ) ','arg v1( z=10[cm],w ) '},'FontSize',12,'TextColor','blue');
% xlim([-4*2.6*10^11 4*2.6*10^11])
% title('arg(v1_zm)')
% xlabel('w')
% ylabel('arg(v1_zm)')
    
                                                                  %%%%invers furier transform
v1_zm1t=circshift((1/delta_t)*ifft(circshift(v1_zm1w,N/2)),N/2);
v1_zm2t=circshift((1/delta_t)*ifft(circshift(v1_zm2w,N/2)),N/2);
v1_zm3t=circshift((1/delta_t)*ifft(circshift(v1_zm3w,N/2)),N/2);

figure
plot(w,v1_zm1t,w,v1_zm2t,w,v1_zm3t,w,g_t);   
legend({' v1( z=0[cm ],t) ','  v1( z=5[cm],t ) ',' v1( z=10[cm],t) ','g(t)'},'FontSize',12,'TextColor','blue');
xlim([-4*2.6*10^11 4*2.6*10^11])
title('v1_zmt(i)')
xlabel('t')
ylabel('v1_zmt(i)')


