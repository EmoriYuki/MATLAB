%透磁率
m=4*pi*10^(-7);

%運転電流I[A]
I=110;

%メインコイルの諸元(入力内容)
z1m=10;%中心からの距離[mm]
N1m=104;%層数[mm]
N2m=28;%段数
a1m=70;%内半径[mm]

%メインコイルの諸元(自動出力)
Nm=N1m*N2m;%総巻き数
xm=0.2*N1m;%層長さ[mm]
ym=4*N2m;%段長さ[mm]
z2m=z1m+xm;%[mm]
a2m=a1m+xm;%外半径[mm]
bm=ym/2;%コイルの長さの半分[mm]
Jm=(Nm*I)/(xm*ym*10^(-6));%電流密度[A/m]
am=(a2m)/(a1m);%α
amm=am*ones(1,401);

%キャンセルコイルの諸元(入力内容)
z1c=10;%中心からの距離[mm]
N1c=104;%層数[mm]
N2c=28;%段数
a1c=70;%内半径[mm]

%キャンセルコイルの諸元(自動出力)
Nc=N1c*N2c;%総巻き数
xc=0.2*N1c;%層長さ[mm]
yc=4*N2c;%段長さ[mm]
z2c=z1c+xc;%[mm]
a2c=a1c+xc;%外半径[mm]
bc=yc/2;%コイルの長さの半分[mm]
Jc=(Nc*I)/(xc*yc*10^(-6));%電流密度[A/m]
ac=(a2c)/(a1c);%α
acc=ac*ones(1,401);

%位置z [mm]
z=-200:200;

%メインコイルの磁場計算
A=ones(1,401);
b1m=(z1m-z)/a1m;%β1
b2m=(z1m+z)/a1m;%β2
b3m=(z2m-z)/a1m;%β3
b4m=(z2m+z)/a1m;%β4
F1m=(m*b3m*10^(-3)*(asinh(amm./b3m)+asinh(A./b3m)))+(m*b4m*10^(-3)*(asinh(amm./b4m)+asinh(A./b4m)));
F2m=(m*b1m*10^(-3)*(asinh(amm./b1m)+asinh(A./b1m)))+(m*b2m*10^(-3)*(asinh(amm./b2m)+asinh(A./b2m)));
Bm=(1/2)*Jm*a1m*10^(-3)*(F1m-F2m);

%キャンセルコイルの磁場計算
b1c=(z1c-z)/a1c;%β1
b2c=(z1c+z)/a1c;%β2
b3c=(z2c-z)/a1c;%β3
b4c=(z2c+z)/a1c;%β4
F1c=(4*pi*10^(-7)*b3c*10^(-3)*(asinh(acc./b3c)+asinh(1/b3c)))+(4*pi*10^(-7)*b4c*10^(-3)*(asinh(acc./b4c)+asinh(1/b4c)));
F2c=(4*pi*10^(-7)*b1c*10^(-3)*(asinh(acc./b1c)+asinh(1/b1c)))+(4*pi*10^(-7)*b2c*10^(-3)*(asinh(acc./b2c)+asinh(1/b2c)));
Bc=(1/2)*Jc*a1c*10^(-3)*(F1c-F2c);

%全体の磁場計算
B=Bm-Bc;

%グラフへの描写
yyaxis left;
plot(z,B);
xlabel('位置z [mm]');
ylabel('磁場B [T]');


