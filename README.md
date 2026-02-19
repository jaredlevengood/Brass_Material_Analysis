# Brass Material Analysis (MATLAB)

This project analyzes tensile test data for a brass specimen using MATLAB. It computes and visualizes the stress–strain response and extracts key mechanical properties, including:

- Modulus of elasticity (E)
- Yield strength (0.2% offset method)
- Ultimate tensile strength (UTS)
- Fracture stress
- Toughness (area under the stress–strain curve)

--------------------------------------------

## Project Structure

Brass_Material_Analysis/
│
├── Brass_Material_Analysis.m        (main MATLAB analysis script)
├── B5_4.csv                         (raw tensile test data: force & elongation)
├── .gitignore                       (ignores autosave/backup files)
└── figures/                         (exported plots)
├── stress_strain_mpa.png
├── stress_strain_ksi.png
├── linear_elastic_fit.png
└── offset_yield_method.png

--------------------------------------------

## Data Description

The file B5_4.csv contains raw tensile test measurements:

- Column 1: Applied force (N)
- Column 2: Elongation (mm)

The script converts this into engineering quantities:

- Strain = ΔL / L0
- Stress = F / A (reported in MPa and ksi)

Specimen parameters:
- Initial gauge length: 78 mm
- Cross-sectional area: 0.506 mm²

--------------------------------------------

## What the Script Does

1. Loads and processes tensile test data  
2. Computes stress and strain  
3. Creates stress–strain plots (MPa and ksi)  
4. Extracts elastic region and fits a linear regression  
5. Computes modulus of elasticity using polyfit  
6. Uses trapz to integrate toughness  
7. Applies the 0.2% offset method to estimate yield strength  
8. Prints a summary table including:  
   - Modulus of elasticity  
   - Yield strength  
   - UTS  
   - Fracture stress  
   - Toughness  

--------------------------------------------

## How to Run

Requirements:
- MATLAB
- Brass_Material_Analysis.m
- B5_4.csv

Steps:
1. Open MATLAB  
2. Set Current Folder to this project  
3. Run: Brass_Material_Analysis
4. View generated figures  
5. Read mechanical property results printed in the Command Window  

--------------------------------------------

## Skills Demonstrated

- MATLAB programming
- Mechanical engineering analysis
- Stress–strain interpretation
- Linear regression (polyfit)
- Numerical integration (trapz)
- 0.2% offset yield method
- Data visualization
- Engineering report preparation

--------------------------------------------

## Possible Extensions

- Automatically compute yield point intersection
- Support multiple specimens or materials
- Export summary tables and plots to a PDF report
- Convert script into reusable MATLAB functions
