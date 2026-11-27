# Guardians of the Chronoshard Catacombs: Multiplayer

A browser board game (V4) with 3D heroes, a leaderboard and online multiplayer where one player hosts and picks
who commands each hero. It is a plain static website: no build step, no server of your own, and nothing depends on
Claude. Put the folder on GitHub Pages (steps below) and share the link.

## What is in the folder

| File | What it is |
|---|---|
| `index.html` | The whole game |
| `img/` | Hero pictures (24 files) |
| `vendor/three.min.js` | 3D engine (three.js r128), included so the game never loads it from a CDN |
| `vendor/peerjs.min.js` | Peer-to-peer connections for multiplayer |
| `config.js` | Optional settings: leaderboard server and multiplayer options |
| `supabase.sql` | One-time setup for the leaderboard |
| `.nojekyll` | Tells GitHub Pages to serve the files as they are |

The passphrase on the first screen is set in `index.html`: search for `const PW =`. It is only a speed bump, since
anyone can read it in the page source.

---

## Put it on GitHub Pages

1. **Make a GitHub account** at github.com if you do not have one.
2. **Create a repository.** Click the **+** at the top right, then **New repository**. Name it, for example,
   `chronoshard-catacombs`. Choose **Public** (free Pages needs a public repository on a free account). Leave the
   README and .gitignore options unticked. Click **Create repository**.
3. **Upload the files.** On the new empty repository page click **uploading an existing file**.
   Unzip this package on your computer, then drag **everything inside the folder** into the browser window: `index.html`,
   `config.js`, `supabase.sql`, `README.md`, `.nojekyll`, and the `img` and `vendor` folders.
   Dragging folders keeps their structure. If `.nojekyll` is hidden on your computer, skip it; the game still works.
   Write a message like "Add game", then click **Commit changes**.
   (The `img` folder has 24 files and `vendor` has 2, well under GitHub's limits.)
4. **Turn on Pages.** In the repository click **Settings**, then **Pages** in the left menu. Under **Build and
   deployment**, set **Source** to **Deploy from a branch**. Set **Branch** to `main` and the folder to `/ (root)`,
   then click **Save**.
5. **Wait about a minute, then open your link:** `https://YOUR-USERNAME.github.io/chronoshard-catacombs/`
   (the Pages settings page shows the exact address). Send that link to your players.

To update the game later, open the file on GitHub, click the pencil icon (or **Add file, Upload files**), and commit.
The site refreshes in a minute or two.

---

## Multiplayer

1. Everyone opens the game link and enters the passphrase.
2. The host clicks **Multiplayer**, types a name and clicks **Host a game**. A 5-letter room code appears
   (and a link that opens straight to the lobby).
3. Other players click **Multiplayer**, enter their name and the code, and click **Join**.
4. The host clicks **Choose heroes and start**, picks the party, mode and difficulty as usual, and uses
   **Who plays whom** to choose who commands each hero. Then **Start the multiplayer game**.
5. In play, the bar under the hint shows which hero is active and who controls it. Only that player can act for the
   hero (the host can always act, in case someone drops out). If someone leaves, their heroes go to the host.

How it works: every browser runs the same game from the same random seed. Each command goes to the host, who checks
the sender controls that hero, numbers it and relays it to everyone, so all screens stay identical. Connections are
direct between browsers; the free public PeerJS cloud only introduces players to each other.

Good to know:
- The host's browser tab is the room. If the host closes it, the game ends for everyone.
- Multiplayer games start fresh and are not saved or ranked. Solo save files work as before.
- Selection-room choices (loot, shop, skill picks for other heroes, moving on) are the host's. Players can equip
  gear, use potions and pick skills for their own heroes.
- Most home networks work. Strict school or company networks can block direct connections; if players cannot join,
  add a TURN server under `iceServers` in `config.js` (a free account at metered.ca or similar works).
- If a player's screen ever drifts out of step the bar shows "Out of sync". Leave and rejoin.
- To run your own signalling server instead of the public one, see the `peerHost` settings in `config.js`
  (open-source `peerjs-server`).

---

## Leaderboard (optional, free)

The leaderboard ranks every named save file by enemies killed, damage done and crystals (Chronoshards) recovered.
Scores post after each boss. It needs a small online database; the free Supabase plan is plenty.

1. Go to supabase.com, sign up and click **New project**. Pick any name and password and wait for it to finish.
2. Open **SQL Editor**, click **New query**, paste the contents of `supabase.sql` and click **Run**.
3. Open **Project Settings, API**. Copy the **Project URL** and the **anon public** key.
   (Never use the `service_role` key.)
4. In your GitHub repository open `config.js`, click the pencil icon, paste the two values between the quotes for
   `supabaseUrl` and `supabaseKey`, and commit.
5. Reload the game. **Leaderboard** on the main menu now shows scores. New worlds ask for a save name and a player
   name; both appear on the board.

Anyone with the link can post scores, so treat the board as friendly rather than cheat-proof. To clear it, open
**Table Editor, scores** in Supabase and delete rows.

---

## Running it on your own computer

Browsers block some features when a page is opened as a file, so serve the folder instead. With Python installed,
open a terminal in the folder and run `python3 -m http.server 8000`, then visit http://localhost:8000.

