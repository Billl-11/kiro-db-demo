# /// script
# requires-python = ">=3.10"
# dependencies = ["psycopg2-binary"]
# ///
"""Seed the PostgreSQL database with sample banking data."""
import psycopg2
from pathlib import Path

DB_PARAMS = {
    "host": "localhost",
    "port": 5432,
    "dbname": "bank_demo",
    "user": "demo",
    "password": "demo123",
}

def main():
    sql = Path(__file__).parent.joinpath("seed.sql").read_text()
    conn = psycopg2.connect(**DB_PARAMS)
    cur = conn.cursor()
    cur.execute(sql)
    conn.commit()
    cur.close()
    conn.close()
    print("✅ Database seeded successfully")

if __name__ == "__main__":
    main()
