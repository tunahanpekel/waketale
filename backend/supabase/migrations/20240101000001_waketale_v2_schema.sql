-- Waketale v2 — Initial schema migration
-- Run order: 1

-- ─── Enable extensions ──────────────────────────────────────────────────────
-- uuid-ossp not needed — gen_random_uuid() is built-in (PostgreSQL 14+)
-- pg_cron not available on free tier — removed

-- ─── Users (profile) ────────────────────────────────────────────────────────
create table if not exists public.users (
  id                    uuid references auth.users(id) on delete cascade primary key,
  email                 text,
  display_name          text,
  timezone              text default 'UTC',
  cbti_week             int  default 1 check (cbti_week between 1 and 8),
  program_start_date    date,
  bedtime_target        time,
  wake_target           time,
  current_streak        int  default 0,
  longest_streak        int  default 0,
  apple_health_enabled  boolean default false,
  google_fit_enabled    boolean default false,
  notification_bedtime  boolean default true,
  notification_morning  boolean default true,
  notification_hour     int  default 22,
  notification_minute   int  default 0,
  created_at            timestamptz default now(),
  updated_at            timestamptz default now()
);

alter table public.users enable row level security;

create policy "users: own row only"
  on public.users
  using (auth.uid() = id);

-- Trigger: auto-create user row on sign-up
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.users (id, email)
  values (new.id, new.email)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Trigger: updated_at
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger users_updated_at
  before update on public.users
  for each row execute function public.set_updated_at();


-- ─── Sleep check-ins ─────────────────────────────────────────────────────────
create table if not exists public.sleep_check_ins (
  id                      uuid default gen_random_uuid() primary key,
  user_id                 uuid references public.users(id) on delete cascade not null,
  date                    date not null,
  bedtime                 timestamptz,
  wake_time               timestamptz,
  sleep_latency_minutes   int  check (sleep_latency_minutes >= 0),
  wake_episodes           int  check (wake_episodes >= 0),
  mood_rating             int  check (mood_rating between 1 and 5),
  sleep_score             int  check (sleep_score between 0 and 100),
  sleep_efficiency        numeric(5,4) check (sleep_efficiency between 0 and 1),
  total_sleep_minutes     int  check (total_sleep_minutes >= 0),
  coach_insight           text,
  is_wearable_data        boolean default false,
  created_at              timestamptz default now(),
  unique(user_id, date)   -- one check-in per day per user
);

alter table public.sleep_check_ins enable row level security;

create policy "sleep_check_ins: own rows only"
  on public.sleep_check_ins
  using (auth.uid() = user_id);

create index sleep_check_ins_user_date_idx
  on public.sleep_check_ins(user_id, date desc);


-- ─── Action plans ────────────────────────────────────────────────────────────
create table if not exists public.action_plans (
  id          uuid default gen_random_uuid() primary key,
  user_id     uuid references public.users(id) on delete cascade not null,
  check_in_id uuid references public.sleep_check_ins(id) on delete cascade,
  date        date not null,
  steps       jsonb not null default '[]',
  created_at  timestamptz default now(),
  unique(user_id, date)
);

alter table public.action_plans enable row level security;

create policy "action_plans: own rows only"
  on public.action_plans
  using (auth.uid() = user_id);

create index action_plans_user_date_idx
  on public.action_plans(user_id, date desc);


-- ─── Coach chat history ──────────────────────────────────────────────────────
create table if not exists public.coach_chat_history (
  id         uuid default gen_random_uuid() primary key,
  user_id    uuid references public.users(id) on delete cascade not null,
  role       text not null check (role in ('user', 'assistant', 'system')),
  content    text not null,
  created_at timestamptz default now()
);

alter table public.coach_chat_history enable row level security;

create policy "coach_chat_history: own rows only"
  on public.coach_chat_history
  using (auth.uid() = user_id);

create index coach_chat_history_user_created_idx
  on public.coach_chat_history(user_id, created_at desc);


-- ─── Bedtime routines ────────────────────────────────────────────────────────
create table if not exists public.bedtime_routines (
  id                uuid default gen_random_uuid() primary key,
  user_id           uuid references public.users(id) on delete cascade not null,
  wind_down_steps   jsonb not null default '[]',
  morning_steps     jsonb not null default '[]',
  updated_at        timestamptz default now(),
  unique(user_id)
);

alter table public.bedtime_routines enable row level security;

create policy "bedtime_routines: own row only"
  on public.bedtime_routines
  using (auth.uid() = user_id);


-- ─── Sleep sessions (passive tracking) ───────────────────────────────────────
create table if not exists public.sleep_sessions (
  id              uuid default gen_random_uuid() primary key,
  user_id         uuid references public.users(id) on delete cascade not null,
  start_time      timestamptz not null,
  end_time        timestamptz,
  phase_events    jsonb not null default '[]',
  status          text not null default 'active' check (status in ('active', 'completed', 'cancelled')),
  smart_alarm     jsonb,
  check_in_id     uuid references public.sleep_check_ins(id),
  created_at      timestamptz default now()
);

alter table public.sleep_sessions enable row level security;

create policy "sleep_sessions: own rows only"
  on public.sleep_sessions
  using (auth.uid() = user_id);

create index sleep_sessions_user_created_idx
  on public.sleep_sessions(user_id, created_at desc);


-- ─── Streaks ─────────────────────────────────────────────────────────────────
create table if not exists public.streaks (
  id              uuid default gen_random_uuid() primary key,
  user_id         uuid references public.users(id) on delete cascade not null,
  streak_date     date not null,
  streak_count    int not null default 1,
  created_at      timestamptz default now(),
  unique(user_id, streak_date)
);

alter table public.streaks enable row level security;

create policy "streaks: own rows only"
  on public.streaks
  using (auth.uid() = user_id);
