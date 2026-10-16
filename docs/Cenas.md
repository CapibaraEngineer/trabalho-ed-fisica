# Cenas

## Cenas principais (Cenas/)

| Arquivo | Descrição |
|---------|-----------|
| `gameTileMap.tscn` | TileMap com TerrainLayer e SpikeLayer |
| `Player1.tscn` | Player 1 (CharacterBody2D + Sprite2D) |
| `Player_2.tscn` | Player 2 (CharacterBody2D + Sprite2D) |
| `corda.tscn` | Corda (Node2D + Line2D) |
| `win_areas.tscn` | Áreas de vitória (2 Area2D) |

## Levels (Cenas/Levels/)

| Arquivo | Próximo nível |
|---------|--------------|
| `Level1.tscn` | Level2 |
| `Level2.tscn` | Level1 |

## Estrutura de uma fase
```
Level (Node2D)
├── GameTileMap
│   ├── TerrainLayer (TileMapLayer)
│   └── SpikeLayer (TileMapLayer)
├── Player1
├── Player2
├── Corda
├── SpawnP1 (Marker2D)
├── SpawnP2 (Marker2D)
├── Camera2D
└── WinAreas
	├── WinAreaP1 (Area2D)
	└── WinAreaP2 (Area2D)
```
