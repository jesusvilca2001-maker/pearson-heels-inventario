-- ==========================================================
-- ESQUEMA DE BASE DE DATOS — Inventario Pearson Heels
-- ==========================================================
-- Cómo usarlo:
-- 1. Entra a tu proyecto en https://supabase.com
-- 2. Ve al menú "SQL Editor" (ícono de una hoja/consola)
-- 3. Pega TODO este archivo y dale a "Run"
-- Se crean 3 tablas y las reglas de seguridad (RLS) para que
-- solo usuarios que iniciaron sesión puedan leer y escribir.
-- ==========================================================

create extension if not exists "pgcrypto";

-- Catálogo de modelos únicos (Modelo + Taco + Color)
create table if not exists modelos (
  id uuid primary key default gen_random_uuid(),
  modelo text not null,
  taco integer not null,
  color text not null,
  codigo text not null,
  created_at timestamptz not null default now()
);

-- Ingresos y ventas (el historial completo)
create table if not exists movimientos (
  id uuid primary key default gen_random_uuid(),
  tipo text not null check (tipo in ('ingreso', 'venta')),
  modelo text not null,
  taco integer not null,
  color text not null,
  talla integer not null,
  cantidad integer not null,
  fecha date not null,
  cliente text,
  tipo_venta text,
  canal text,
  pago text,
  created_at timestamptz not null default now()
);

-- Comentarios internos por modelo (Dashboard)
create table if not exists comentarios (
  group_key text primary key,
  texto text not null,
  updated_at timestamptz not null default now()
);

-- ---------- Seguridad (Row Level Security) ----------
-- Solo alguien con sesión iniciada (usuario y contraseña válidos)
-- puede leer o escribir. Nadie más puede ver ni tocar los datos,
-- ni siquiera con el link del sitio.

alter table modelos enable row level security;
alter table movimientos enable row level security;
alter table comentarios enable row level security;

drop policy if exists "modelos_auth_all" on modelos;
create policy "modelos_auth_all" on modelos
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

drop policy if exists "movimientos_auth_all" on movimientos;
create policy "movimientos_auth_all" on movimientos
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

drop policy if exists "comentarios_auth_all" on comentarios;
create policy "comentarios_auth_all" on comentarios
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

-- ---------- Tiempo real (opcional pero recomendado) ----------
-- Permite que si dos personas tienen el sistema abierto a la vez,
-- vean los cambios de la otra sin tener que recargar la página.
alter publication supabase_realtime add table modelos;
alter publication supabase_realtime add table movimientos;
alter publication supabase_realtime add table comentarios;
