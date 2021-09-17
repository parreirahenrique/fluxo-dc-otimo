for N = 1:Nlinhas
    
    Pik(N) = Bbus(De(N), Para(N))*(Tetai(De(N)) - Tetai(Para(N)));               % Fluxo de potencia ativa da barra i para k
    
    Pki(N) = Bbus(Para(N), De(N))*(Tetai(Para(N)) - Tetai(De(N)));               % Fluxo de potencia ativa da barra k para i
    
end