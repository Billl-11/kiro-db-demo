# Kiro Database Demo

Demo project showing how Kiro connects to a PostgreSQL database and generates reports (DOCX, XLSX, PPTX) from live data.

## Folder Structure

```
kiro-db-demo/
├── setup/                  # Database setup (run BEFORE opening Kiro)
│   ├── docker-compose.yml
│   ├── seed.sql
│   └── seed.py
└── workspace/              # Open THIS folder in Kiro
    ├── .kiro/
    │   ├── settings/mcp.json
    │   └── skills/
    └── .gitignore
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [uv](https://docs.astral.sh/uv/getting-started/installation/) (Python package manager)

## Setup (one-time)

### 1. Start PostgreSQL

```bash
cd setup
docker compose up -d
```

### 2. Seed the database

```bash
uv run seed.py
```

### 3. Verify the database is running

```bash
docker exec setup-postgres-1 psql -U demo -d bank_demo -c "SELECT count(*) FROM customers;"
```

You should see `15` rows.

## Using Kiro

Open the `workspace/` folder in Kiro. It only has:
- MCP config to connect to PostgreSQL
- Skills for generating reports

Kiro has **no access** to the seed data or setup scripts — it can only discover the database through the MCP server.

## Example Prompts

- "Show me all overdue loans"
- "Generate a loan portfolio summary report as XLSX"
- "Create a Word document with monthly transaction report for March 2025"
- "Make a presentation showing loan distribution by type"
- "What is the total outstanding balance by loan type?"

## Cleanup

```bash
cd setup
docker compose down -v
```
