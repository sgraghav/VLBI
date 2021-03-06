

% Pre-located from function libiers_admint because of speed; now the admittance 
% and frequency is compute only once for all three coordinate components
% 
% 
% Input
%   TAMP    amplitudes of the 11 main tides generated by Bos-Scherneck
%           website (Radial, West, South) [m]
%   TPH     phases of the 11 main tides from Bos-Schernack website (RWS)[deg]
%   TAMPT   Cartwright-Edden amplitudes for the 11 main tides
%   IDT     Doodson numbers of the 11 tides
%   mjd
%   leap
% 
% Output
%   RF      frequency
%   RL, AIM real and imaginary parts of admittance, scaled by Cartwright-
%           Edden amplitude.
%
% 
% Coded for VieVS
% 18 July 2011 by Hana Spicakova



function [RF RL AIM] = libiers_admint_part1(TAMP, TPH, TAMPT, IDT, mjd, leap)

NIN=size(TAMP,2);

          
RL=zeros(3,NIN);
AIM=zeros(3,NIN);

%vertical;
AMPIN = TAMP(1,:);
PHIN = TPH(1,:);

RL(1,:) = AMPIN .* cos(deg2rad(PHIN))./abs(TAMPT);
AIM(1,:)= AMPIN .* sin(deg2rad(PHIN))./abs(TAMPT);

% West
AMPIN = TAMP(2,:);
PHIN = TPH(2,:);
RL(2,:) = AMPIN .* cos(deg2rad(PHIN))./abs(TAMPT);
AIM(2,:)= AMPIN .* sin(deg2rad(PHIN))./abs(TAMPT);


% South
AMPIN = TAMP(3,:);
PHIN = TPH(3,:);
RL(3,:) = AMPIN .* cos(deg2rad(PHIN))./abs(TAMPT);
AIM(3,:)= AMPIN .* sin(deg2rad(PHIN))./abs(TAMPT);



% *+---------------------------------------------------------------------
% *  Now have real and imaginary parts of admittance, scaled by Cartwright-
% *  Edden amplitude. Admittance phase is whatever was used in the original
% *  expression. (Usually phase is given relative to some reference,
% *  but amplitude is in absolute units). Next get frequency.
% *----------------------------------------------------------------------
  for i=1:NIN %11
     [FR PR] = libiers_tdfrph(IDT(i,:),mjd,leap);
      RF(i) = FR;
  end

% *+---------------------------------------------------------------------
% *  Done going through constituents; there are k of them.
% *  Have specified admittance at a number of points. Sort these by frequency
% *  and separate diurnal and semidiurnal, recopying admittances to get them
% *  in order using Shell Sort.
% *----------------------------------------------------------------------
    

[RF KEY]=sort(RF);

RL = RL(:,KEY); % sort real admittance
AIM = AIM(:,KEY);% sort imaginary part of admittance

