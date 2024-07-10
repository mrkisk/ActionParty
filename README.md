# ActionParty

## Overview

ActionParty is a competitive action game where multiple players build the stage and race to reach the goal.

## DEMO

![Demo](./assets/demo.gif)

## Game Rules

ActionParty is a competitive action game for 2-4 players. Players compete to reach the goal the fastest while freely building the stage. The game consists of several rounds, and players compete for points over multiple rounds.

Each round is divided into three phases: the Selection Phase, the Placement Phase, and the Play Phase. In the Selection Phase, players choose items to place on the stage. These items vary widely, including platform blocks, spiky obstacles, and moving enemy mobs. The X-mark item removes one item from the stage and is useful when the stage becomes unbeatable. In the Placement Phase, players place the selected items on the stage. Items can be placed anywhere except near the starting or goal points. In the Play Phase, players race to the goal on the constructed stage. Players who fall or hit obstacles or enemy mobs become immobilized and cannot reach the goal. At the end of the Play Phase, points are tallied, and the next round begins.

Players who reach the goal faster than others earn more points. Players also earn points for hindering other players with their placed obstacles. The game ends when a player exceeds a certain point threshold or after 10 rounds, and the player with the highest score is declared the winner.

## Controls

Describe how to play the game:

Player 1 Controls
- RDFG Keys: Move the cursor, player.
- S Key: Select the item, jump.
- A Key: Rotate the item.

Player 2 Controls
- Arrow Keys: Move the cursor, player.
- \ Key: Select the item, jump.
- / Key: Rotate the item.

Player 3 Controls
- HBNM Keys: Move the cursor, player.
- V Key: Select the item, jump.
- C Key: Rotate the item.

Player 4 Controls
- @;:] Keys: Move the cursor, player.
- L Key: Select the item, jump.
- K Key: Rotate the item.

General Controls (Player 1)
- R,F Keys: Move the cursor.
- S,A Key: Select the option.

## Installation and Usage

Download [Processing 4.3](https://processing.org/download/) and run this sketch folder in Processing 4.3.

The game is designed to be played in full-screen mode on a Full HD (1920x1080) screen. If your screen size is larger than this, please set the content of [data/FullScreen.txt](./data/FullScreen.txt) to `false`.

Since the game uses many keys for gameplay, we strongly recommend using a controller and assigning key settings with software like [JoyToKey](https://joytokey.net/).

## Author
* Keisuke Morita

## License

This project is licensed under the MIT License - see the [LICENSE.md](./LICENSE.md) file for details.
