# Friday Night Fight DTAS

## **Dynamic Take and Secure**

_Inspired by DTAS (Dynamic Take And Secure) for Infiltration, which is a realistic total conversion mod for the original Unreal Tournament (1999)._

### Development Timeline

2013 : Authored by Gal Zohar ([Arma Israel](www.arma-il.info)), logo and Russian localization by Excess3

2016 : Enhanced by Fritz

2020 : Further customized by Martin

2021 : Modernized and tailored for the Friday Night Fight by the FNF Technical Team


## Mods Required

Standard
- CBA_A3
- RHS USAF
- RHS AFRF
- Task Force Arrowhead Radio


WWII
- IFA
- FOW

---

## Gameplay Flow

### **Joining**

When players join the mission, they'll be auto-assigned to one side or the other.

Players spawn in walled-in safe areas near opposite parts of the map. Scroll wheel interaction is enabled on the crates inside this zone allowing for the selection of different pre-defined loadouts such as Squad Leader, Automatic Rifleman, Grenadier, Machine Gunner, etc. TFAR radio channels are automatically assigned to players at the group (up to 3) and overall Side level.

### **Planning**

When they load in, players will have 60 seconds to grab kits and prepare (_subsequent rounds will allow only 30 seconds_). The objective location and their role in the next round (ATK/DEF) will be visible to allow for planning. The ACE Self-Interaction menu will also allow for the selection of a 1x-2x optic for their weapon, if appropriate.

- Two MAT roles per 10 players on a side are allowed. This means that 20 players on DTAS = 10 players per side, and two MAT roles are permitted on each. If more than this select MAT role on a side, random players who selected MAT will have their roles randomized at round start until the limit is reached.
- Combat Engineers are now available on both sides -- they will receive 4x small demolition blocks and a remote clacker.

At the end of this planning period, attackers will spawn at a point nearby the objective in Humvees, and defenders will spawn on the objective. 

### **Playing**

- Radios for players will now be automatically synchronized with their group leader at round start.
- The vehicles in which attackers will spawn are now randomized with weighted values -- you may receive a standard unarmed HMMWV variant, or a jeep or APC with an M240 MMG.

The default round timer is 10 minutes. Attackers will have this much time to kill the defending team or occupy the target zone until captured. A round timer and capture progress indicator are shown in a HUD at the top of the screen.

When all players of a side are killed, the round timer expires, or the objective is successfully captured by attackers, the round will end. All players will be moved back to their side's base to prepare for the next round.

### **Switch Sides**

Each objective location will offer two 'heats'. After the first heat, the sides will be swapped. Those who previously attacked will get a chance to defend the location, and vice versa.

### **Next Round, New Location**

Once both heats have been played for an objective location, it will move somewhere else on the map and the round will proceed after the planning period.

---

## Game Mechanics

The objectives are randomly spawned within a very large possible area on the map of Altis with a bias toward locations with a moderate number of sizeable buildings nearby. This offers unique locations to assault and defend.

Should there be only **one attacker OR 10% of the attacking team left alive**, the round timer will be lowered to 2 minutes if not already below it. There will appear to be no change to round time for defenders in order to preserve the illusion of force for attackers. If less than 6 players overall are participating in this round, the timer will be lowered to 5 minutes if not already below it. This allows small numbers of players to still have a worthwhile fight.

TFAR radios are encrypted by side and will not allow for enemy communications interception unless a radio on an enemy soldier is acquired.

