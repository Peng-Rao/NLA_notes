function [x, it, res] = richprec(A,b,P, alpha, x0,nmax, toll)

% Metodo di Richardson stazionario precondizionato
%
% Parametri in ingresso:
%   A: matrice del sistema
%   b: termine noto
%   P: precondizionatore
%   x0: vettore iniziale
%   alpha: coefficiente di Richardson
%   toll: tolleranza sul residuo normalizzato
%   nmax: massimo numero di iterazioni
%
% Parametri in uscita:
%   x: soluzione ottenuta
%   it: numero di iterazioni effettuate
%   res: vettore contenente i residui normalizzati

%Controlliamo che le matrici A e P siano quadrate e che, insieme al guess
%iniziale x0, abbiano dimensioni compatibili con b.
n = size(b,1); 
if (size(A,1) ~= size (A,2) || size(A,1) ~= n || size(x0,1) ~= n || size (P,2) ~= n || size(P,1) ~= n )
    error('Dimesioni incompatibili')
end

%Inizializziamo x con x0, calcoliamo il residuo e il residuo normalizzato
it = 0; 
x = x0; 
r = b - A*x;
resk = norm(r)/norm(b); 
res = resk;

% Ciclo iterativo fino a criterio di arresto soddisfatto
while (it < nmax && resk > toll)
    it = it + 1; 
    % Aggiornamento del residuo precondizionato, risolvendo il sistema
    % lineare Pz = r. Per semplicità usare il comando \
    z = P\r;
    % Aggiornmento della soluzione 
    x = x + alpha*z; 
    % Aggiornamento del residuo e del residuo normalizzato
    r = b - A*x;
    resk = norm(r)/norm(b);
    res = [res; resk];
end
