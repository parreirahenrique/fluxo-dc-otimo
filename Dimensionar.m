% ---FUNCAO PARA FAZER COM QUE TODAS AS STRINGS TENHAM O MESMO TAMANHO---

function [S] = Dimensionar(X)

Tamanho = length(X);

if Tamanho ~= 7
    
    Metade = floor((7 - Tamanho)/2);
    
    for N = 1:Metade
        
        X = [' ' X];
        
    end
    
    for N = 1:(7 - Tamanho - Metade)
        
        X = [X ' '];
        
    end
    
end

S = X;