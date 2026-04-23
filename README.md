# Zen & Musashi

> **Japanese wisdom for your terminal.**
>
> Local by default. Oracle optional.

`zen-and-musashi` is a Ruby command-line tool that delivers Zen and Musashi-style wisdom directly in your terminal. It requires **no API key**, runs entirely **offline**, and selects a fresh quote at random every time you invoke it.

If you want richer, AI-generated responses, an optional LLM shelf is available—but the sword is sharp before the oracle wakes.

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
  - [`zen` — Calm Reflection](#zen--calm-reflection)
  - [`musashi` — Direct Critique](#musashi--direct-critique)
  - [`add` — Add a Quote](#add--add-a-quote)
  - [`list` — List Quotes](#list--list-quotes)
  - [`remove` — Remove a Quote](#remove--remove-a-quote)
- [Optional LLM Mode](#optional-llm-mode)
- [Database](#database)
- [Configuration & Data Location](#configuration--data-location)
- [Development](#development)
- [Publishing](#publishing)
- [License](#license)

---

## Features

| Feature | Description |
|---------|-------------|
| **100% Local** | No network calls, no API keys, no cloud dependency. |
| **Random Selection** | Every invocation returns a different quote from the database. |
| **Curated Seed Data** | Ships with 60 hand-picked quotes (30 Zen, 30 Musashi). |
| **Quote Management** | Add, list, and remove your own quotes via CLI. |
| **Zero Runtime Dependencies** | Uses only Ruby standard library (`pstore`, `optparse`, `net/http`). |
| **Optional LLM Mode** | Drop-in Anthropic Claude support when you want model-generated responses. |

---

## Installation

### From RubyGems (recommended)

```bash
gem install zen-and-musashi
```

### From Source

```bash
git clone https://github.com/YumaKakuya/zenandmusashi.git
cd zenandmusashi
rake install
# or
gem build zen-and-musashi.gemspec
gem install zen-and-musashi-0.3.0.gem
```

### Requirements

- Ruby >= 3.0.0

No external gems are required for local mode.

---

## Quick Start

```bash
# Zen mode — calm, poetic reflection
musashi zen "My code has a bug"

# Musashi mode — direct, tactical critique
musashi musashi "My code has a bug"
```

Example output:

```text
$ musashi zen "My code has a bug"
The obstacle is the path.

$ musashi musashi "My code has a bug"
A dull blade is worse than no blade. Sharpen it or leave it.
```

Run the same command again and you will get a **different** quote.

---

## Commands

### `zen` — Calm Reflection

Returns a randomly selected Zen quote.

```bash
musashi zen [options] [input]
```

**Options:**
- `--llm` — Use Anthropic Claude instead of the local database.
- `--api-key KEY` — Provide an API key for this invocation only.

**Examples:**

```bash
musashi zen "Should I refactor this?"
musashi zen --llm "Should I refactor this?"
musashi zen --llm --api-key sk-ant-xxxxx "Should I refactor this?"
```

### `musashi` — Direct Critique

Returns a randomly selected Musashi quote.

```bash
musashi musashi [options] [input]
```

**Options:**
- `--llm` — Use Anthropic Claude instead of the local database.
- `--api-key KEY` — Provide an API key for this invocation only.

**Examples:**

```bash
musashi musashi "CI failed again"
musashi musashi --llm "CI failed again"
```

### `add` — Add a Quote

Add your own quote to the database.

```bash
musashi add "Your quote text here" --mode <zen|musashi>
```

**Constraints:**
- Maximum **200 characters**.
- Duplicate quotes are rejected.
- New quotes are automatically tagged as `composed`.

**Example:**

```bash
musashi add "The compiler is your first reviewer." --mode musashi
# => Added quote #31 to musashi mode.
```

### `list` — List Quotes

Display all quotes for a given mode, including their ID, type, and text.

```bash
musashi list --mode <zen|musashi>
```

**Example:**

```bash
musashi list --mode zen
```

Output:

```text
Quotes in zen mode (30 total):
----------------------------------------
  #1 [authentic]: Before enlightenment, chop wood, carry water...
  #2 [authentic]: The obstacle is the path.
  ...
  #16 [composed]: Still water holds the sky.
```

### `remove` — Remove a Quote

Delete a quote by its ID.

```bash
musashi remove <id> --mode <zen|musashi>
```

**Example:**

```bash
musashi remove 5 --mode zen
# => Removed quote #5 from zen mode.
```

---

## Optional LLM Mode

If you want richer, context-aware responses, enable the LLM shelf:

```bash
export ANTHROPIC_API_KEY=your_key_here
musashi zen --llm "My app has 47 dependencies"
```

You can also pass the key per-command:

```bash
musashi musashi --llm --api-key $ANTHROPIC_API_KEY "My code has a bug"
```

**Note:** LLM mode incurs API usage costs. Musashi counted his arrows. You should count your tokens.

---

## Database

Quotes are stored in a local PStore database. Each quote has the following structure:

| Field | Type | Description |
|-------|------|-------------|
| `id` | Integer | Auto-incrementing identifier |
| `text` | String | The quote itself (max 200 chars) |
| `type` | String | `authentic` (historical) or `composed` (original) |

### Seed Data

On first run, the database is automatically populated with:

- **Zen mode:** 15 authentic + 15 composed quotes
- **Musashi mode:** 15 authentic + 15 composed quotes

**Authentic quotes** are derived from historical Zen records and Miyamoto Musashi's *Go Rin no Sho* (The Book of Five Rings).  
**Composed quotes** are original writing in the same spirit.

All seed data is in English and verified to be under 200 characters.

---

## Configuration & Data Location

| Platform | Path |
|----------|------|
| Linux / macOS | `~/.config/zen-and-musashi/quotes.db` |
| Windows | `%USERPROFILE%\.config\zen-and-musashi\quotes.db` |

The directory is created automatically on first run.

---

## Development

### Setup

```bash
git clone https://github.com/YumaKakuya/zenandmusashi.git
cd zenandmusashi
```

### Running Locally

```bash
ruby -Ilib bin/musashi zen "test input"
```

### Running Tests

```bash
rake test
```

### Building the Gem

```bash
gem build zen-and-musashi.gemspec
```

This produces `zen-and-musashi-0.3.0.gem`.

---

## Publishing

1. Update `lib/zen_and_musashi/version.rb` with the new version.
2. Run `gem build zen-and-musashi.gemspec`.
3. Push to RubyGems:
   ```bash
   gem push zen-and-musashi-0.3.0.gem
   ```
4. Tag the release on GitHub:
   ```bash
   git tag v0.3.0
   git push origin v0.3.0
   ```

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

> *Before enlightenment, chop wood, carry water. After enlightenment, chop wood, carry water.*
