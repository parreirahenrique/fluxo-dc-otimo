global Bbus Nbus Nlinhas...
       Tetai...
       Pl Pg...
       Custo Pmax Pmin...
       De Para Capacidade...

% --- CONSTRUCAO DAS MATRIZES PARA OTIMIZACAO ---

f = [zeros(1,Nbus), Custo'];         % Funcao de custo a ser minimizada
A = zeros(2*Nlinhas + 2*Nbus, 2*Nbus);           % Matriz de desigualdade
Aeq = zeros((Nbus + NPQ + 1), 2*Nbus); % Matriz de igualdade

for N1 = 1:Nlinhas
    
    A(N1, De(N1)) = Bbus(De(N1),Para(N1));
    A(N1, Para(N1)) = -Bbus(De(N1),Para(N1));
    A((N1 + Nlinhas), De(N1)) = -Bbus(De(N1),Para(N1));
    A((N1 + Nlinhas), Para(N1)) = Bbus(De(N1),Para(N1));
    
end

A((2*Nlinhas + 1):(2*Nlinhas + Nbus), (Nbus + 1):2*Nbus) = -eye(Nbus);
A((2*Nlinhas + Nbus + 1):(2*Nlinhas + 2*Nbus), (Nbus + 1):2*Nbus) = eye(Nbus);

A(:, NSW) = 0; % Zera a coluna para o angulo da barra de referencia

b = [Capacidade;Capacidade;-Pmin;Pmax];

Aeq(1:Nbus,1:Nbus) = Bbus;
Aeq(1:Nbus, (Nbus+1):2*Nbus) = eye(Nbus);

Aeq(:,NSW) = 0; % Zera a coluna para o angulo da barra de referencia

beq = [Pl; zeros(NPQ + 1, 1)];

for N1 = 1:NPQ
    
    A(:, (Nbus + BarraPQ(N1))) = 0;
    Aeq(:, (Nbus + BarraPQ(N1))) = 0;
    
end

Aeq(Nbus + 1, NSW) = 1;

for N1 = 1:NPQ
    
    Aeq((Nbus + N1 + 1),(Nbus + BarraPQ(N1))) = 1;
    
end

lb = [-pi*ones(Nbus,1); zeros(Nbus,1)];
ub = [pi*ones(Nbus,1); inf*ones(Nbus,1)];

x = linprog(f,A,b,Aeq,beq,lb,ub);

Tetai = x(1:Nbus);
Pg = x((Nbus + 1):2*Nbus);