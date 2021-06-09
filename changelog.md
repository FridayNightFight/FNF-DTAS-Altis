# v5.1
IndigoFox
2021-06-08

## WWII

- Adds respawn handling for reliable loadout assignment

- Implements loadout notes to more easily view equipment you have

- Updates item loadout counts for inventory size

- Adds handler to prevent Panzerfaust 30 auto-load of ammo in spawn

- Removes extraneous insertion methods

- Adds validation for spawn location of attacker vehicles to mitigate collisions at round start

- Updates legacy TFAR radio (deprecated) that was being assigned



-----


FNF DTAS Changelog - v5.0
by IndigoFox, Cullen - committed 2021-04-14

- Now allows 124 players.

- Added 2x Optic Selection Menu via Ace Self Interaction available while in safe zone.

- Fixes issue where sidearm mags assigned during planning phase.

- Changed participating Player AFK kill time from 3 minutes to 2 minutes.

- Changed the way random objective positions are generated. Now will now always spawn nearby a small set of buildings or periphery of towns in order to provide some improved cover options.

- When the attacking team has 1 player or less than 10% of total players still alive, remaining round time is lowered to 2 minutes (or 5 minutes if less than 6 players are participating in this round). Round time will be left alone if it would be increased by this change.

  - *If the round time is lowered, the attackers will see the new round time left on their screen, but defenders' timers will be unchanged. This prevents meta-awareness of the state of the attacking force.*

- Fixed .widthRailway error appearing on player init since Arma 1.90.

- Adjusted Squad and Command radio channels to left and right ear respectively.

- Fixed radio assignments.

- Sets frequencies the same per side.

- Fixes loading screen image.

- Adds some clouds.

- Fixed some localization.