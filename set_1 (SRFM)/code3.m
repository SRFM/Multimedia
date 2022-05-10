% Serafeim-Ilias Antoniou AM: 2640

clear;
% Initial matrix of quantitized AC coefficients
AC = [7,0,4,0,2,3,0,0,2,4,0,1,0,0,0,1,0,0,-1,-1,0,1,0,0,0,1,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

% Finding non-zero positions
nonzeroAC = find(AC)
len = length(nonzeroAC);

% Printing 1st element with RUN=0
i = 1;
printf('(%d, 0)', AC(nonzeroAC(i)));

% For each element, calculating RUN = Index(i) - Index(i-1) - 1
for i = 2:len 
   RUN = nonzeroAC(i)-nonzeroAC(i-1)-1;
   printf(', (%d, %d)', AC(nonzeroAC(i)), RUN);
end 
% Printing out the last element
printf("(0, 0)EOB");
printf("\n");