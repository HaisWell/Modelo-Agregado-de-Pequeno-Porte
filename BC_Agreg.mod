var 
DLA_CPI
DLA_CPI_LIVRES
DLA_CPI_C
D4L_CPI_LIVRES
D_E_D4L_CPI
E_D4L_CPI
HIATO
DLA_GDP
D4L_GDP
D4L_GDP_BAR
G
STANCE
JURO_NOMINAL
JURO_NEUTRO
E_JURO_NOMINAL
E1_JURO_NOMINAL
E2_JURO_NOMINAL
E3_JURO_NOMINAL
E4_JURO_NOMINAL
JURO_REAL
Z
DLA_CAMBIO
D4L_CAMBIO
CAMBIO_PPC
DIFF_JURO
DLA_COMM_USD
DLA_COMM_BRL
D4L_COMM_ENERGIA
D_DLA_CAMBIO
UNR
UNR_BAR
UNR_GAP
CAPU
CAPU_BAR
CAPU_GAP   
E4_D4L_CPI
PREM
D_DLA_COMM_BRL
PIB_GAP
CAGED_GAP
META
CDS
FEDFUNDS
DLA_COMM_METAL
DLA_COMM_AGRO
DLA_COMM_ENERGY
INCERTEZA
DUM_LANINA
DUM_ELNINO
W_CPI_C
W_CPI_LIVRES
DUM_ENERGIA
D4L_CPI_C;





varexo 
RES_Z
RES_UNR_GAP
RES_CAPU_GAP
RES_G
RES_DLA_CAMBIO
RES_E_D4L_CPI
RES_DLA_CPI_LIVRES
RES_E_JURO_NOMINAL
RES_JURO_NOMINAL
RES_HIATO
RES_CAGED_GAP
RES_PIB_GAP
RES_CDS
RES_FEDFUNDS
RES_INCERTEZA
RES_META
RES_DLA_COMM_METAL
RES_DLA_COMM_AGRO
RES_DLA_COMM_ENERGY
RES_DUM_LANINA
RES_DUM_ELNINO
RES_W_CPI_C
RES_DUM_ENERGIA
RES_DLA_CPI_C;




parameters 
alpha1l
alpha2
alpha3
alpha4
alpha5
alpha6
alphac1
alphac2
alphac3
alphac4
sigma1
sigma2
sigma3
beta1
beta2
beta4
teta1
teta2
teta3
phi1
phi2
phi3
phi4
phi5
gaps_devpad
tau
ss_G
deltadiff
kappa1
kappa2
kappa3;


alpha1l = 0.23;
alpha2 = 0.02;
alpha3 = 0.02;
alpha4 = 0.4;
alpha5 = 0.4;
alpha6 = 0.4;
alphac1 = 0.6408;
alphac2 = 0.0278;
alphac3 = 0.0027;
alphac4 = 19.8767;
sigma1 = 0.1966;
sigma2 = 0.1702;
sigma3 = 0.2875;
beta1 = 0.8;
beta2 = 0.2;
beta4 = 0.05;
teta1 = 1.49;
teta2 = -0.59;
teta3 = 1.78;
phi1 = 0.72;
phi2 = 0.13;
phi3 = 0.04;
phi4 = 0.003;
phi5 = 0.024;
tau = 0.1;
ss_G = 1.5;
deltadiff = 6;
kappa1 = 1.08; 
kappa2 = 1.168; 
kappa3 = 0.77; 
gaps_devpad = 1.2;





model;
DLA_CPI = ((W_CPI_LIVRES*DLA_CPI_LIVRES) + (W_CPI_C*DLA_CPI_C))/(W_CPI_LIVRES + W_CPI_C);

DLA_CPI_LIVRES = alpha1l*DLA_CPI_LIVRES(-1) + (1-alpha1l)*E_D4L_CPI + alpha2*D_DLA_COMM_BRL + alpha3*(D_DLA_CAMBIO(-2)/4) + alpha4*HIATO + ((alpha5*DUM_ELNINO + alpha6*DUM_LANINA) + (alpha5*DUM_ELNINO(-1) + alpha6*DUM_LANINA(-1)) + (alpha5*DUM_ELNINO(-2) + alpha6*DUM_LANINA(-2)))/3 - ((alpha5*DUM_ELNINO(-3) + alpha6*DUM_LANINA(-3)) + (alpha5*DUM_ELNINO(-4) + alpha6*DUM_LANINA(-4)) + (alpha5*DUM_ELNINO(-5) + alpha6*DUM_LANINA(-5)))/3 + RES_DLA_CPI_LIVRES;
D4L_CPI_LIVRES = (DLA_CPI_LIVRES + DLA_CPI_LIVRES(-1) + DLA_CPI_LIVRES(-2) + DLA_CPI_LIVRES(-3))/4;
D_E_D4L_CPI = phi1*D_E_D4L_CPI(-1) + phi2*(D4L_CPI_LIVRES(+4) - META(+4)) + phi3*(D4L_CPI_LIVRES(-1) - META(-1)) + phi4*(DLA_CAMBIO - CAMBIO_PPC) + phi5*HIATO + RES_E_D4L_CPI;
E4_D4L_CPI = D4L_CPI_LIVRES(+4);
E_D4L_CPI = D_E_D4L_CPI + META;
META = META(-1) + RES_META;

DUM_ELNINO = DUM_ELNINO(-1) + RES_DUM_ELNINO;
DUM_LANINA = DUM_LANINA(-1) + RES_DUM_LANINA;

W_CPI_C = W_CPI_C(-1)*(1+DLA_CPI_C(-1)/400)/(1+((W_CPI_LIVRES(-1)*DLA_CPI_LIVRES(-1)) + (W_CPI_C(-1)*DLA_CPI_C(-1)))/(W_CPI_LIVRES(-1) + W_CPI_C(-1))/400) + RES_W_CPI_C;
W_CPI_LIVRES = 1 - W_CPI_C;

DLA_CPI_C = alphac1*DLA_CPI(-1) + (1-alphac1)*E_D4L_CPI + alphac2*D_DLA_COMM_BRL + alphac3*D_DLA_COMM_BRL(-1) + alphac4*DUM_ENERGIA + RES_DLA_CPI_C;
D4L_CPI_C = (DLA_CPI_C + DLA_CPI_C(-1) + DLA_CPI_C(-2) + DLA_CPI_C(-3))/4;
DUM_ENERGIA = 0 + RES_DUM_ENERGIA;

%Atividade-----------------------------------------------------------------
HIATO = beta1*HIATO(-1) - beta2*STANCE(-1) - beta4*INCERTEZA + RES_HIATO;
D4L_GDP_BAR = (G + G(-1) + G(-2) + G(-3))/4;
D4L_GDP     = (DLA_GDP + DLA_GDP(-1) + DLA_GDP(-2) + DLA_GDP(-3))/4;
HIATO = HIATO(-1) + DLA_GDP/4 - G/4;
G = (1-tau)*G(-1) + tau*ss_G + RES_G;
INCERTEZA = 0.8*INCERTEZA(-1) + RES_INCERTEZA;






%Taylor Rule-----------------------------------------------------------------
JURO_NOMINAL = teta1*JURO_NOMINAL(-1) + teta2*JURO_NOMINAL(-2) + (1-teta1-teta2)*(JURO_NEUTRO + META + teta3*(E_D4L_CPI - META)) + RES_JURO_NOMINAL;
E_JURO_NOMINAL = (JURO_NOMINAL*0.5 + E1_JURO_NOMINAL + E2_JURO_NOMINAL + E3_JURO_NOMINAL + E4_JURO_NOMINAL*0.5)/4 + RES_E_JURO_NOMINAL;
STANCE = E_JURO_NOMINAL - E_D4L_CPI - JURO_NEUTRO;
JURO_REAL = E_JURO_NOMINAL - E_D4L_CPI;
JURO_NEUTRO =  Z;
Z = Z(-1) + RES_Z;
PREM = CDS/100 + FEDFUNDS;
E1_JURO_NOMINAL = JURO_NOMINAL(+1);
E2_JURO_NOMINAL = JURO_NOMINAL(+2);
E3_JURO_NOMINAL = JURO_NOMINAL(+3);
E4_JURO_NOMINAL = JURO_NOMINAL(+4);





%Setor Externo
DLA_CAMBIO = CAMBIO_PPC - deltadiff*(DIFF_JURO - DIFF_JURO(-1)) + RES_DLA_CAMBIO;
D_DLA_CAMBIO = DLA_CAMBIO - CAMBIO_PPC;
CAMBIO_PPC = META - 2;
D4L_CAMBIO = (DLA_CAMBIO + DLA_CAMBIO(-1) + DLA_CAMBIO(-2) + DLA_CAMBIO(-3))/4;
DIFF_JURO = JURO_NOMINAL - (FEDFUNDS + CDS/100);
CDS = CDS(-1) + RES_CDS;
FEDFUNDS = FEDFUNDS(-1) + RES_FEDFUNDS;


%Commodities
DLA_COMM_USD = DLA_COMM_METAL*0.17 + DLA_COMM_AGRO*0.68 + DLA_COMM_ENERGY*0.14;
DLA_COMM_BRL = DLA_COMM_USD + DLA_CAMBIO;
D_DLA_COMM_BRL = DLA_COMM_BRL - CAMBIO_PPC;
DLA_COMM_METAL = sigma1*DLA_COMM_METAL(-1) + RES_DLA_COMM_METAL;
DLA_COMM_AGRO = sigma2*DLA_COMM_AGRO(-1) + RES_DLA_COMM_AGRO;
DLA_COMM_ENERGY = sigma3*DLA_COMM_ENERGY(-1) + RES_DLA_COMM_ENERGY;
D4L_COMM_ENERGIA = (DLA_COMM_ENERGY + DLA_COMM_ENERGY(-1) + DLA_COMM_ENERGY(-2) + DLA_COMM_ENERGY(-3))/4;









% Information Equations ------------------------------------------------------------
UNR_GAP = kappa1*(HIATO(-1) + gaps_devpad*RES_UNR_GAP);
UNR_BAR = 10.17;
UNR_GAP = 10.17 - UNR;
CAPU_GAP = kappa2*(HIATO + gaps_devpad*RES_CAPU_GAP);
CAPU_BAR = 80.82;
CAPU = CAPU_BAR + CAPU_GAP;
CAGED_GAP = kappa3*(HIATO(-1) + gaps_devpad*RES_CAGED_GAP);
PIB_GAP = HIATO + gaps_devpad*RES_PIB_GAP;




end;



shocks; 
var RES_Z;  stderr 0.1; 
var RES_UNR_GAP;  stderr 1;
var RES_CAPU_GAP;  stderr 1;
var RES_G;  stderr 3.7;
var RES_DLA_CAMBIO;  stderr 26;
var RES_E_D4L_CPI;  stderr 0.21;
var RES_DLA_CPI_LIVRES;  stderr 1.9;
var RES_DLA_CPI_C;  stderr 3.83;
var RES_E_JURO_NOMINAL;  stderr 0.46;
var RES_JURO_NOMINAL;  stderr 0.49;
var RES_HIATO;  stderr 0.25;
var RES_CAGED_GAP;  stderr 1;
var RES_PIB_GAP;  stderr 1;
var RES_CDS;  stderr 1;
var RES_FEDFUNDS;  stderr 1;
var RES_META;  stderr 1;
var RES_DLA_COMM_METAL;  stderr 20;
var RES_DLA_COMM_AGRO;  stderr 20;
var RES_DLA_COMM_ENERGY;  stderr 20;
var RES_INCERTEZA;  stderr 7;
var RES_DUM_ELNINO;  stderr 1;
var RES_DUM_LANINA;  stderr 1;
var RES_DUM_ENERGIA;  stderr 1;
var RES_W_CPI_C;  stderr 0.003;
end;

varobs
E_D4L_CPI
DLA_CAMBIO
JURO_NOMINAL
E_JURO_NOMINAL
META
CDS
FEDFUNDS
DLA_GDP
CAPU
UNR
DLA_CPI_LIVRES
DLA_CPI_C
W_CPI_C
DLA_COMM_METAL
DLA_COMM_AGRO
DLA_COMM_ENERGY
CAGED_GAP
PIB_GAP
DUM_LANINA
DUM_ELNINO
DUM_ENERGIA
INCERTEZA;




initval;
META = 3;
DLA_CPI = META;
DLA_CPI_LIVRES = META;
DLA_CPI_C = META;
W_CPI_C = 1/4;
W_CPI_LIVRES = 3/4;
D4L_CPI_LIVRES = META;
D4L_CPI_C = META;
D_E_D4L_CPI = 0;
E_D4L_CPI = META;
E4_D4L_CPI = META;
DLA_CAMBIO = META - 2;
D4L_CAMBIO = META - 2;
CAMBIO_PPC = META - 2;
CDS = 200;
Z = 0;
FEDFUNDS = 2;
STANCE = 0;
JURO_NEUTRO = 0;
JURO_NOMINAL = META + JURO_NEUTRO;
E_JURO_NOMINAL = JURO_NOMINAL;
E1_JURO_NOMINAL = JURO_NOMINAL;
E2_JURO_NOMINAL = JURO_NOMINAL;
E3_JURO_NOMINAL = JURO_NOMINAL;
E4_JURO_NOMINAL = JURO_NOMINAL;
DIFF_JURO = JURO_NOMINAL - (FEDFUNDS + CDS/100);
INCERTEZA = 0;
D4L_GDP_BAR = ss_G;
G = ss_G;
HIATO = 0;
DLA_GDP = ss_G;
D4L_GDP = ss_G;
UNR = 10.17;
UNR_GAP = 0;
UNR_BAR = 10.17;
CAPU = 80.82;
CAPU_GAP = 0;
CAPU_BAR = 80.82;
JURO_REAL = JURO_NEUTRO;
CAGED_GAP = 0;
PIB_GAP = 0;
DLA_COMM_METAL = 0;
DLA_COMM_AGRO = 0;
DLA_COMM_ENERGY = 0;
D4L_COMM_ENERGIA = 0;
DLA_COMM_USD = DLA_COMM_METAL*0.17 + DLA_COMM_AGRO*0.68 + DLA_COMM_ENERGY*0.14;
DLA_COMM_BRL = DLA_COMM_USD + DLA_CAMBIO;
D_DLA_COMM_BRL = DLA_COMM_BRL - CAMBIO_PPC;
PREM = 4;
end;

steady; 



estimated_params;
alpha1l, 0.23,    uniform_pdf, , ,      0.01, 0.95;
alpha2, 0.02,    uniform_pdf, , ,      0.01, 0.95;
alpha3, 0.02,    uniform_pdf, , ,      0.01, 0.95;
alpha4, 0.4,    uniform_pdf, , ,      0, 2;
alpha5, 0.4,    uniform_pdf, , ,      0, 2;
alpha6, 0.4,    uniform_pdf, , ,      0, 2;
stderr RES_E_D4L_CPI, 0.21, uniform_pdf, , ,      0, 3;
stderr RES_DLA_CPI_LIVRES, 1.9, uniform_pdf, , ,      0, 5;


beta1, 0.7,    uniform_pdf, , ,      0.01, 0.95;
beta2, 0.2,    uniform_pdf, , ,      0.01, 0.95;
beta4, 0.05,    beta_pdf,      0.05, 0.005;
tau, 0.1,    normal_pdf,      0.1, 0.5;
stderr RES_HIATO, 0.7, uniform_pdf, , ,      0.01, 1;
stderr RES_G, 2.7, uniform_pdf, , ,      0, 10;
stderr RES_INCERTEZA, 10, uniform_pdf, , ,      0.01, 20;

teta1, 1.5,    uniform_pdf, , ,      0, 2;
teta2, -0.6,    uniform_pdf, , ,      -1, 1;
teta3, 2.5,    uniform_pdf, , ,      0, 8;
stderr RES_JURO_NOMINAL, 0.6, uniform_pdf, , ,      0.01, 3;
stderr RES_E_JURO_NOMINAL, 0.6, uniform_pdf, , ,      0.01, 3;
stderr RES_Z, inv_gamma_pdf, 0.1  , 0.01;


phi1, 0.72,    uniform_pdf, , ,      0.01, 0.95;
phi2, 0.13,    uniform_pdf, , ,      0, 1;
phi3, 0.1,    uniform_pdf, , ,      -1, 1;
phi4, 0,    uniform_pdf, , ,      -0.1, 0.1;
phi5, 0.1,    uniform_pdf, , ,      -1, 1;



deltadiff, 6,    uniform_pdf, , ,      0, 10;

gaps_devpad, 1.2,    uniform_pdf, , ,      0, 2;
kappa1, 1,    uniform_pdf, , ,      0, 3;
kappa2, 2,    uniform_pdf, , ,      0, 3;
kappa3, 0.77,    uniform_pdf, , ,      0, 3;

sigma1, 0.1,    uniform_pdf, , ,      0, 1;
sigma2, 0.1,    uniform_pdf, , ,      0, 1;
sigma3, 0.1,    uniform_pdf, , ,      0, 1;



stderr RES_DLA_CAMBIO, 27, uniform_pdf, , ,      0, 35;



stderr RES_CDS, 66, uniform_pdf, , ,      0, 100;
stderr RES_FEDFUNDS, 4, uniform_pdf, , ,      0, 40;
stderr RES_META, 0.12, uniform_pdf, , ,      0, 1;
stderr RES_DLA_COMM_METAL, 36, uniform_pdf, , ,      0, 100;
stderr RES_DLA_COMM_AGRO, 25, uniform_pdf, , ,      0, 100;
stderr RES_DLA_COMM_ENERGY, 43, uniform_pdf, , ,      0, 100;
//stderr RES_DUM_LANINA, 0.7, uniform_pdf, , ,      0, 1;
//stderr RES_DUM_ELNINO, 0.7, uniform_pdf, , ,      0, 1;


end;


options_.filter_covariance = 1;
options_.filter_decomposition = 1;


%Primeira Linha realiza a estimação do modelo considerando a prior dada.
%Segunda linha apenas carrega a ultima estimação realizada.
//estimation(datafile=data_file, mode_compute=1, nograph,  mh_replic=0, filtered_vars,filter_step_ahead=[1:12], forecast=16,conf_sig=0.70, first_obs=1, nobs=64,diffuse_filter,smoothed_state_uncertainty) 
estimation(datafile=data_file, mode_compute=0, mode_file='BC_Agreg\Output\BC_Agreg_mode.mat', nograph,  mh_replic=0, filtered_vars,filter_step_ahead=[1:12], forecast=16, conf_sig=0.70, diffuse_filter, smoothed_state_uncertainty) 
STANCE JURO_NOMINAL HIATO JURO_NEUTRO DLA_CPI_LIVRES;



firstdate = '2004Q1'; 
Years = floor((dataset_.dates.time-1) / 4)+2004;
Quarters = rem((dataset_.dates.time-1), 4) + 1;
Months = Quarters * 3;
ProperDates = datetime(Years, Months, 1);
ProperDates.Format = 'QQQ-yyyy';
datas = ProperDates;


a = plot_band("HIATO", datas);
shg







%%to make more dynamic for report
data_file;
nobs = 92;

%%gl_report
%%canada_report_extra__US

%% set firstdate
firstdate = '2004Q1'; 

%% set in-sample ahead forecast steps
fcast_steps = [1 4 8 12];

%% calculate the forecasts
max_step = max(fcast_steps);



[fy,fx,Fy,Fx,Udecomp,ndiffuse] = calc_fcast_all_4a;
//[fy,fx,Fy,Fx,Udecomp,ndiffuse] = calc_fcast_all(max_step);
%% save the forecasts
save([M_.dname '_forecasts.mat'], 'fy', 'fx', 'Fy', 'Fx', 'Udecomp', 'ndiffuse');




//disp(sprintf('\n'));disp('Reporting forecast errors');
//report_fcast_errors(fy, Fy, ndiffuse, fcast_steps, firstdate);
//report_smoothed_errors_4(fx, Fx, ndiffuse, strvcat('D4L_CPI'), fcast_steps, firstdate);


exo_ord = [1 4 2 5 3 6 7 8 9 10];
disp('Reporting dynamic forecasts 1 period ahead');
in_sample_forecast(fx, Fx, Udecomp, ndiffuse, 1, 12, exo_ord, firstdate,var_list_);





