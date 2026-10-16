# Player 1

`Script/Player_1.gd` - CharacterBody2D

## Habilidade
Pulo duplo (MAXIMO_DE_PULOS = 2)

## Constantes
- SPEED = 250
- GRAVITY = 1000
- JUMP_SPEED = -400

## Funções
- `resetarProSpawn()` - Volta ao spawn point
- `morrer()` - Reseta os dois jogadores
- `checarColisaoEspinho()` - Verifica colisão com SpikeLayer

## Variáveis
- `forca_corda` - Força aplicada pela corda (controlada pelo script da corda)
