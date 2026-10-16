# Player 2

`Script/Player_2.gd` - CharacterBody2D

## Habilidade
Dash na direção que está olhando (DASH_SPEED = 1000, duração 0.3s)

## Constantes
- SPEED = 300
- GRAVITY = 1000
- JUMP_VELOCITY = -350
- DASH_SPEED = 1000
- DASH_DURATION = 0.3

## Funções
- `resetarProSpawn()` - Volta ao spawn point
- `morrer()` - Reseta os dois jogadores
- `checarColisaoEspinho()` - Verifica colisão com SpikeLayer

## Variáveis
- `forca_corda` - Força aplicada pela corda
- `direcao_olhando` - Direção do último movimento horizontal
- `pode_dar_dash` - Controla se o dash está disponível (recarrega ao tocar o chão)
