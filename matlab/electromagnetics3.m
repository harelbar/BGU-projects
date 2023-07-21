
w_out=10*10^-3;
h_out=4*10^-3;
w_in=0.8*10^-3;
d_in=2*10^-3;
miu_0=4*pi*10^-7;
epsilon_0=8.85*10^-12;
miu_1=miu_0;
miu_2=miu_1;
epsilon_1=2.5*epsilon_0;
epsilon_2=epsilon_1;
num1=313611113;
num2=315628404;
axisFontSize=20;
shloop=6*0.1*10^-3;
t=3;                                                % t=5 for י"א
D=[0.2 0.1 0.05 0.025 0.0125].*10^-3;
G=zeros(1,t);                                       %the gammas for י"א 
err=zeros(1,t);
run_time=zeros(1,t);

for q=1:6                                             % prezenting י"ד at figure 
%      for w=1:t                                     % for יא יב יג 
%          for s=1:1                                   %s=1:2 for י"ד
%          delta=D(w);
delta =0.1*10^-3;
H=[0 0 1 2 4 8]*delta; 
M=(h_out/delta)+1;                                   %number of rows
N=(w_out/delta)+1;                                   %number of columbs
c0_p=10;
c1_p=1;
c2_p=2;
a=(w_out-2*w_in-d_in)/2;                              %the space distande on the sides
b=(h_out-w_in)/2;                                     %the space distande on the upper and lower part
j_c1L=floor(a/delta);                                 %the index thats represent the left boundary of c1
j_c1R=floor((a+w_in)/delta);                          %rigt boundary of c1
if(j_c1R*delta ~= a+w_in)                             %if the index is left to c1R,
    j_c1R=j_c1R+1;                                    %we need the index to the right
end
j_c2L=floor((a+w_in+d_in)/delta); 
j_c2R=floor((a+w_in+d_in+w_in)/delta);
if(j_c2R*delta ~= a+w_in) 
    j_c2R=j_c2R+1;
end
i_c1D=floor((b-H(q))/delta); 
i_c1U=floor((b+w_in-H(q))/delta);
if(i_c1U*delta ~= b+w_in-H(q)) 
    i_c1U=i_c1U+1;
end
if q==2
    shloop=0;
end
i_c2D=floor((b+H(q)+shloop)/delta); 
i_c2U=floor((b+w_in+H(q)+shloop)/delta);
if(i_c2U*delta ~= b+w_in+H(q)) 
    i_c2U=i_c2U+1;
end
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
rounds=0;
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
run_time=toc;
reshape(P,[M,N]);
imagesc(P);
ax = gca;
ax.YDir = 'normal';
colorbar;
axis image;
xlabel('x-axis', 'FontSize', axisFontSize);
ylabel('y-axis', 'FontSize', axisFontSize);
title('potential','FontSize', axisFontSize);
figure;
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
for j=j_c1L-1:j_c1R+1            % gamma calculation
    gamma=gamma + ( e_modal(i_c1D-1,j,2)+e_modal(i_c1U+1,j,2))*delta; %summing the y'th coordinates of e at the upper and lower part of c1
end
for i=i_c1D-1:i_c1U+1
    gamma=gamma + (e_modal(i,j_c1L-1,1)+e_modal(i,j_c1R-1,1) )*delta; %summing the  x'th coordinates of e at the left and right parts of c1
end
% G(w)=gamma;                      %  for  י"א, י"ב
 if q==2                          % for י"ד
     gamma_1=gamma;
 end
 if q==1
     gamma_2=gamma;
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
[x,y]=meshgrid(1:N,1:M);
quiver(x,y,e_modal(:,:,1),e_modal(:,:,2));
ylim([0 40]);
xlabel('x-axis', 'FontSize', axisFontSize);
ylabel('y-axis', 'FontSize', axisFontSize);
title('electric modal','FontSize', axisFontSize);
figure
quiver(x,y,h_modal(:,:,1),h_modal(:,:,2));
ylim([0 40]);
xlabel('x-axis', 'FontSize', axisFontSize);
ylabel('y-axis', 'FontSize', axisFontSize);
title('magnetic modal','FontSize', axisFontSize);

end  %   the end of fields calculation
         
% for i=1:t                                  
%     err(i)=abs(G(i)-G(t))/abs(G(t));
% end
% loglog(err,G)
% xlabel('delta', 'FontSize', axisFontSize);
% ylabel('err', 'FontSize', axisFontSize);
% title('relative error for delta','FontSize', axisFontSize);
% figure;
% loglog(run_time,G) 
% xlabel('delta', 'FontSize', axisFontSize);
% ylabel('run_time', 'FontSize', axisFontSize);
% title('run_time for delta','FontSize', axisFontSize);
% figure;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
L1=miu_1/gamma_1;
C1=epsilon_1*gamma_1;
Zc1=sqrt(L1/C1);
velocity_1=1/sqrt(L1*C1);
L2=miu_2/gamma_2;
C2=epsilon_2*gamma_2;
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
           
        
            
            
            
            