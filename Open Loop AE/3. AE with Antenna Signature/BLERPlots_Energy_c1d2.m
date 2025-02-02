k = 3;    % number of input bits
M = 2^k;  % number of possible input symbols
n = 2;    % number of channel uses
c = 1;    % No of antenna selection bits
d = k-c;  % No of data bits
M_d = 2^d;% number of possible input symbols
Nt = 2^c; % number of transmit antennas

% Simulate the block error rate (BLER) performance
simParams.EbNoVec = 0:0.5:40;
simParams.MinNumErrors = 10;
simParams.MaxNumFrames = 300;
simParams.NumSymbolsPerFrame = 10000;
simParams.SignalPower = 1;

EbNoVec = simParams.EbNoVec;
R = k/n;

M = 2^k;

%******************** Rician Factor = 3 ***********************************
% Get BLER for different saved models
file_rician3_c1d2_EbNo7_batch128_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch128_encoder1.mat');
file_rician3_c1d2_EbNo7_batch512_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch512_encoder1.mat');
file_rician3_c1d2_EbNo7_batch1024_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch1024_encoder1.mat');

file_rician3_c1d2_EbNo7_batch128_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch128_encoder2.mat');
file_rician3_c1d2_EbNo7_batch512_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch512_encoder2.mat');
file_rician3_c1d2_EbNo7_batch1024_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch1024_encoder2.mat');

file_rician3_c1d2_EbNo15_batch128_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo15_batch128_encoder1.mat');
file_rician3_c1d2_EbNo15_batch512_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo15_batch512_encoder1.mat');
file_rician3_c1d2_EbNo15_batch1024_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo15_batch1024_encoder1.mat');

file_rician3_c1d2_EbNo15_batch128_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo15_batch128_encoder2.mat');
file_rician3_c1d2_EbNo15_batch512_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo15_batch512_encoder2.mat');
file_rician3_c1d2_EbNo15_batch1024_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo15_batch1024_encoder2.mat');

% Baselines
file_psk_rician3_c1d2 = matfile('Results/psk_rician3_c1d2.mat');
file_qam_rician3_c1d2 = matfile('Results/qam_rician3_c1d2.mat');

BLER_rician3_c1d2_EbNo7_batch128_encoder1 = file_rician3_c1d2_EbNo7_batch128_encoder1.BLER;
BLER_rician3_c1d2_EbNo7_batch512_encoder1 = file_rician3_c1d2_EbNo7_batch512_encoder1.BLER;
BLER_rician3_c1d2_EbNo7_batch1024_encoder1 = file_rician3_c1d2_EbNo7_batch1024_encoder1.BLER;

BLER_rician3_c1d2_EbNo7_batch128_encoder2 = file_rician3_c1d2_EbNo7_batch128_encoder2.BLER;
BLER_rician3_c1d2_EbNo7_batch512_encoder2 = file_rician3_c1d2_EbNo7_batch512_encoder2.BLER;
BLER_rician3_c1d2_EbNo7_batch1024_encoder2 = file_rician3_c1d2_EbNo7_batch1024_encoder2.BLER;

BLER_rician3_c1d2_EbNo15_batch128_encoder1 = file_rician3_c1d2_EbNo15_batch128_encoder1.BLER;
BLER_rician3_c1d2_EbNo15_batch512_encoder1 = file_rician3_c1d2_EbNo15_batch512_encoder1.BLER;
BLER_rician3_c1d2_EbNo15_batch1024_encoder1 = file_rician3_c1d2_EbNo15_batch1024_encoder1.BLER;

BLER_rician3_c1d2_EbNo15_batch128_encoder2 = file_rician3_c1d2_EbNo15_batch128_encoder2.BLER;
BLER_rician3_c1d2_EbNo15_batch512_encoder2 = file_rician3_c1d2_EbNo15_batch512_encoder2.BLER;
BLER_rician3_c1d2_EbNo15_batch1024_encoder2 = file_rician3_c1d2_EbNo15_batch1024_encoder2.BLER;

BLER_psk_rician3_c1d2 = file_psk_rician3_c1d2.BLER_psk;
BLER_qam_rician3_c1d2 = file_qam_rician3_c1d2.BLER_qam;


figure
y_min = 10^(-6);
BLER_rician3_c1d2_EbNo7_batch128_encoder1(BLER_rician3_c1d2_EbNo7_batch128_encoder1==0)=y_min/10;
BLER_rician3_c1d2_EbNo7_batch512_encoder1(BLER_rician3_c1d2_EbNo7_batch512_encoder1==0)=y_min/10;
BLER_rician3_c1d2_EbNo7_batch1024_encoder1(BLER_rician3_c1d2_EbNo7_batch1024_encoder1==0)=y_min/10;

BLER_rician3_c1d2_EbNo7_batch128_encoder2(BLER_rician3_c1d2_EbNo7_batch128_encoder2==0)=y_min/10;
BLER_rician3_c1d2_EbNo7_batch512_encoder2(BLER_rician3_c1d2_EbNo7_batch512_encoder2==0)=y_min/10;
BLER_rician3_c1d2_EbNo7_batch1024_encoder2(BLER_rician3_c1d2_EbNo7_batch1024_encoder2==0)=y_min/10;

BLER_rician3_c1d2_EbNo15_batch128_encoder1(BLER_rician3_c1d2_EbNo15_batch128_encoder1==0)=y_min/10;
BLER_rician3_c1d2_EbNo15_batch512_encoder1(BLER_rician3_c1d2_EbNo15_batch512_encoder1==0)=y_min/10;
BLER_rician3_c1d2_EbNo15_batch1024_encoder1(BLER_rician3_c1d2_EbNo15_batch1024_encoder1==0)=y_min/10;

BLER_rician3_c1d2_EbNo15_batch128_encoder2(BLER_rician3_c1d2_EbNo15_batch128_encoder2==0)=y_min/10;
BLER_rician3_c1d2_EbNo15_batch512_encoder2(BLER_rician3_c1d2_EbNo15_batch512_encoder2==0)=y_min/10;
BLER_rician3_c1d2_EbNo15_batch1024_encoder2(BLER_rician3_c1d2_EbNo15_batch1024_encoder2==0)=y_min/10;

BLER_psk_rician3_c1d2(BLER_psk_rician3_c1d2==0)=y_min/10;
BLER_qam_rician3_c1d2(BLER_qam_rician3_c1d2==0)=y_min/10;


semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch128_encoder1,'-','linewidth',1,'color','#0072BD')
hold on
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch512_encoder1,'-','linewidth',1,'color','#D95319')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch1024_encoder1,'-','linewidth',1,'color','#EDB120')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch128_encoder2,'-','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch512_encoder2,'-','linewidth',1,'color','#77AC30')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch1024_encoder2,'-','linewidth',1,'color','#4DBEEE')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo15_batch128_encoder1,'-*','linewidth',1,'color','#0072BD')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo15_batch512_encoder1,'-*','linewidth',1,'color','#D95319')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo15_batch1024_encoder1,'-*','linewidth',1,'color','#EDB120')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo15_batch128_encoder2,'-*','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo15_batch512_encoder2,'-*','linewidth',1,'color','#77AC30')
semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo15_batch1024_encoder2,'-*','linewidth',1,'color','#4DBEEE')
semilogy(simParams.EbNoVec,BLER_psk_rician3_c1d2,'--','linewidth',1,'color','#000000')
%semilogy(simParams.EbNoVec,BLER_qam_rician3_c1d2,'--','linewidth',1,'color','#FF00FF')
hold off
ylim([y_min 1])
grid on
set(gca,'FontName','Times New Roman','fontsize', 12)
xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
title("AE with Antenna Signature with Energy Norm for Rician Factor = 3, c = 1 and d = 2")
legend("Eb/No = 7, enc(64), dec(64,64), Batch = 128", ...
"Eb/No = 7, enc(64), dec(64,64), Batch = 512", ...
"Eb/No = 7, enc(64), dec(64,64), Batch = 1024", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 128", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 512", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 1024", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 128", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 512", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 1024", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 128", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 512", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 1024", ...
"Baseline SM PSK MLD", ..."Baseline SM QAM MLD", ...
'FontName','Times New Roman','FontSize',12,'Location','southwest')


%******************** Rician Factor = 10 ***********************************
% Get BLER for different saved models
file_rician10_c1d2_EbNo7_batch128_encoder1 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch128_encoder1.mat');
file_rician10_c1d2_EbNo7_batch512_encoder1 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch512_encoder1.mat');
file_rician10_c1d2_EbNo7_batch1024_encoder1 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch1024_encoder1.mat');

file_rician10_c1d2_EbNo7_batch128_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch128_encoder2.mat');
file_rician10_c1d2_EbNo7_batch512_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch512_encoder2.mat');
file_rician10_c1d2_EbNo7_batch1024_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch1024_encoder2.mat');

file_rician10_c1d2_EbNo15_batch128_encoder1 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch128_encoder1.mat');
file_rician10_c1d2_EbNo15_batch512_encoder1 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch512_encoder1.mat');
file_rician10_c1d2_EbNo15_batch1024_encoder1 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch1024_encoder1.mat');

file_rician10_c1d2_EbNo15_batch128_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch128_encoder2.mat');
file_rician10_c1d2_EbNo15_batch512_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch512_encoder2.mat');
file_rician10_c1d2_EbNo15_batch1024_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch1024_encoder2.mat');

% Baselines
file_psk_rician10_c1d2 = matfile('Results/psk_rician10_c1d2.mat');
file_qam_rician10_c1d2 = matfile('Results/qam_rician10_c1d2.mat');

BLER_rician10_c1d2_EbNo7_batch128_encoder1 = file_rician10_c1d2_EbNo7_batch128_encoder1.BLER;
BLER_rician10_c1d2_EbNo7_batch512_encoder1 = file_rician10_c1d2_EbNo7_batch512_encoder1.BLER;
BLER_rician10_c1d2_EbNo7_batch1024_encoder1 = file_rician10_c1d2_EbNo7_batch1024_encoder1.BLER;

BLER_rician10_c1d2_EbNo7_batch128_encoder2 = file_rician10_c1d2_EbNo7_batch128_encoder2.BLER;
BLER_rician10_c1d2_EbNo7_batch512_encoder2 = file_rician10_c1d2_EbNo7_batch512_encoder2.BLER;
BLER_rician10_c1d2_EbNo7_batch1024_encoder2 = file_rician10_c1d2_EbNo7_batch1024_encoder2.BLER;

BLER_rician10_c1d2_EbNo15_batch128_encoder1 = file_rician10_c1d2_EbNo15_batch128_encoder1.BLER;
BLER_rician10_c1d2_EbNo15_batch512_encoder1 = file_rician10_c1d2_EbNo15_batch512_encoder1.BLER;
BLER_rician10_c1d2_EbNo15_batch1024_encoder1 = file_rician10_c1d2_EbNo15_batch1024_encoder1.BLER;

BLER_rician10_c1d2_EbNo15_batch128_encoder2 = file_rician10_c1d2_EbNo15_batch128_encoder2.BLER;
BLER_rician10_c1d2_EbNo15_batch512_encoder2 = file_rician10_c1d2_EbNo15_batch512_encoder2.BLER;
BLER_rician10_c1d2_EbNo15_batch1024_encoder2 = file_rician10_c1d2_EbNo15_batch1024_encoder2.BLER;

BLER_psk_rician10_c1d2 = file_psk_rician10_c1d2.BLER_psk;
BLER_qam_rician10_c1d2 = file_qam_rician10_c1d2.BLER_qam;


figure
y_min = 10^(-6);
BLER_rician10_c1d2_EbNo7_batch128_encoder1(BLER_rician10_c1d2_EbNo7_batch128_encoder1==0)=y_min/10;
BLER_rician10_c1d2_EbNo7_batch512_encoder1(BLER_rician10_c1d2_EbNo7_batch512_encoder1==0)=y_min/10;
BLER_rician10_c1d2_EbNo7_batch1024_encoder1(BLER_rician10_c1d2_EbNo7_batch1024_encoder1==0)=y_min/10;

BLER_rician10_c1d2_EbNo7_batch128_encoder2(BLER_rician10_c1d2_EbNo7_batch128_encoder2==0)=y_min/10;
BLER_rician10_c1d2_EbNo7_batch512_encoder2(BLER_rician10_c1d2_EbNo7_batch512_encoder2==0)=y_min/10;
BLER_rician10_c1d2_EbNo7_batch1024_encoder2(BLER_rician10_c1d2_EbNo7_batch1024_encoder2==0)=y_min/10;

BLER_rician10_c1d2_EbNo15_batch128_encoder1(BLER_rician10_c1d2_EbNo15_batch128_encoder1==0)=y_min/10;
BLER_rician10_c1d2_EbNo15_batch512_encoder1(BLER_rician10_c1d2_EbNo15_batch512_encoder1==0)=y_min/10;
BLER_rician10_c1d2_EbNo15_batch1024_encoder1(BLER_rician10_c1d2_EbNo15_batch1024_encoder1==0)=y_min/10;

BLER_rician10_c1d2_EbNo15_batch128_encoder2(BLER_rician10_c1d2_EbNo15_batch128_encoder2==0)=y_min/10;
BLER_rician10_c1d2_EbNo15_batch512_encoder2(BLER_rician10_c1d2_EbNo15_batch512_encoder2==0)=y_min/10;
BLER_rician10_c1d2_EbNo15_batch1024_encoder2(BLER_rician10_c1d2_EbNo15_batch1024_encoder2==0)=y_min/10;

BLER_psk_rician10_c1d2(BLER_psk_rician10_c1d2==0)=y_min/10;
BLER_qam_rician10_c1d2(BLER_qam_rician10_c1d2==0)=y_min/10;


semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch128_encoder1,'-','linewidth',1,'color','#0072BD')
hold on
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch512_encoder1,'-','linewidth',1,'color','#D95319')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch1024_encoder1,'-','linewidth',1,'color','#EDB120')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch128_encoder2,'-','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch512_encoder2,'-','linewidth',1,'color','#77AC30')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch1024_encoder2,'-','linewidth',1,'color','#4DBEEE')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch128_encoder1,'-*','linewidth',1,'color','#0072BD')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch512_encoder1,'-*','linewidth',1,'color','#D95319')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch1024_encoder1,'-*','linewidth',1,'color','#EDB120')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch128_encoder2,'-*','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch512_encoder2,'-*','linewidth',1,'color','#77AC30')
semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch1024_encoder2,'-*','linewidth',1,'color','#4DBEEE')
semilogy(simParams.EbNoVec,BLER_psk_rician10_c1d2,'--','linewidth',1,'color','#000000')
%semilogy(simParams.EbNoVec,BLER_qam_rician10_c1d2,'--','linewidth',1,'color','#FF00FF')
hold off
ylim([y_min 1])
grid on
set(gca,'FontName','Times New Roman','fontsize', 12)
xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
title("AE with Antenna Signature with Energy Norm for Rician Factor = 10, c = 1 and d = 2")
legend("Eb/No = 7, enc(64), dec(64,64), Batch = 128", ...
"Eb/No = 7, enc(64), dec(64,64), Batch = 512", ...
"Eb/No = 7, enc(64), dec(64,64), Batch = 1024", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 128", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 512", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 1024", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 128", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 512", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 1024", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 128", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 512", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 1024", ...
"Baseline SM PSK MLD", ..."Baseline SM QAM MLD", ...
'FontName','Times New Roman','FontSize',12,'Location','southwest')

%******************** Rician Factor = 20 ***********************************
% Get BLER for different saved models
file_rician20_c1d2_EbNo7_batch128_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo7_batch128_encoder1.mat');
file_rician20_c1d2_EbNo7_batch512_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo7_batch512_encoder1.mat');
file_rician20_c1d2_EbNo7_batch1024_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo7_batch1024_encoder1.mat');

file_rician20_c1d2_EbNo7_batch128_encoder2 = matfile('Results/Energy_rician20_c1d2_EbNo7_batch128_encoder2.mat');
file_rician20_c1d2_EbNo7_batch512_encoder2 = matfile('Results/Energy_rician20_c1d2_EbNo7_batch512_encoder2.mat');
file_rician20_c1d2_EbNo7_batch1024_encoder2 = matfile('Results/Energy_rician20_c1d2_EbNo7_batch1024_encoder2.mat');

file_rician20_c1d2_EbNo15_batch128_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch128_encoder1.mat');
file_rician20_c1d2_EbNo15_batch512_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch512_encoder1.mat');
file_rician20_c1d2_EbNo15_batch1024_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch1024_encoder1.mat');

file_rician20_c1d2_EbNo15_batch128_encoder2 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch128_encoder2.mat');
file_rician20_c1d2_EbNo15_batch512_encoder2 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch512_encoder2.mat');
file_rician20_c1d2_EbNo15_batch1024_encoder2 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch1024_encoder2.mat');

% Baselines
file_psk_rician20_c1d2 = matfile('Results/psk_rician20_c1d2.mat');
file_qam_rician20_c1d2 = matfile('Results/qam_rician20_c1d2.mat');

BLER_rician20_c1d2_EbNo7_batch128_encoder1 = file_rician20_c1d2_EbNo7_batch128_encoder1.BLER;
BLER_rician20_c1d2_EbNo7_batch512_encoder1 = file_rician20_c1d2_EbNo7_batch512_encoder1.BLER;
BLER_rician20_c1d2_EbNo7_batch1024_encoder1 = file_rician20_c1d2_EbNo7_batch1024_encoder1.BLER;

BLER_rician20_c1d2_EbNo7_batch128_encoder2 = file_rician20_c1d2_EbNo7_batch128_encoder2.BLER;
BLER_rician20_c1d2_EbNo7_batch512_encoder2 = file_rician20_c1d2_EbNo7_batch512_encoder2.BLER;
BLER_rician20_c1d2_EbNo7_batch1024_encoder2 = file_rician20_c1d2_EbNo7_batch1024_encoder2.BLER;

BLER_rician20_c1d2_EbNo15_batch128_encoder1 = file_rician20_c1d2_EbNo15_batch128_encoder1.BLER;
BLER_rician20_c1d2_EbNo15_batch512_encoder1 = file_rician20_c1d2_EbNo15_batch512_encoder1.BLER;
BLER_rician20_c1d2_EbNo15_batch1024_encoder1 = file_rician20_c1d2_EbNo15_batch1024_encoder1.BLER;

BLER_rician20_c1d2_EbNo15_batch128_encoder2 = file_rician20_c1d2_EbNo15_batch128_encoder2.BLER;
BLER_rician20_c1d2_EbNo15_batch512_encoder2 = file_rician20_c1d2_EbNo15_batch512_encoder2.BLER;
BLER_rician20_c1d2_EbNo15_batch1024_encoder2 = file_rician20_c1d2_EbNo15_batch1024_encoder2.BLER;

BLER_psk_rician20_c1d2 = file_psk_rician20_c1d2.BLER_psk;
BLER_qam_rician20_c1d2 = file_qam_rician20_c1d2.BLER_qam;


figure
y_min = 10^(-6);
BLER_rician20_c1d2_EbNo7_batch128_encoder1(BLER_rician20_c1d2_EbNo7_batch128_encoder1==0)=y_min/10;
BLER_rician20_c1d2_EbNo7_batch512_encoder1(BLER_rician20_c1d2_EbNo7_batch512_encoder1==0)=y_min/10;
BLER_rician20_c1d2_EbNo7_batch1024_encoder1(BLER_rician20_c1d2_EbNo7_batch1024_encoder1==0)=y_min/10;

BLER_rician20_c1d2_EbNo7_batch128_encoder2(BLER_rician20_c1d2_EbNo7_batch128_encoder2==0)=y_min/10;
BLER_rician20_c1d2_EbNo7_batch512_encoder2(BLER_rician20_c1d2_EbNo7_batch512_encoder2==0)=y_min/10;
BLER_rician20_c1d2_EbNo7_batch1024_encoder2(BLER_rician20_c1d2_EbNo7_batch1024_encoder2==0)=y_min/10;

BLER_rician20_c1d2_EbNo15_batch128_encoder1(BLER_rician20_c1d2_EbNo15_batch128_encoder1==0)=y_min/10;
BLER_rician20_c1d2_EbNo15_batch512_encoder1(BLER_rician20_c1d2_EbNo15_batch512_encoder1==0)=y_min/10;
BLER_rician20_c1d2_EbNo15_batch1024_encoder1(BLER_rician20_c1d2_EbNo15_batch1024_encoder1==0)=y_min/10;

BLER_rician20_c1d2_EbNo15_batch128_encoder2(BLER_rician20_c1d2_EbNo15_batch128_encoder2==0)=y_min/10;
BLER_rician20_c1d2_EbNo15_batch512_encoder2(BLER_rician20_c1d2_EbNo15_batch512_encoder2==0)=y_min/10;
BLER_rician20_c1d2_EbNo15_batch1024_encoder2(BLER_rician20_c1d2_EbNo15_batch1024_encoder2==0)=y_min/10;

BLER_psk_rician20_c1d2(BLER_psk_rician20_c1d2==0)=y_min/10;
BLER_qam_rician20_c1d2(BLER_qam_rician20_c1d2==0)=y_min/10;


semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo7_batch128_encoder1,'-','linewidth',1,'color','#0072BD')
hold on
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo7_batch512_encoder1,'-','linewidth',1,'color','#D95319')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo7_batch1024_encoder1,'-','linewidth',1,'color','#EDB120')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo7_batch128_encoder2,'-','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo7_batch512_encoder2,'-','linewidth',1,'color','#77AC30')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo7_batch1024_encoder2,'-','linewidth',1,'color','#4DBEEE')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch128_encoder1,'-*','linewidth',1,'color','#0072BD')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch512_encoder1,'-*','linewidth',1,'color','#D95319')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch1024_encoder1,'-*','linewidth',1,'color','#EDB120')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch128_encoder2,'-*','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch512_encoder2,'-*','linewidth',1,'color','#77AC30')
semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch1024_encoder2,'-*','linewidth',1,'color','#4DBEEE')
semilogy(simParams.EbNoVec,BLER_psk_rician20_c1d2,'--','linewidth',1,'color','#000000')
%semilogy(simParams.EbNoVec,BLER_qam_rician20_c1d2,'--','linewidth',1,'color','#FF00FF')
hold off
ylim([y_min 1])
grid on
set(gca,'FontName','Times New Roman','fontsize', 12)
xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
title("AE with Antenna Signature with Energy Norm for Rician Factor = 20, c = 1 and d = 2")
legend("Eb/No = 7, enc(64), dec(64,64), Batch = 128", ...
"Eb/No = 7, enc(64), dec(64,64), Batch = 512", ...
"Eb/No = 7, enc(64), dec(64,64), Batch = 1024", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 128", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 512", ...
"Eb/No = 7, enc(64,64), dec(64,64), Batch = 1024", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 128", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 512", ...
"Eb/No = 15, enc(64), dec(64,64), Batch = 1024", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 128", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 512", ...
"Eb/No = 15, enc(64,64), dec(64,64), Batch = 1024", ...
"Baseline SM PSK MLD", ..."Baseline SM QAM MLD", ...
'FontName','Times New Roman','FontSize',12,'Location','southwest')

% %******************** Best models ***********************************
% % Get BLER for different saved best models
% %rician 3
% file_rician3_c1d2_EbNo7_batch512_encoder1 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch512_encoder1.mat');
% file_rician3_c1d2_EbNo7_batch128_encoder2 = matfile('Results/Energy_rician3_c1d2_EbNo7_batch128_encoder2.mat');
% %rician 10
% file_rician10_c1d2_EbNo15_batch128_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo15_batch128_encoder2.mat');
% file_rician10_c1d2_EbNo7_batch128_encoder2 = matfile('Results/Energy_rician10_c1d2_EbNo7_batch128_encoder2.mat');
% %rician 20
% file_rician20_c1d2_EbNo15_batch128_encoder1 = matfile('Results/Energy_rician20_c1d2_EbNo15_batch128_encoder1.mat');
% 
% 
% 
% 
% % Baselines
% file_psk_rician3_c1d2 = matfile('Results/psk_rician3_c1d2.mat');
% file_qam_rician3_c1d2 = matfile('Results/qam_rician3_c1d2.mat');
% 
% 
% 
% figure
% y_min = 10^(-6);
% 
% %rician 3
% semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch512_encoder1,'-*','linewidth',1,'color','#0072BD')
% hold on
% semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch128_encoder2,'-o','linewidth',1,'color','#0072BD')
% semilogy(simParams.EbNoVec,BLER_psk_rician3_c1d2,'--','linewidth',1,'color','#0072BD')
% semilogy(simParams.EbNoVec,BLER_qam_rician3_c1d2,'-','linewidth',1,'color','#0072BD')
% %rician 10
% semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo15_batch128_encoder2,'-*','linewidth',1,'color','#D95319')
% semilogy(simParams.EbNoVec,BLER_rician10_c1d2_EbNo7_batch128_encoder2,'-o','linewidth',1,'color','#D95319')
% semilogy(simParams.EbNoVec,BLER_psk_rician10_c1d2,'--','linewidth',1,'color','#D95319')
% semilogy(simParams.EbNoVec,BLER_qam_rician10_c1d2,'-','linewidth',1,'color','#D95319')
% %rician 20
% semilogy(simParams.EbNoVec,BLER_rician20_c1d2_EbNo15_batch128_encoder1,'-*','linewidth',1,'color','#7E2F8E')
% semilogy(simParams.EbNoVec,BLER_psk_rician20_c1d2,'--','linewidth',1,'color','#7E2F8E')
% semilogy(simParams.EbNoVec,BLER_qam_rician20_c1d2,'-','linewidth',1,'color','#7E2F8E')
% 
% hold off
% ylim([y_min 1])
% grid on
% set(gca,'FontName','Times New Roman','fontsize', 12)
% xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
% ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
% title("Best Models for AE with Antenna Signature with Energy Norm for c = 1, d = 2, varying Rician Factors")
% legend("Rician Factor = 3, Eb/No = 7, enc(64), dec(64,64), Batch = 512", ...
% "Rician Factor = 3, Eb/No = 7, enc(64,64), dec(64,64), Batch = 128", ...
% "Baseline SM PSK MLD at Rician Factor = 3", ...
% "Baseline SM QAM MLD at Rician Factor = 3", ...
% "Rician Factor = 10, Eb/No = 15, enc(64,64), dec(64,64), Batch = 128", ...
% "Rician Factor = 10, Eb/No = 7, enc(64,64), dec(64,64), Batch = 128", ...
% "Baseline SM PSK MLD at Rician Factor = 10", ...
% "Baseline SM QAM MLD at Rician Factor = 10", ...
% "Rician Factor = 20, Eb/No = 15, enc(64), dec(64,64), Batch = 128", ...
% "Baseline SM PSK MLD at Rician Factor = 20", ...
% "Baseline SM QAM MLD at Rician Factor = 20", ...
% 'FontName','Times New Roman','FontSize',12,'Location','southwest')
% 
% 
% figure
% y_min = 10^(-6);
% 
% %rician 3
% semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch512_encoder1,'-*','linewidth',1,'color','#0072BD')
% hold on
% semilogy(simParams.EbNoVec,BLER_rician3_c1d2_EbNo7_batch128_encoder2,'-o','linewidth',1,'color','#0072BD')
% semilogy(simParams.EbNoVec,BLER_psk_rician3_c1d2,'--','linewidth',1,'color','#0072BD')
% semilogy(simParams.EbNoVec,BLER_qam_rician3_c1d2,'-','linewidth',1,'color','#0072BD')
% hold off
% ylim([y_min 1])
% grid on
% set(gca,'FontName','Times New Roman','fontsize', 12)
% xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
% ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
% title("Best Models for AE with Antenna Signature with Energy Norm for c = 1, d = 2, varying Rician Factors")
% legend("Rician Factor = 3, Eb/No = 7, enc(64), dec(64,64), Batch = 512", ...
% "Rician Factor = 3, Eb/No = 7, enc(64,64), dec(64,64), Batch = 128", ...
% "Baseline SM PSK MLD at Rician Factor = 3", ...
% "Baseline SM QAM MLD at Rician Factor = 3", ...
% 'FontName','Times New Roman','FontSize',12,'Location','southwest')