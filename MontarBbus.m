global Bbus...
       Nbus Nlinhas...
       De Para...
       LouD

Bbus = zeros(Nbus); % Matriz de susceptancia de barra

% --- MONTAGEM DA YBUS ---

for L = 1:Nlinhas
        
    if LouD(L) == 1 % Apenas altera os valores da Ybus para as linhas que estao ligadas
        
        Bbus(De(L), Para(L)) = 1/X(L);                            % Termo Yik da matriz Ybus
        Bbus(Para(L), De(L)) = 1/X(L);                            % Termo Yki da matriz Ybus
        Bbus(De(L), De(L)) = Bbus(De(L), De(L)) - 1/X(L);         % Termo Yii da matriz Ybus
        Bbus(Para(L), Para(L)) = Bbus(Para(L), Para(L)) - 1/X(L); % Termo Ykk da matriz Ybus
        
    end
    
end

% ------------------------------------------------------------------------------------------