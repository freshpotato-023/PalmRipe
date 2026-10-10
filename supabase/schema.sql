-- Run this in the Supabase SQL editor. User-scoped history for PalmRipe scans.
create table if not exists public.scans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  image_name text not null,
  ripeness text not null check (ripeness in ('unripe','underripe','ripe')),
  confidence numeric(5,2) not null,
  method text not null,
  notes text
);
alter table public.scans enable row level security;
create policy "Users can read own scans" on public.scans for select to authenticated using (auth.uid() = user_id);
create policy "Users can insert own scans" on public.scans for insert to authenticated with check (auth.uid() = user_id);
create policy "Users can delete own scans" on public.scans for delete to authenticated using (auth.uid() = user_id);
