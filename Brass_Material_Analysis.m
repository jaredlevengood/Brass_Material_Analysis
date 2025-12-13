clear; clc;

% Brass_Material_Analysis.m
% Computes stress–strain curves and key material properties for a brass tensile test:
% modulus of elasticity, yield strength (0.2% offset), ultimate tensile strength,
% fracture stress, and toughness.

%% Load stress–strain data and compute strain / stress
initial_length_mm = 78; % initial gauge length [mm]
cross_section_mm2 = 0.506; % cross-sectional area [mm^2]
dataFile = 'B5_4.csv'; % [Force (N), Elongation (mm)]
test_data = readmatrix(dataFile);
elongation_mm = test_data(:,2);  % [mm]
applied_force_N = test_data(:,1);  % [N]
strain = elongation_mm ./ initial_length_mm; % engineering strain [-]
stress_MPa = applied_force_N ./ cross_section_mm2; % N/mm^2 = MPa

%% Figure 1: Stress (MPa) vs Strain 
figure(1);
plot(strain, stress_MPa, 'rx');
title('Stress (MPa) vs Strain of Brass (0.005" thickness)');
xlabel('Strain');
ylabel('Stress (MPa)');

%% Figure 2: Stress (ksi) vs Strain 
MPA_TO_KSI = 1/6.8947572932; % MPa -> ksi (approx)
stress_ksi = stress_MPa * MPA_TO_KSI;

figure(2);
plot(strain, stress_ksi, 'b*');
title('Stress (ksi) vs Strain of Brass (0.005" thickness)');
xlabel('Strain');
ylabel('Stress (ksi)');

%% Figure 3: Linear portion of stress–strain (elastic region)
% indices 4:163 correspond to the approximate linear (elastic) region
strain_linear = strain(4:163);
stress_linear = stress_MPa(4:163);

% Linear fit: stress = E * strain + b
p = polyfit(strain_linear, stress_linear, 1);
E_MPa = p(1); % modulus of elasticity [MPa]
strain_fit = [min(strain_linear) max(strain_linear)];
stress_fit = polyval(p, strain_fit);

figure(3);
hold on;
plot(strain_linear, stress_linear, 'kp'); % experimental points
plot(strain_fit,    stress_fit,    'm-', 'LineWidth', 4); % linear fit
title('Linear Portion of Stress (MPa) vs Strain of Brass (0.005" thickness)');
xlabel('Strain');
ylabel('Stress (MPa)');
legend('Experimental data','Linear fit','Location','northwest');
hold off;

%% Toughness of the material
toughness_J_per_m3 = trapz(strain, stress_MPa * 1e6); % MPa -> N/m^2
fprintf('Toughness: %.2f J/m^3.\n', toughness_J_per_m3);

%% Stress–strain plot with 0.2%% offset construction line
strain_offset    = strain_fit + 0.002 * strain_fit; % 0.2% offset
extended_stress  = polyval(p, [strain_offset(1) 1.5e-2]); % offset line values

figure(4);
hold on;
plot(strain, stress_MPa, 'k+');
plot([strain_offset(1), 1.6e-2], extended_stress, 'g-', 'LineWidth', 4);
title('Stress (MPa) vs Strain of Brass (0.005" thickness) with Yield Offset');
xlabel('Strain');
ylabel('Stress (MPa)');
axis([0 0.01 0 290]);
legend('Stress–strain data','0.2% offset line','Location','northwest');
hold off;

%% Compute material properties
E_ksi = E_MPa * MPA_TO_KSI;
yield_strength_MPa = 200; % estimated yield strength [MPa]
yield_strength_ksi = yield_strength_MPa * MPA_TO_KSI;
ut_strength_MPa = max(stress_MPa); % ultimate tensile strength [MPa]
ut_strength_ksi = ut_strength_MPa * MPA_TO_KSI;
fracture_MPa = stress_MPa(end); % fracture stress [MPa]
fracture_ksi = fracture_MPa * MPA_TO_KSI;

%% Print summary table
fprintf('\nSummary of Material Properties (Brass)\n');
fprintf('--------------------------------------\n');
fprintf('Modulus of Elasticity:      %8.3f MPa   %8.3f ksi\n', E_MPa, E_ksi);
fprintf('Yield Strength:             %8.3f MPa   %8.3f ksi\n', yield_strength_MPa, yield_strength_ksi);
fprintf('Ultimate Tensile Strength:  %8.3f MPa   %8.3f ksi\n', ut_strength_MPa, ut_strength_ksi);
fprintf('Fracture Stress:            %8.3f MPa   %8.3f ksi\n\n', fracture_MPa, fracture_ksi);
