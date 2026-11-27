/* Optional settings. Everything works with these left blank, except the Leaderboard (needs Supabase) */
window.CCC_CONFIG = {
  /* Leaderboard: paste your Supabase project URL and the public "anon" key (see README). Leave blank to turn it off. */
  supabaseUrl: "",
  supabaseKey: "",

  /* Multiplayer signalling: blank uses the free public PeerJS cloud (no account needed).
     To run your own, fill these in. */
  peerHost: "",
  peerPort: 443,
  peerPath: "/",
  peerSecure: true,

  /* Optional TURN servers for players behind strict firewalls, e.g.
     [{ urls: "stun:stun.l.google.com:19302" }, { urls: "turn:YOUR_HOST:3478", username: "u", credential: "p" }] */
  iceServers: []
};
