global Nbus Nlinhas...
       Vi Tetai...
       Pl Pg Pi...
       De Para

clc;

% --- SAIDA DOS DADOS NO ARQUIVO ---

Saida = fopen('Dados_Saida.txt', 'wt'); % Abre o arquivo para escrita

fprintf(Saida, 'INFORMACOES DAS BARRAS:\n\n');
fprintf(Saida, ' Barra   Tensao [pu]   Fase [rad]   Pi [pu]   Pg [pu]   Pd [pu]\n');
fprintf(Saida, '+-----+ +-----------+ +----------+ +-------+ +-------+ +-------+\n');

for N = 1:Nbus
    
    % Pegando apenas a variavel a ser mostrada na atual iteracao e arredondando-a para quatro casas decimais
    ViN = Vi(N)*10000;       
    TetaiN = Tetai(N)*10000;
    PiN = Pi(N)*10000;
    PgN = Pg(N)*10000;
    PdN = Pl(N)*10000;
    
    ViN = round(ViN);       
    TetaiN = round(TetaiN);
    PiN = round(PiN);
    PgN = round(PgN);
    PdN = round(PdN);
    
    ViN = ViN/10000;       
    TetaiN = TetaiN/10000;
    PiN = PiN/10000;
    PgN = PgN/10000;
    PdN = PdN/10000;
    
    % Criando uma variavel string da variavel a ser mostrada na atual iteracao
    Vistr = num2str(ViN);
    Tetaistr = num2str(TetaiN);
    Pistr = num2str(PiN);
    PgN = num2str(PgN);
    PdN = num2str(PdN);
    
    % Fazendo com que todos os strings tenham o mesmo tamanho
    Vistr = Dimensionar(Vistr);
    Tetaistr = Dimensionar(Tetaistr);
    Pistr = Dimensionar(Pistr);
    PgN = Dimensionar(PgN);
    PdN = Dimensionar(PdN);
    
    % Mostrando o resultado
    fprintf(Saida, '   %g       %s      %s     %s   %s   %s\n', N, Vistr, Tetaistr, Pistr, PgN, PdN);
    
end

fprintf(Saida, '\n\n');

fprintf(Saida, 'INFORMACOES DAS LINHAS DE TRANSMISSAO:\n\n');

fprintf(Saida, ' De   Para   Pik [pu]   Pki [pu]   Perdas At. [pu]\n');
fprintf(Saida, '+--+ +----+ +--------+ +--------+ +---------------+\n');

Perdasik(1:Nlinhas) = 0;

for N = 1:Nlinhas
    
    % Pegando apenas a variavel a ser mostrada na atual iteracao e arredondando-a para quatro casas decimais
    PikN = Pik(N);       
    PkiN = Pki(N);
    PerdasAt = Perdasik(N);
    
    PikN = PikN*10000;
    PkiN = PkiN*10000;
    PerdasAt = PerdasAt*10000;
    
    PikN = round(PikN);       
    PkiN = round(PkiN);
    PerdasAt = round(PerdasAt);
    
    PikN = PikN/10000;
    PkiN = PkiN/10000;
    PerdasAt = PerdasAt/10000;
    
    % Criando uma variavel string da variavel a ser mostrada na atual iteracao
    PikN = num2str(PikN);
    PkiN = num2str(PkiN);
    PerdasAt = num2str(PerdasAt);
    
    % Fazendo com que todos os strings tenham o mesmo tamanho
    PikN = Dimensionar(PikN);
    PkiN = Dimensionar(PkiN);
    PerdasAt = Dimensionar(PerdasAt);
    
    % Mostrando o resultado
    fprintf(Saida, '  %g     %g     %s    %s       %s\n', De(N), Para(N), PikN, PkiN, PerdasAt);
    
end

fprintf(Saida, '\n\n');

if strcmp(Corte, 'Sim') == 1
    
    fprintf('Ha corte de carga.\n\n');
    
    fprintf(Saida, 'INFORMACOES SOBRE O CORTE DE CARGA:\n\n');
    fprintf(Saida, ' Barra   Pr [pu]\n');
    fprintf(Saida, '+-----+ +-------+\n');
    
    for N1 = 1:NPQ0
       
        fprintf(Saida, '   %g     %.4f\n', BarraPQ(N1), Pg(BarraPQ(N1)));
        
        Pr(N1) = Pg(BarraPQ(N1));
        
    end
    
    fprintf(Saida, '\n\n');
    
    fprintf(Saida, 'O custo de atendimento da carga foi de $%.2f.\n\n', Custo0'*Pg);

    fprintf(Saida, 'O custo do corte foi de $%.2f.\n\n', CustoCorte*sum(Pr));
    
end

fprintf(Saida, 'O custo total foi de $%.2f.\n\n', Custo'*Pg);

fclose(Saida);

fprintf('A solucao do Fluxo Linearizado Otimo se encontra no arquivo "Dados_Saida.txt".\n\n');