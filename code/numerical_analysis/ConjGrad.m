function [xk,k,XK,res] = ConjGrad(A,b,x0,Nmax,toll)
% 
%
% Metodo del gradiente coniugato per sistemi lineari.
% 
% Parametri di ingresso:
%  A      Matrice del sistema
%  b      Termine noto (vettore colonna)
%  x0     Vettore iniziale (vettore colonna)
%  Nmax   Numero massimo di iterazioni
%  toll   Tolleranza sul test d'arresto (sul residuo relativo)
%
% Parametri in uscita
%  xk     Vettore soluzione
%  k      Iterazioni effettuate
%  XK     Matrice contenente le sol di ogni iterazione
%  res    ||res||_2 / ||b||_2 norma due del residuo normalizzata


k = 0;
xk = x0;
XK = x0;
res=[];
rk = b - A*xk;
pk = rk;
normb = norm(b, 2);
err = toll + 1;
while ( err > toll) && (k < Nmax) 
    k = k + 1;
    alphak = (pk'*rk)/(pk'*(A*pk));
    xk = xk + alphak * pk;
    rk = rk - alphak * A * pk;
    % o, equivalentemente:
    % rk = b - A*xk;
    err = norm(rk, 2) / normb;
    betak = (pk'*(A*rk))/(pk'*(A*pk));
    pk = rk - betak*pk;
    XK = [XK xk]; 
    res= [res err];
end
if (k == Nmax)
    disp('**Gradiente coniugato non converge nel numero fissato di iterazioni **');
end
