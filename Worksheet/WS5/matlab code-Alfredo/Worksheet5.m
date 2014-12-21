%Worksheet5.m. Calls the functions to display the results of the different
%methods to solve the stationary heat equation.

clear all
Nx = [3 7 15 31 63 127 255];
% Nx = 255;
Ny = Nx;
eGS = zeros(1,length(Nx));

%Calculate the solutions for every Nx, Ny using the standard Gauss-Seidel
%iteration (m=1), the SOR Gauss-Seidel (m=2), and the vCycle (m=3).
for m = 3:3
    
    if (m==1), disp('STANDARD GAUSS-SEIDEL'); end
    if (m==2), disp('SOR GAUSS-SEIDEL'); end
    if (m==3), disp('RECURSIVE vCYCLE'); end
    
    for k = 1:length(Nx)
        
        disp([10,'Nx = ', num2str(Nx(k)), ', Ny = ', num2str(Ny(k))]);
        if(m==1)
            [TGS eGS(k)] = GaussSeidel(Nx(k),Ny(k),1); 
        elseif(m == 2)
            [TSOR eGS(k)] = GaussSeidel(Nx(k),Ny(k),2);
        else
            [Tv eGS(k)] = vSolver(Nx(k), Ny(k));
        end
    end

    %Reduced errors
    eGSr = zeros(1,length(Nx)-1);
    for j=2:length(Nx)
        eGSr(j-1) = eGS(j)/eGS(j-1); 
    end
    
    disp(['REDUCED ERROR: ', num2str(eGSr)]);
    
end