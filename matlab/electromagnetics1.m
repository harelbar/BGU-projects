w_in=0.8*10^-3;
d_in=2*10^-3;
miu_0=4*pi*10^-7;
epsilon_0=8.85*10^-12;
miu_1=miu_0;
miu_2=miu_1;
epsilon_1=2.5*epsilon_0;
epsilon_2=epsilon_1;
num1=313611113;
num2=206299612;
axisFontSize=20;
shloop=[0 6]*0.1*10^-3;
t=1;                                                % t=5 for י"�?
h1=1;
h2=1;
s=1;
w=2;
D=[0.2 0.1 0.05 0.025 0.0125].*10^-3; %%0.0125
G=zeros(4,4);                                       %the gammas for י"�? 
gam=zeros(1,t);
err=zeros(1,t);
run_time=zeros(1,t);
rounds=zeros(1,t);

%for q=1:6                                             % prezenting י"ד at figure 
%for w=1:t                                    
%for h2=1:4
% for h1=1:4
for s=1:2
                                   %s=1:2 for י"ד
delta=D(w);
H1=[0 1 2 3]*delta; 
H2=[0 1 2 3]*delta; 

w_out=(10*10^-3)+H2(h2);
h_out=(4*10^-3)+H2(h2);
M=round(h_out/delta)+1;                                   %number of rows
N=round(w_out/delta)+1;                                   %number of columbs
c0_p=0;
c1_p=0.5;
c2_p=-0.5;
a=(w_out-2*w_in-d_in)/2;                              %the space distande on the sides
b=(h_out-w_in)/2;                                     %the space distande on the upper and lower part
j_c1L=floor((a-H1(h1)-shloop(s))/delta);                                 %the index thats represent the left boundary of c1
j_c1R=floor((a+w_in+H1(h1)+shloop(s))/delta);           %rigt boundary of c1
j_c2L=floor((a+w_in+d_in-H1(h1)-shloop(s))/delta); 
j_c2R=floor((a+w_in+d_in+w_in+H1(h1)+shloop(s))/delta);
i_c1D=floor((b-H1(h1)-shloop(s))/delta); 
i_c1U=floor((b+w_in+H1(h1)+shloop(s))/delta);
i_c2D=floor((b-H1(h1)-shloop(s))/delta); 
i_c2U=floor((b+w_in+H1(h1)+shloop(s))/delta);              % s=1 to cancle the offset
P=zeros(M,N); 
for i=1:M                           % boundery condition
    for j=1:N
        if (i==1||i==M||j==1||j==N)
            P(i,j)=c0_p;
        end
        if ( ( (i==i_c1U||i==i_c1D) && (j>=j_c1L&&j<=j_c1R) ) || ( (i>=i_c1D&&i<=i_c1U) && (j==j_c1R||j==j_c1L) ))
            P(i,j)=c1_p;
        end
        if ( ( (i==i_c2D||i==i_c2U) && (j>=j_c2L&&j<=j_c2R) ) || ( (i>=i_c2D&&i<=i_c2U)&&(j==j_c2L||j==j_c2R) ) )
            P(i,j)=c2_p;
        end
    end
end
f=zeros(M,N);
reshape(f,[M*N,1]);
reshape(P,[M*N,1]);
tic;
rounds(w)=0;

while (norm(P)-norm(f))/norm(f)>=10^-5
reshape(P,[M,N]);
f=P;
rounds=rounds+1;
for i=2:M-1                          %  potential setting
    for j=2:N-1
        if ( (i<i_c1D||i>i_c1U)&&j<j_c2L || (i<i_c2D||i>i_c2U)&&j>j_c1R || j<j_c1L || j>j_c2R || (j>j_c1R && j<j_c2L) )
            P(i,j)=(P(i+1,j)+P(i-1,j)+P(i,j+1)+P(i,j-1) )/4;
        end
    end
end
reshape(P,[M*N,1]);
reshape(f,[M*N,1]);
end

run_time(w)=toc;
reshape(P,[M,N]);

figure;
imagesc(P);
ax = gca;
ax.YDir = 'normal';
colorbar;
axis image;
xlabel('x-axis', 'FontSize', axisFontSize);
ylabel('y-axis', 'FontSize', axisFontSize);
title('potential','FontSize', axisFontSize);

e_modal=zeros(M,N,2);
for i=2:M-1                      %  e modal calculation
    for j=2:N-1
        if ((i<i_c1D||i>i_c1U)&&j<j_c2L || (i<i_c2D||i>i_c2U)&&j>j_c1R || j<j_c1L || j>j_c2R || (j>j_c1R && j<j_c2L) )
            e_modal(i,j,1)= -( P(i,j+1) - P(i,j-1) )/(2*delta); % e_modal_x
            e_modal(i,j,2)= -( P(i+1,j) - P(i-1,j) )/(2*delta); % e_modal_y
        end
    end
end

gamma=0;
for j=j_c2L-1:j_c2R+1            % gamma calculation
    gamma=gamma + ( e_modal(i_c2D-1,j,2)-e_modal(i_c2U+1,j,2))*delta; %summing the y'th coordinates of e at the upper and lower part of c1
end
for i=i_c2D-1:i_c2U+1
    gamma=gamma + (e_modal(i,j_c2L-1,1)-e_modal(i,j_c2R+1,1) )*delta; %summing the  x'th coordinates of e at the left and right parts of c1
end
G(h1,h2)=gamma;                      %  for  י"�?, י"ב
gam(w)=gamma;
if s==1
    gamma1=gamma;
elseif s==2
    gamma2=gamma;
end
h_modal=zeros(M,N,2);
for i=2:M-1                       % h modal calculation
    for j=2:N-1
        if ( (i<i_c1D||i>i_c1U)&&j<j_c2L || (i<i_c2D||i>i_c2U)&&j>j_c1R || j<j_c1L || j>j_c2R || (j>j_c1R && j<j_c2L) )
            h_modal(i,j,1)= -e_modal(i,j,2)/gamma;
            h_modal(i,j,2)= e_modal(i,j,1)/gamma;
        end
    end
end

figure
[x,y]=meshgrid(1:N,1:M);
quiver(x,y,e_modal(:,:,1),e_modal(:,:,2));
ylim([0 M]);
xlim([0 N]);
xlabel('x-axis', 'FontSize', axisFontSize);
ylabel('y-axis', 'FontSize', axisFontSize);
title('electric modal','FontSize', axisFontSize);
figure
quiver(x,y,h_modal(:,:,1),h_modal(:,:,2));
ylim([0 M]);
xlim([0 N]);
xlabel('x-axis', 'FontSize', axisFontSize);
ylabel('y-axis', 'FontSize', axisFontSize);
title('magnetic modal','FontSize', axisFontSize);

%end  %   the end of fields calculation
end 
% 
% imagesc(G);
% ax = gca;
% ax.YDir = 'normal';
% colorbar;
% axis image;
% xlabel('H2- frame width ', 'FontSize', axisFontSize);
% ylabel('H1- wire width', 'FontSize', axisFontSize);
% title('gamma as a function of widthning ','FontSize', axisFontSize);
% figure;

%  for i=1:t                                  
%      err(i)=abs(gam(i)-gam(t))/abs(gam(t));
%  end
% loglog(D,err)
% xlabel('delta', 'FontSize', axisFontSize);
% ylabel('err', 'FontSize', axisFontSize);
% title('relative error for delta','FontSize', axisFontSize);
% figure;
% loglog(D,run_time) 
% xlabel('delta', 'FontSize', axisFontSize);
% ylabel('run_time', 'FontSize', axisFontSize);
% title('run_time for delta','FontSize', axisFontSize);
% figure;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
L1=miu_1/gamma1;
C1=epsilon_1*gamma1;
Zc1=sqrt(L1/C1);
velocity_1=1/sqrt(L1*C1);
L2=miu_2/gamma2;
C2=epsilon_2*gamma2;
Zc2=sqrt(L2/C2);
velocity_2=1/sqrt(L2*C2);
Rg=Zc1*num1/(num1+num2);

T=1;
Tp=T/10;
l_2=T*velocity_2;
l_1=T*velocity_1;
del_t=T/50;
del_z=(l_1+l_2)/1000;
Tp_index=Tp/del_t;
sh=(l_1/del_z);
l_1_index= floor(sh);
l_2_index= l_1_index + floor((l_2/del_z));

t_max= (8*T)/del_t+1;
z_max= floor( (l_1+l_2)/del_z+1 ); %for symetry
U= zeros(t_max , z_max);
for t=1:t_max
    for z=1:z_max
        if (t*del_t-z*del_z/velocity_1)>0
            U(t,z)=111111;
        end
    end
end
U_Tp= zeros(t_max , z_max);
for t=1:t_max
    for z=1:z_max
        if (t*del_t-z*del_z/velocity_1-Tp)>0
            U_Tp(t,z)=111111;
        end
    end
end

V_t= zeros(t_max , z_max);
Vg_t=U-U_Tp;
V_D= Zc1/(Zc1+Rg);      % voltage divider
gamma_l1= (Zc2-Zc1)/(Zc1+Zc2);
tao= (2*Zc2)/(Zc1+Zc2);
gamma_in= (Rg-Zc1)/(Rg+Zc2);
for z=1:z_max 
    for t=1:t_max
        for k=0:4
            if ( ( (t*del_t - z*del_z/velocity_1-(2*T*k))>0 )&&z<l_1_index &&t>(2*T*k)/del_t )   
                V_t(t,z)=V_t(t,z)+V_D*( (gamma_in*gamma_l1)^k)*(Vg_t(t-2*T*k/del_t,z ) );
            end
            if ( (t*del_t + (z*del_z)/velocity_1-(2*k+1)*T)>0 ) && z<l_1_index && t>((2*k+1)*T)/del_t    
                V_t(t,z)=V_t(t,z)+V_D*gamma_l1*((gamma_in*gamma_l1)^k)*Vg_t(t- ((2*k+1)*T)/del_t , -z+l_1_index);
            end
            if ( t-z*del_z/velocity_1-2*k*T >0 && z>=l_1_index && t>(2*k+1)*T/del_t )
                V_t(t,z)=V_t(t,z)+V_D*tao*((gamma_in*gamma_l1)^k)*Vg_t(t-(2*k+1)*T/del_t , z-l_1_index+1);
            end
        end            
    end
end
imagesc(V_t)
axis ij
colorbar;
colormap jet

axis image;
xlabel('z-axis', 'FontSize', axisFontSize);
ylabel('t-axis', 'FontSize', axisFontSize);
title('voltage','FontSize', axisFontSize);
 figure;
           
        
            
            
            
            