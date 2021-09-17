clear all, clc;

global DadosBarra DadosLinha...
       Bbus Nbus Nlinhas...
       Vi Tetai Tipo...
       Pl Pg Pi...
       Custo Pmax Pmin...
       De Para Capacidade...
       LouD

% --- LEITURA DOS DADOS ---

LeituraDados;

% -----------------------------------------------

% --- MONTAR MATRIZ DE SUSCEPTANCIA DE BARRA ---

MontarBbus;

% -----------------------------------------------

% --- SOLUCAO DO FLUXO DC OTIMO ---

Otimizacao;

Corte = 'Nao';

% Teste para determinar se ha corte de carga
if max(Pg - Pmax) > 0
    
    Corte = 'Sim';
    CustoCorte = 4*max(Custo);
    Custo0 = Custo;
    NPQ0 = NPQ;
    NPQ = 0;
    
    for N1 = 1:Nbus
    
        if Tipo(N1) == 0
            
            Custo(N1) = CustoCorte;
            Pmax(N1) = max(Pg - Pmax);
            
        end
        
    end
    
    Otimizacao;
    
end

% --- POTENCIAS LIQUIDAS E FLUXO DE POTENCIA ---

FluxoPotencia;

Pi = Pg - Pl; % Potencia liquida injetada na barra

% -----------------------------------------------

% --- IMPRIMIR RESULTADOS NO ARQUIVO DE SAIDA ---

MostrarResultados;

%------------------------------------------------