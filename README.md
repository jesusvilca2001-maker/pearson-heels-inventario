# Inventario Pearson Heels

Sistema web de inventario de calzado con login por usuario y contraseña.
No depende de Claude ni de ninguna otra herramienta de IA: es un sitio
independiente, en la cuenta de GitHub/Vercel/Supabase del cliente.

## Qué necesitas crear (todo gratis)

1. Una cuenta en **[Supabase](https://supabase.com)** → la base de datos y el login.
2. Una cuenta en **[GitHub](https://github.com)** → donde vive el código.
3. Una cuenta en **[Vercel](https://vercel.com)** → donde se publica el sitio (puedes entrar con la misma cuenta de GitHub).

---

## Paso 1 — Crear el proyecto en Supabase

1. Entra a [supabase.com](https://supabase.com) y crea un **New project**.
   Ponle un nombre (ej. `pearson-heels-inventario`) y una contraseña de base de datos (guárdala en un lugar seguro; no es la contraseña de ningún usuario del sistema, es solo interna).
2. Espera 1-2 minutos a que el proyecto termine de crearse.
3. Ve al menú lateral **SQL Editor** → **New query**.
4. Abre el archivo `schema.sql` de esta carpeta, copia todo su contenido, pégalo ahí y dale a **Run**.
   Esto crea las 3 tablas (`modelos`, `movimientos`, `comentarios`) y las reglas de seguridad.
5. Ve a **Authentication → Providers → Email** y **desactiva** la opción "Confirm email".
   (Así, cuando crees un usuario, puede entrar de inmediato sin tener que confirmar un correo real.)
6. Ve a **Authentication → Users → Add user** y crea un usuario por cada persona del equipo que va a usar el sistema (correo + contraseña). Puedes usar correos como `deisy@pearsonheels.com` aunque no reciban ese correo de verdad — solo se usan como usuario de acceso.
7. Ve a **Settings → API** y copia dos valores:
   - **Project URL**
   - **anon public** (dentro de "Project API keys")

## Paso 2 — Completar `config.js`

Abre el archivo `config.js` de esta carpeta y reemplaza los dos valores de ejemplo con los que copiaste en el paso anterior:

```js
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOi....";
```

Guarda el archivo.

## Paso 3 — Subir el proyecto a GitHub

1. Entra a GitHub y crea un repositorio nuevo (puede ser privado), por ejemplo `pearson-heels-inventario`.
2. Sube estos archivos tal cual están (por la web de GitHub con "Add file → Upload files", o con `git` si lo prefieres):
   - `index.html`
   - `config.js` (ya con tus datos reales)
   - `schema.sql`
   - `vercel.json`
   - `README.md`

## Paso 4 — Publicar en Vercel

1. Entra a [vercel.com](https://vercel.com) e inicia sesión con tu cuenta de GitHub.
2. Dale a **Add New → Project** y elige el repositorio que acabas de crear.
3. Vercel lo va a detectar como sitio estático — no hace falta tocar ninguna configuración de "Framework" ni "Build command". Solo dale a **Deploy**.
4. En un minuto te da un link tipo `https://pearson-heels-inventario.vercel.app` — ese es el sistema, ya en línea.

## Cómo entran los usuarios

Cada persona entra con el correo y contraseña que creaste para ella en el
**Paso 1.6**. Si más adelante necesitas agregar o quitar usuarios, lo haces
desde Supabase → **Authentication → Users**, sin tocar el código ni
volver a publicar nada.

## Actualizaciones futuras

Cualquier cambio al sistema es: editar `index.html`, subir el cambio a GitHub,
y Vercel lo vuelve a publicar solo, automáticamente, en unos segundos.

## Independencia

Este sistema no usa Claude, Claude Code ni ningún producto de Anthropic para
funcionar. Corre enteramente sobre GitHub + Vercel + Supabase, todas cuentas
propias del cliente. Si en algún momento se deja de usar Claude, el sistema
sigue funcionando exactamente igual.
