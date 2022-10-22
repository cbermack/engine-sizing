% Bell Nozzle Angles Interpolation
% Author: Chris Bermack

%% angle splines
% eyeballing theta values for certain expansion ratios from 
% http://www.aspirespace.org.uk/downloads/Thrust%20optimised%20parabolic%20nozzle.pdf
expRatio = [4 5 6 7 8 9 10 20 30];
thetaN = [21.7 23.0 23.9 24.7 25.3 25.9 26.3 28.7 30.1];
thetaE = [14.0 12.9 12.0 11.5 11.1 10.7 10.4 9.0 8.4];

expRatio2 = 4:0.01:30; % finer expansion ratio for spline interpolation

% spline of theta values from previous points
thetaNspline = spline(expRatio,thetaN,expRatio2);
thetaEspline = spline(expRatio,thetaE,expRatio2);

% plot
semilogx(expRatio2,thetaNspline,'r-');
hold on;
grid on;
semilogx(expRatio2,thetaEspline,'b-');
semilogx(expRatio,thetaN,'ro');
semilogx(expRatio,thetaE,'bo');
hold off;
title('Nozzle Contour Angles');
xlabel('Expansion Ratio');
ylabel('\theta [deg]');
legend('\theta_n','\theta_e','location','best');

%% theta outputs for expansion ratio input
expRatioInput = input('Expansion Ratio: ');
m = 1;
for n = 4:0.1:30
    if expRatioInput == n
        break
    end
    m = m+1;
end
thetaNout = thetaNspline(m);
thetaEout = thetaEspline(m);
fprintf('thetaN = %.1f\n',thetaNout);
fprintf('thetaE = %.1f\n',thetaEout);
