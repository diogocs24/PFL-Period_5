# PFL-Period_5
- Period 5_1

### Membros
- Diogo Coutinho da Silva (202104794) contribuição (60%)
- Francisco Pinto Tristão da Cunha Bettencourt (202105288) contribuição (40%)

## Instalação e Execução
Para instalar o jogo Period 5 primeiro é necessário fazer o download dos ficheiros presentes em PFL_TP1_T01_Period5.zip e extrair os ficheiros que se lá encontram. Dentro do diretório "src" consulte o ficheiro period5.pl através da linha de comandos ou pela própria UI do Sicstus Prolog 4.8.0. O jogo está disponível em ambientes Windows e Linux.


O jogo inicia-se com o predicado:

```prolog

| ?- play.

```
## Descrição do Jogo
- Period 5 é um jogo de tabuleiro para 2 jogadores. Na sua versão originial cada jogador possui 4 peças individuais, neste caso, com o simbolo "X" ou "O", e ambos partilham uma peça, o cubo, esta com o simbolo "+". Ambos os jogadores podem controlar o cubo. O tabuleiro é 5x5, tradicionalmente, mas na nossa versão tem também 7x7 e 9x9, cada tabuleiro tem um número diferente de peças **individuais**. Os tabuleiros tão diagonalmente preenchidos com cores.

- Um jogador ganha quando tem um conjunto de 5 peças (4 individuais e o cubo) em colunas diferentes e em cores diferentes.

Existe algumas regras em termos de movimentação de peças, sendo elas:
  - As peças não podem passar umas por cima de outras nem podem andar diagonalmente.
  - A peça "cubo" não pode voltar á posição anteriormente jogada, ou seja, se um jogador jogar o cubo uma casa para a direita, o outro jogador, na sua jogada a seguir, não pode jogar o cubo uma casa para a esquerda.
  - Caso um jogador tiver perto de ganhar, isto é, faltar-lhe apenas uma peça na casa certa, o jogador adversário não pode mexer a peça "cubo".

## Lógica do Jogo
### Representação interna do estado do jogo
O GameState é um argumento fundamental em todos os predicados principais da implementação. É formado por um grupo de X elementos:
 - **Board**, que é uma matriz quadrada de tamanho determinado pelo utilizador. Nela existe células a representar peças ("X", "O" e "+") e células vazias nas posições desocupadas por estas.
 -
 -
 -

#### Estado do jogo inicial (5x5)
```prolog
init_state(5, [[
    [empty,o,empty,empty,empty],
    [x,empty,o,empty,empty],
    [empty,x,plus,o,empty],
    [empty,empty,x,empty,o],
    [empty,empty,empty,x,empty]
],playerX]).

colors_positions(5, [
    [red, white, purple, black, green],
    [green,red, white, purple, black],
    [black, green, red, white, purple],
    [purple, black, green, red, white],
    [white, purple, black, green, red]
]).
```
![Estado do jogo inicial (5x5)](https://i.imgur.com/a/5CJHcD7)

#### Estado do jogo intermédio (5x5)

```prolog
init_state(5, [[
    [empty,o,empty,empty,empty],
    [x,empty,o,empty,empty],
    [empty,x,plus,o,empty],
    [empty,empty,x,empty,o],
    [empty,empty,empty,x,empty]
],playerX]).

colors_positions(5, [
    [red, white, purple, black, green],
    [green,red, white, purple, black],
    [black, green, red, white, purple],
    [purple, black, green, red, white],
    [white, purple, black, green, red]
]).
```

#### Estado do jogo final (5x5)
```prolog
init_state(5, [[
    [empty,o,empty,empty,empty],
    [x,empty,o,empty,empty],
    [empty,x,plus,o,empty],
    [empty,empty,x,empty,o],
    [empty,empty,empty,x,empty]
],playerX]).

colors_positions(5, [
    [red, white, purple, black, green],
    [green,red, white, purple, black],
    [black, green, red, white, purple],
    [purple, black, green, red, white],
    [white, purple, black, green, red]
]).
```

