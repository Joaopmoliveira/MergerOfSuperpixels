function Boolean = verifica_entrada(param)
%Esta função verifica se o parametro de entrada corresponde a algum dos
%campos da struct que contem os dados classificados
% arvore,mar,estrada_batida,estrada_alcatrao
switch param
    
    case 'arvore'
        Boolean=1;
    case 'mar'
        Boolean=1;
    case 'estrada'
        Boolean=1;
    otherwise
        Boolean=0;   
end
end

