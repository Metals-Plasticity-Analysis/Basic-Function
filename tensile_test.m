clear all
clc
data = dlmread('stress-strain.txt');
eng_strain = data(:,1);
eng_stress = data(:,2);
fig1 = plot(eng_strain,eng_stress);
hold on

approx_yield_strength = input('Enter the approximate value of Yield strength:-');
%offset = input('Enter the offset in strain (Default value = 0.002):-');
offset = 0.002;

%% Calculating the Elastic modulus : E = eng_stress/eng_strain
% find index where stress > 0.7 of yield strength
index70 = min(find(eng_stress > approx_yield_strength*0.3));
index40 = min(find(eng_stress > approx_yield_strength*0.1));
%%%%%%%%%%%%%%%%%%%%%%%%%

%% Creating offset of 0.2% 
%%%%%%%%%%%%%%%%%%%%%%%%%

elastic_strain = eng_strain([index40:index70]);
elastic_stress = eng_stress([index40:index70]);
%plot(elastic_strain,elastic_stress)
line_fit = polyfit(elastic_strain,elastic_stress,1);
E=line_fit(1); % slope = modulus
elastic_stress_fit = line_fit(1)*elastic_strain+line_fit(2);
%plot(elastic_strain,elastic_stress_fit,'r-.');
elastic_strain = elastic_strain + offset;
strain_step= elastic_strain(2) -elastic_strain(1);

upper_extraplot_stress = interp1(elastic_strain,elastic_stress_fit,[max(elastic_strain)+strain_step:strain_step:eng_strain(find(eng_stress==max(eng_stress)))],'linear','extrap');
lower_extraplot_stress = interp1(elastic_strain,elastic_stress_fit,[0:strain_step:min(elastic_strain-strain_step)],'linear','extrap');

extraploted_strain_1 = [0:strain_step:min(elastic_strain-strain_step)];
extraploted_strain_2 = [max(elastic_strain)+strain_step:strain_step:eng_strain(find(eng_stress==max(eng_stress)))];


exploted_strain_full = [extraploted_strain_1 elastic_strain' extraploted_strain_2];
exploted_stress_full = [lower_extraplot_stress elastic_stress_fit' upper_extraplot_stress];
%plot(exploted_strain_full,exploted_stress_full)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Finding the Yield Strength (Intersection Point) %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Strain_Yield,Yield_strength] = intersections(eng_strain,eng_stress,exploted_strain_full,exploted_stress_full)

index_yield = min(find(exploted_stress_full > Yield_strength));
exploted_strain_partial = exploted_strain_full(1:index_yield+100);
exploted_stress_partial = exploted_stress_full(1:index_yield+100);
fig1 = plot(exploted_strain_partial,exploted_stress_partial)
ylim([0 inf])

%% Ultimate tensile strength : 
ultimate_tensile_stress = max(eng_stress);
umin = min(find(eng_stress == ultimate_tensile_stress));
umax = max(find(eng_stress == ultimate_tensile_stress));
index_ultimate = round((umin + umax)/2,0);
fig1 = plot(eng_strain(index_ultimate),eng_stress(index_ultimate),'ko');

%% Breaking strength : 
Breaking_strength = eng_stress(end);
fig1 = plot(eng_strain(end),eng_stress(end),'k*');

%% Finalization
fig1 = plot(eng_strain(index70),eng_stress(index70),'k<');
fig1 = plot(eng_strain(index40),eng_stress(index40),'k>'); 
eng_strain_per = eng_strain/100; % put eng_strain to 0.37 instead of 37%
E = E/100; % convert from MPa to GPa
% Label
xlabel('Engineering strain (%)');
ylabel('Engineering stress (MPa)');
% title(name)
grid on
ylim([0, ultimate_tensile_stress+50])

% Legend
Syt = ['Yield Strength at ', num2str(round(Yield_strength,0)),' MPa' ];
Sut = ['Ultimate Strength at ', num2str(round(ultimate_tensile_stress,0)),' MPa' ];
Sbt = ['Breaking Strength at ', num2str(round(Breaking_strength,0)),' MPa' ];
Et = ['0.2% offset line of slope E = ', num2str(round(E,0)),' GPa' ];
legend('Data-points',Et,Syt,Sut,Sbt,'[\sigma,\epsilon]_{70%}','[\sigma,\epsilon]_{40%}','Location','South')


%% Finding eng_strain against YS
index_yield_strain = min(find(eng_strain > Strain_Yield));
epsilon_0 = Strain_Yield;


%%%%%%%%%%%%% Plotting true stress Vs True Strain %%%%%%%%%%%%

epsilon =log(1+eng_strain([index_yield_strain:index_ultimate]));
plastic_strain = smoothdata(epsilon,'sgolay')-epsilon_0;
true_stress = eng_stress([index_yield_strain:index_ultimate]).*(1+eng_strain([index_yield_strain:index_ultimate]));

% True_stress_vs_strain = plot(plastic_strain,true_stress)


%% Kocks Mecking Erstling modelling

sigma = smoothdata(true_stress,'sgolay');
sigma_minus_sigma_0 = sigma-Yield_strength;

%%%%%%%%%% Plotting Plastic strain vs sigma-sigma_0 %%%%%%%%%%
%figure();
%plot(plastic_strain,sigma)
figure();
plot(plastic_strain,sigma_minus_sigma_0)
% Label
xlabel('Plastic Strain');
ylabel('\sigma - \sigma_0');
title('Plastic Strain VS \sigma - \sigma_0 ')
xlim([0 inf])
ylim([0,inf])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Fitting the data with High Polynomials %%%%%%%

fiiting_polynomial = polyfit(plastic_strain,sigma_minus_sigma_0,5);
Value_from_polynomial = polyval(fiiting_polynomial,plastic_strain);

plot(plastic_strain,Value_from_polynomial)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



theta = diff(sigma)./diff(plastic_strain);
theta = [theta;nan];

figure()
plot(sigma_minus_sigma_0,theta) 

theta_from_poly = diff(Value_from_polynomial)./diff(plastic_strain);
theta_from_poly = [theta_from_poly;nan];

figure()
plot(sigma_minus_sigma_0,theta_from_poly)

