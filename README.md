# Newton Cooling Solver
Video For Presentation Is Here --> https://drive.google.com/drive/folders/1ZcZm3rnJtCOEim7agAzVD-N36rYluRBE?usp=drive_link

## Description
This project provides a solution to Newton's Law of Cooling using various numerical methods for solving ordinary differential equations (ODEs).

## Numerical Methods Used
The following numerical methods are implemented in this project:

1. **Forward Euler**
   - A simple, first-order numerical method for solving ODEs.

2. **Modified Euler**
   - An improved version of the Euler method that uses an intermediate step for better accuracy.

3. **Backward Euler**
   - A stable, implicit method used for stiff problems, with an emphasis on long-term stability.

4. **Runge-Kutta 2 (RK2)**
   - A second-order method using two intermediate steps to achieve better accuracy than Euler.

5. **Runge-Kutta 4 (RK4)**
   - A fourth-order method that provides highly accurate solutions using four intermediate steps.

6. **Adams-Bashforth**
   - A multi-step method using previous values of the solution to predict future values, focusing on forward estimates.

7. **Adams-Moulton**
   - A predictor-corrector method combining Adams-Bashforth and the backward method for more accuracy.

8. **Exact Solution**
   - The exact analytical solution for the Newton's Law of Cooling equation, based on the formula:

   \[
   T(t) = T_{env} + (T_0 - T_{env}) \cdot e^{-k t}
   \]

## How to Use
1. Run the `main.m` file to launch the graphical user interface (GUI).
2. Enter the initial temperature (T₀), environment temperature (T_env), cooling constant (k), and final time (t_final).
3. Select the numerical method you want to use by clicking on the corresponding button.
4. The result will appear in the output box and will also be plotted for better visualization.

## Requirements
-  Octave
- Functions for the numerical methods should be correctly implemented.


