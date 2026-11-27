-- Leaderboard table for Guardians of the Chronoshard Catacombs.
-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.
create table if not exists public.scores (
  player_id   text        not null,
  slot        int         not null,
  save_name   text        not null,
  player_name text        not null default '',
  kills       bigint      not null default 0,
  damage      bigint      not null default 0,
  crystals    int         not null default 0,
  progress    text        not null default '',
  world       text        not null default 'campaign',
  difficulty  text        not null default '',
  updated_at  timestamptz not null default now(),
  primary key (player_id, slot)
);

alter table public.scores enable row level security;

-- Anyone with the game link can read the board and post their own scores.
create policy "scores are readable"  on public.scores for select using (true);
create policy "scores can be added"  on public.scores for insert with check (
  char_length(save_name) between 1 and 24 and kills >= 0 and damage >= 0 and crystals between 0 and 5);
create policy "scores can be updated" on public.scores for update using (true) with check (
  char_length(save_name) between 1 and 24 and kills >= 0 and damage >= 0 and crystals between 0 and 5);
create policy "scores can be removed" on public.scores for delete using (true);
