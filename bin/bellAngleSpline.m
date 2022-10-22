% Bell Nozzle Angles Spline Interpolation
% Author: Chris Bermack
% nozzle throat and exit angles for 80% bell curve nozzle
% input: expRatioInput (nozzle expansion ratio) to 2 decimal places,
% between 4 and 30
% output: thetaNout (nozzle angle near throat), thetaEout (nozzle exit 
% angle), both in degrees

function [thetaNout, thetaEout] = bellAngleSpline(expRatioInput)
%% theta outputs for expansion ratio input
expRatio = [4 5 6 7 8 9 10 20 30 40 50];
thetaN = [21.7 23.0 23.9 24.7 25.3 25.9 26.3 28.7 30.1 31.0 31.7];
thetaE = [14.0 12.8 12.0 11.5 11.1 10.7 10.4 9.0 8.4 7.9 7.6];

expRatio2 = 4:0.01:50; % finer expansion ratio for spline interpolation

% spline of theta values
thetaNspline = spline(expRatio,thetaN,expRatio2);
thetaEspline = spline(expRatio,thetaE,expRatio2);

%% extrapolation to lower expansion ratios

% slopes for thetaN and thetaE from splines
thetaNslope = (thetaNspline(2)-thetaNspline(1))/(expRatio2(2)-expRatio2(1));
thetaEslope = (thetaEspline(2)-thetaEspline(1))/(expRatio2(2)-expRatio2(1));

expRatioMin = 3; % minimum extrapolated expansion ratio

% values for thetaN and thetaE at minimum expansion ratio
thetaNmin = thetaN(1) + thetaNslope*(expRatioMin-expRatio(1));
thetaEmin = thetaE(1) + thetaEslope*(expRatioMin-expRatio(1));

% updating arrays and redoing spline with extrapolation
expRatio = [expRatioMin, expRatio];
thetaN = [thetaNmin, thetaN];
thetaE = [thetaEmin, thetaE];
expRatio2 = expRatioMin:0.01:50;
thetaNspline = spline(expRatio,thetaN,expRatio2);
thetaEspline = spline(expRatio,thetaE,expRatio2);

% for loop to check input against expansion ratios
m = 1;
for n = expRatioMin:0.01:50
    if expRatioInput == n
        break
    end
    m = m+1;
end
thetaNout = thetaNspline(m);
thetaEout = thetaEspline(m);
% fprintf('thetaN = %.2f deg\n',thetaNout);
% fprintf('thetaE = %.2f deg\n',thetaEout);

%% angle splines
% eyeballing theta values for certain expansion ratios from 
% http://www.aspirespace.org.uk/downloads/Thrust%20optimised%20parabolic%20nozzle.pdf
% plot
plotInput = input('Do you want a plot of \theta? [Y/N]: ','s');
if plotInput == 'Y'
    semilogx(expRatio2,thetaNspline,'r-');
    hold on;
    grid on;
    semilogx(expRatio2,thetaEspline,'b-');
    semilogx(expRatio,thetaN,'ro');
    semilogx(expRatio,thetaE,'bo');
    semilogx(expRatioInput,thetaNout,'r*');
    semilogx(expRatioInput,thetaEout,'b*');
    hold off;
    title('Nozzle Contour Angles');
    xlabel('Expansion Ratio');
    ylabel('\theta [deg]');
    legend('\theta_n','\theta_e','location','best');
end

end
