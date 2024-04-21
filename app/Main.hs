module Main (main) where

import Data.List (intersperse)
import Data.Char (ord)
import System.Process

type Matriz = [[Char]]

-- Função para limpar a tela do terminal
limparTela :: IO ()
limparTela = do
    _ <- system "clear"  -- Para sistemas Unix (Linux, macOS)
    -- _ <- system "cls"  -- Para sistemas Windows
    return ()

-- Matriz de solução 
createMatrizSolucao :: Matriz
createMatrizSolucao =  [['4', '1', '5', '7', '9', '2', '6', '3', '8'],
                        ['3', '7', '6', '5', '4', '8', '9', '1', '2'],
                        ['9', '2', '8', '3', '1', '6', '5', '4', '7'],
                        ['1', '5', '2', '9', '6', '4', '7', '8', '3'],
                        ['6', '9', '4', '8', '7', '3', '1', '2', '5'],
                        ['8', '3', '7', '1', '2', '5', '4', '6', '9'],
                        ['7', '8', '3', '6', '5', '1', '2', '9', '4'],
                        ['5', '4', '1', '2', '3', '9', '8', '7', '6'],
                        ['2', '6', '9', '4', '8', '7', '3', '5', '1']]

-- Matriz de jogo 
createMatrizJogo :: Matriz
createMatrizJogo =     [['4', '1', '5', '7', ' ', ' ', ' ', '3', ' '],
                        [' ', ' ', ' ', '5', ' ', '8', '9', '1', '2'],
                        [' ', ' ', '8', '3', '1', ' ', '5', ' ', '7'],
                        [' ', '5', '2', '9', ' ', ' ', '7', ' ', ' '],
                        ['6', ' ', '4', ' ', '7', ' ', '1', '2', '5'],
                        ['8', '3', ' ', ' ', ' ', ' ', ' ', '6', '9'],
                        ['7', ' ', ' ', '6', '5', '1', '2', '9', ' '],
                        ['5', '4', '1', ' ', ' ', ' ', ' ', '7', ' '],
                        [' ', ' ', '9', '4', '8', '7', '3', ' ', '1']]

-- Loop do jogo
jogo :: [[Char]] -> [[Char]] -> Int-> Int-> IO ()
jogo matrizJogo matrizSolucao acertos total = do
    jogada <- getLine -- le a jogado 
    if jogada == "sair"
        then putStrLn "Saindo..."
        else do
            if length jogada /= 5 -- se a string jogado tiver mais que 5 chars a entrada é Inválida
                then do
                    putStrLn "Digite um comando válido"
                    jogo matrizJogo matrizSolucao acertos total-- chamada recusriva de jogo
                else do
                    let [stringLinha, stringColuna, stringValor] = words jogada -- separa a string da jogada em tres strings
                        linha = read stringLinha :: Int -- trasforma a string da linha em um valor inteiro
                        coluna = read stringColuna :: Int -- trasforma a string da coluna em um valor inteiro
                    if verificarJogada matrizSolucao (linha-1) (coluna-1) stringValor  -- verifica se o valor da jogada está correto
                        then do
                            limparTela
                            putStrLn "Correto (─‿‿─)"
                            if verificaEspacoMatrix matrizJogo (linha-1) (coluna-1)
                                then do
                                let matrizNova = inserirValor matrizJogo (linha-1) (coluna-1) (head stringValor)  -- insere o valor da jogada na matrix
                                printQuadro matrizNova
                                if verificaAcertos (acertos+1) total
                                    then putStrLn "A matrix está completa parabéns (/^▽^)/ "
                                    else jogo matrizNova matrizSolucao (acertos+1) total-- chamada recusriva de jogo com a matrix atualizada
                                else do 
                                    putStrLn "Esse espaço ja foi preenchido"
                                    printQuadro matrizJogo
                                    jogo matrizJogo matrizSolucao acertos total
                        else do
                            limparTela
                            putStrLn "Errado (╥﹏╥)"
                            printQuadro matrizJogo
                            jogo matrizJogo matrizSolucao acertos total-- chamada recusriva de jogo

-- Função para imprimir o tabuleiro inicial e as intruções
printQuadroInicial :: [[Char]] -> IO ()
printQuadroInicial matriz = do
    printQuadro matriz
    putStrLn "Bem-vindo, para jogar digite a linha, a coluna e o valor"
    putStrLn "Exemplo: 1 1 4"
    putStrLn "Para fechar digite sair"

-- Função para imprimir o tabuleiro
printQuadro :: [[Char]] -> IO ()
printQuadro quadro = do
    putStrLn "   |1 2 3 4 5 6 7 8 9|" -- cabeçalho
    putStrLn "                      "
    printLinhas 1 quadro
  where
    printLinhas :: Int -> [[Char]] -> IO ()
    printLinhas _ [] = return ()
    printLinhas numeroLinha (linha:linhas) = do
        putStr $ show numeroLinha 
        printLinha linha
        printLinhas (numeroLinha + 1) linhas

    printLinha :: [Char] -> IO ()
    printLinha linha = do
        putStrLn $  "| |" ++ (intersperse '|' linha)  ++ "| |"

-- Função para obter o valor de uma célula na matriz
getValorMatriz :: Matriz -> Int -> Int -> Char
getValorMatriz matriz linha coluna = matriz !! linha !! coluna

-- Função para verificar se a jogada é válida
verificarJogada ::[[Char]]-> Int -> Int -> [Char] ->  Bool
verificarJogada matrizSolucao linha coluna stringValor = 
    if [getValorMatriz matrizSolucao linha coluna] == stringValor
        then True
        else False

-- Função para inserir um valor na matriz
inserirValor :: [[Char]]  ->Int -> Int -> Char -> [[Char]]
inserirValor matriz linha coluna charValor = 
    let (antes, linhaAtual:depois) = splitAt linha matriz
        (antesCol, _:depoisCol) = splitAt coluna linhaAtual
    in antes ++ [antesCol ++ (charValor : depoisCol)] ++ depois

verificaEspacoMatrix :: Matriz -> Int -> Int -> Bool
verificaEspacoMatrix matrizJogo linha coluna  = 
    if getValorMatriz matrizJogo linha coluna  == ' '
        then True
        else False

verificaAcertos :: Int -> Int-> Bool
verificaAcertos acertos total = 
    if acertos == total
        then True
        else False
-- Função principal
main :: IO ()
main = do
    let matrizSolucao = createMatrizSolucao
    let matriz = createMatrizJogo
    printQuadroInicial matriz
    jogo matriz matrizSolucao 0 36
    putStrLn $ "tchau (^o^)/"