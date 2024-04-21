# sudoku
Sudoku em Haskell

Este é um projeto de Sudoku em Haskell desenvolvido com propósitos de estudos.
Descrição

O codigo é uma implementação simples do jogo Sudoku, onde os usuários podem solucionar uma matrix 9x9 dividida em 9 matriz de 3x3 chamadas regiões. O objetivo do jogo é preencher o tabuleiro com números de 1 a 9 de tal forma que cada linha, coluna e região de contenha todos os números de 1 a 9 sem repetições.
Pré-requisitos

Antes de executar este projeto, você precisa ter o Stack instalado em seu sistema. Você pode encontrar instruções de instalação para o Stack em https://docs.haskellstack.org/en/stable/README/.
Compilação e Execução

    Navegue até o diretório do projeto:

bash

cd sudoku-haskell

    Compile o projeto usando o Stack:

bash

stack build

    Execute o projeto:

bash

stack exec sudoku-exe

Como Jogar

    Ao iniciar o jogo, você verá um tabuleiro de Sudoku com espaços vazios.
    Use o seguitne comando para enviar um valor para preencher o espaço vazio 
    linha coluna valor
    Exemplo: 1 1 4
    Pressione Enter.
    Caso a jogada esteja correta aparecer uma mensagem de confirmação e a nova matriz atualizada.
    O jogo se encerra quando á matriz estiver completa.
    Para sair do jogo antes, digite "sair" e pressione Enter.