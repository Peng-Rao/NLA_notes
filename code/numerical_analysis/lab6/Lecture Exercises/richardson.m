function [x,it,res] = richardson(A,b,x0,alpha,toll,nmax)

% Metodo di Richardson stazionario
%
% A: matrice del sistema
% b: termine noto
% x0: vettore iniziale
% alpha: coefficiente di Richardson
% toll: tolleranza sul residuo normalizzato
% nmax: massimo numero di iterazioni
%
% x: soluzione ottenuta
% it: numero di iterazioni effettuate
% res: vettore contenente i residui normalizzati.

n = size(b,1);

%Controlliamo che la matrice A sia quadrata e che, insieme al guess
%iniziale x0, abbia dimensioni compatibili con b.
if ((size(A,1) ~= n) || (size(A,2) ~= n) || (size(x0,1) ~= n))
  error('Dimensioni incompatibili')
end

%Inizializziamo x come x0, calcoliamo il residuo e il residuo normalizzato
x = x0;
r = b - A*x;
resk = norm(r)/norm(b); 
res = resk;

% Inizializziamo l'indice di iterazione
it = 0;

while (resk > toll && it < nmax)
    it = it + 1;
    % Calcoliamo il nuovo x secondo il metodo di Richardson
    x = x + alpha*r;
    % Calcoliamo il residuo e il residuo normalizzato
    r = b - A*x;
    resk = norm(r)/norm(b);
    % Aggiungiamo il residuo normalizzato al vettore dei residui
    % normalizzati.
    res = [res; resk];
end



