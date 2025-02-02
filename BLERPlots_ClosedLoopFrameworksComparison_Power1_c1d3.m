k = 3;    % number of input bits
M = 2^k;  % number of possible input symbols
n = 2;    % number of channel uses
c = 1;    % No of antenna selection bits
d = k-c;  % No of data bits
M_d = 3^d;% number of possible input symbols
Nt = 2^c; % number of transmit antennas

% Simulate the block error rate (BLER) performance
simParams.EbNoVec = 0:0.5:40;
EbNoVec = simParams.EbNoVec;
R = k/n;
M = 2^k;
y_min = 10^(-6);

% Get BLER for different saved models
%*************************************** Simple AE ****************************************************
file_SimpleAE_Rician3 = matfile('BestModels/Results/SimpleAE/Power1_rician3_c1d3.mat');
file_SimpleAE_Rician10 = matfile('BestModels/Results/SimpleAE/Power1_rician10_c1d3.mat');
file_SimpleAE_Rician20 = matfile('BestModels/Results/SimpleAE/Power1_rician20_c1d3.mat');
%file_Feedback_SimpleAE_Rician3 = matfile('BestModels/Results/Feedback_SimpleAE/Power1_rician3_c1d3.mat');
%file_Feedback_SimpleAE_Rician10 = matfile('BestModels/Results/Feedback_SimpleAE/Power1_rician10_c1d3.mat');
%file_Feedback_SimpleAE_Rician20 = matfile('BestModels/Results/Feedback_SimpleAE/Power1_rician20_c1d3.mat');

BLER_SimpleAE_Rician3 = file_SimpleAE_Rician3.BLER;
BLER_SimpleAE_Rician10 = file_SimpleAE_Rician10.BLER;
BLER_SimpleAE_Rician20 = file_SimpleAE_Rician20.BLER;
%BLER_Feedback_SimpleAE_Rician3 = file_Feedback_SimpleAE_Rician3.BLER;
%BLER_Feedback_SimpleAE_Rician10 = file_Feedback_SimpleAE_Rician10.BLER;
%BLER_Feedback_SimpleAE_Rician20 = file_Feedback_SimpleAE_Rician20.BLER;

BLER_SimpleAE_Rician3(BLER_SimpleAE_Rician3==0)=y_min/10;
BLER_SimpleAE_Rician10(BLER_SimpleAE_Rician10==0)=y_min/10;
BLER_SimpleAE_Rician20(BLER_SimpleAE_Rician20==0)=y_min/10;
%BLER_Feedback_SimpleAE_Rician3(BLER_Feedback_SimpleAE_Rician3==0)=y_min/10;
%BLER_Feedback_SimpleAE_Rician10(BLER_Feedback_SimpleAE_Rician10==0)=y_min/10;
%BLER_Feedback_SimpleAE_Rician20(BLER_Feedback_SimpleAE_Rician20==0)=y_min/10;

%*************************************** Control AE ****************************************************
file_ControlAE_Rician3 = matfile('BestModels/Results/ControlAE/Power1_rician3_c1d3.mat');
file_ControlAE_Rician10 = matfile('BestModels/Results/ControlAE/Power1_rician10_c1d3.mat');
file_ControlAE_Rician20 = matfile('BestModels/Results/ControlAE/Power1_rician20_c1d3.mat');
file_Feedback_ControlAE_Rician3 = matfile('BestModels/Results/Feedback_ControlAE/Power1_rician3_c1d3.mat');
file_Feedback_ControlAE_Rician10 = matfile('BestModels/Results/Feedback_ControlAE/Power1_rician10_c1d3.mat');
file_Feedback_ControlAE_Rician20 = matfile('BestModels/Results/Feedback_ControlAE/Power1_rician20_c1d3.mat');

BLER_ControlAE_Rician3 = file_ControlAE_Rician3.BLER;
BLER_ControlAE_Rician10 = file_ControlAE_Rician10.BLER;
BLER_ControlAE_Rician20 = file_ControlAE_Rician20.BLER;
BLER_Feedback_ControlAE_Rician3 = file_Feedback_ControlAE_Rician3.BLER;
BLER_Feedback_ControlAE_Rician10 = file_Feedback_ControlAE_Rician10.BLER;
BLER_Feedback_ControlAE_Rician20 = file_Feedback_ControlAE_Rician20.BLER;

BLER_ControlAE_Rician3(BLER_ControlAE_Rician3==0)=y_min/10;
BLER_ControlAE_Rician10(BLER_ControlAE_Rician10==0)=y_min/10;
BLER_ControlAE_Rician20(BLER_ControlAE_Rician20==0)=y_min/10;
BLER_Feedback_ControlAE_Rician3(BLER_Feedback_ControlAE_Rician3==0)=y_min/10;
BLER_Feedback_ControlAE_Rician10(BLER_Feedback_ControlAE_Rician10==0)=y_min/10;
BLER_Feedback_ControlAE_Rician20(BLER_Feedback_ControlAE_Rician20==0)=y_min/10;

%*************************************** Signature AE ****************************************************
file_SignatureAE_Rician3 = matfile('BestModels/Results/SignatureAE/Power1_rician3_c1d3.mat');
file_SignatureAE_Rician10 = matfile('BestModels/Results/SignatureAE/Power1_rician10_c1d3.mat');
file_SignatureAE_Rician20 = matfile('BestModels/Results/SignatureAE/Power1_rician20_c1d3.mat');
file_Feedback_SignatureAE_Rician3 = matfile('BestModels/Results/Feedback_SignatureAE/Power1_rician3_c1d3.mat');
file_Feedback_SignatureAE_Rician10 = matfile('BestModels/Results/Feedback_SignatureAE/Power1_rician10_c1d3.mat');
file_Feedback_SignatureAE_Rician20 = matfile('BestModels/Results/Feedback_SignatureAE/Power1_rician20_c1d3.mat');

BLER_SignatureAE_Rician3 = file_SignatureAE_Rician3.BLER;
BLER_SignatureAE_Rician10 = file_SignatureAE_Rician10.BLER;
BLER_SignatureAE_Rician20 = file_SignatureAE_Rician20.BLER;
BLER_Feedback_SignatureAE_Rician3 = file_Feedback_SignatureAE_Rician3.BLER;
BLER_Feedback_SignatureAE_Rician10 = file_Feedback_SignatureAE_Rician10.BLER;
BLER_Feedback_SignatureAE_Rician20 = file_Feedback_SignatureAE_Rician20.BLER;

BLER_SignatureAE_Rician3(BLER_SignatureAE_Rician3==0)=y_min/10;
BLER_SignatureAE_Rician10(BLER_SignatureAE_Rician10==0)=y_min/10;
BLER_SignatureAE_Rician20(BLER_SignatureAE_Rician20==0)=y_min/10;
BLER_Feedback_SignatureAE_Rician3(BLER_Feedback_SignatureAE_Rician3==0)=y_min/10;
BLER_Feedback_SignatureAE_Rician10(BLER_Feedback_SignatureAE_Rician10==0)=y_min/10;
BLER_Feedback_SignatureAE_Rician20(BLER_Feedback_SignatureAE_Rician20==0)=y_min/10;

%*************************************** Baselines ****************************************************
file_psk_rician3 = matfile('BestModels/Results/psk_rician3_c1d3.mat');
file_qam_rician3 = matfile('BestModels/Results/qam_rician3_c1d3.mat');
file_psk_rician10 = matfile('BestModels/Results/psk_rician10_c1d3.mat');
file_qam_rician10 = matfile('BestModels/Results/qam_rician10_c1d3.mat');
file_psk_rician20 = matfile('BestModels/Results/psk_rician20_c1d3.mat');
file_qam_rician20 = matfile('BestModels/Results/qam_rician20_c1d3.mat');

BLER_psk_rician3 = file_psk_rician3.BLER_psk;
BLER_qam_rician3 = file_qam_rician3.BLER_qam;
BLER_psk_rician10 = file_psk_rician10.BLER_psk;
BLER_qam_rician10 = file_qam_rician10.BLER_qam;
BLER_psk_rician20 = file_psk_rician20.BLER_psk;
BLER_qam_rician20 = file_qam_rician20.BLER_qam;

BLER_psk_rician3(BLER_psk_rician3==0)=y_min/10;
BLER_qam_rician3(BLER_qam_rician3==0)=y_min/10;
BLER_psk_rician10(BLER_psk_rician10==0)=y_min/10;
BLER_qam_rician10(BLER_qam_rician10==0)=y_min/10;
BLER_psk_rician20(BLER_psk_rician20==0)=y_min/10;
BLER_qam_rician20(BLER_qam_rician20==0)=y_min/10;

%Plots

%*************************************** Closed-Loop ****************************************************
%*************************************** Rician Factor = 3 ****************************************************

figure

%semilogy(simParams.EbNoVec,BLER_Feedback_SimpleAE_Rician3,'-','linewidth',1,'color','#0072BD')
%hold on
semilogy(simParams.EbNoVec,BLER_Feedback_SignatureAE_Rician3,'-*','linewidth',1,'color','#EDB120')
hold on
semilogy(simParams.EbNoVec,BLER_Feedback_ControlAE_Rician3,'-s','linewidth',1,'color','#D95319')
%semilogy(simParams.EbNoVec,BLER_psk_rician3,'--','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_qam_rician3,'--','linewidth',1,'color','#77AC30')
hold off
ylim([y_min 1])
grid on
set(gca,'FontName','Times New Roman','fontsize', 12)
xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
title("Frameworks Comparison for Power Norm, c = 1, d = 3, Rician Factor = 3")
%legend("Simple AE",...
legend(...
    "AE with Antenna Signature",...
    "Control bit encoded AE",..."Baseline SM PSK MLD", ...
    "Baseline SM QAM MLD", ...
    'FontName','Times New Roman','FontSize',12,'Location','southwest')

%*************************************** Rician Factor = 10 ****************************************************

figure

%semilogy(simParams.EbNoVec,BLER_Feedback_SimpleAE_Rician10,'-','linewidth',1,'color','#0072BD')
%hold on
semilogy(simParams.EbNoVec,BLER_Feedback_SignatureAE_Rician10,'-*','linewidth',1,'color','#EDB120')
hold on
semilogy(simParams.EbNoVec,BLER_Feedback_ControlAE_Rician10,'-s','linewidth',1,'color','#D95319')
%semilogy(simParams.EbNoVec,BLER_psk_rician10,'--','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_qam_rician10,'--','linewidth',1,'color','#77AC30')
hold off
ylim([y_min 1])
grid on
set(gca,'FontName','Times New Roman','fontsize', 12)
xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
title("Frameworks Comparison for Power Norm, c = 1, d = 3, Rician Factor = 10")
%legend("Simple AE",...
legend(...
    "AE with Antenna Signature",...
    "Control bit encoded AE",..."Baseline SM PSK MLD", ...
    "Baseline SM QAM MLD", ...
    'FontName','Times New Roman','FontSize',12,'Location','southwest')

%*************************************** Rician Factor = 20 ****************************************************

figure

%semilogy(simParams.EbNoVec,BLER_Feedback_SimpleAE_Rician20,'-','linewidth',1,'color','#0072BD')
%hold on
semilogy(simParams.EbNoVec,BLER_Feedback_SignatureAE_Rician20,'-*','linewidth',1,'color','#EDB120')
hold on
semilogy(simParams.EbNoVec,BLER_Feedback_ControlAE_Rician20,'-s','linewidth',1,'color','#D95319')
%semilogy(simParams.EbNoVec,BLER_psk_rician20,'--','linewidth',1,'color','#7E2F8E')
semilogy(simParams.EbNoVec,BLER_qam_rician20,'--','linewidth',1,'color','#77AC30')
hold off
ylim([y_min 1])
grid on
set(gca,'FontName','Times New Roman','fontsize', 12)
xlabel('E_b/N_o (dB)','FontName','Times New Roman','FontSize',12)
ylabel('Block Error Rate','FontName','Times New Roman','FontSize',12)
title("Frameworks Comparison for Power Norm, c = 1, d = 3, Rician Factor = 20")
%legend("Simple AE",...
legend(...
    "AE with Antenna Signature",...
    "Control bit encoded AE",..."Baseline SM PSK MLD", ...
    "Baseline SM QAM MLD", ...
    'FontName','Times New Roman','FontSize',12,'Location','southwest')