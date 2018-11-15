function [handles,Lf] = graphMerge(L,handles)
MergeMatrix=handles.MergeMatrix;
idx=handles.idx;
G = graph(MergeMatrix);
 %Podemos agora extrair a informa��o em rela��o aos grupos de pixeis que
 %est�o conectados
 BINS=conncomp(G,'OutputForm','cell');
 %Estamos em condi��es de contruir a imagem final usando o grafo anterior
 %mas primeiro � necessario reconstruir o novo index que organiza os
 %superpixeis 
 idxfinal=cell(1,length(BINS));
 Lf=zeros(size(L));
 for Run=1:length(BINS)
     for Conc=1:length(BINS{Run})
         idxfinal{Run}=cat(1,idxfinal{Run},idx{BINS{Run}(Conc)});
     end
    % Ifinal(idxfinal{Run})=(ColorVector(1,BINS{Run})*ColorVector(2,BINS{Run})')/(sum(ColorVector(2,BINS{Run})));
     Lf(idxfinal{Run})=Run;
 end
 handles.idxfinal=idxfinal;
end

