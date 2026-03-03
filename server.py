import sqlite3
import secrets
import hashlib
import time

from flask import Flask, request, jsonify, redirect, session

app = Flask(__name__)
app.secret_key = "ZX_SECRET_KEY"

DATABASE = "zxauth.db"
ZX_SECRET = "SUA_CHAVE_SECRETA_AQUI"

ADMIN_USER = "admin"
ADMIN_PASS = "Chave"
SYSTEM_ENABLED = True

# ==========================
# DATABASE INIT
# ==========================

def get_db():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    db = get_db()

    db.execute("""
        CREATE TABLE IF NOT EXISTS users (
            userid TEXT PRIMARY KEY,
            generated_key TEXT,
            active INTEGER,
            created_at INTEGER
        )
    """)

    db.execute("""
        CREATE TABLE IF NOT EXISTS ip_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userid TEXT,
            ip TEXT,
            timestamp INTEGER
        )
    """)

    db.execute("""
        CREATE TABLE IF NOT EXISTS banned_ips (
            ip TEXT PRIMARY KEY,
            created_at INTEGER
        )
    """)

    db.commit()
    db.close()

init_db()

# ==========================
# HELPER
# ==========================

def get_ip():
    if request.headers.get("X-Forwarded-For"):
        return request.headers.get("X-Forwarded-For").split(",")[0]
    return request.remote_addr

def is_ip_banned(ip):
    db = get_db()
    row = db.execute("SELECT * FROM banned_ips WHERE ip = ?", (ip,)).fetchone()
    db.close()
    return row is not None

# ==========================
# AUTH
# ==========================

@app.route("/auth", methods=["POST"])
def auth():
    global SYSTEM_ENABLED

    ip = get_ip()

    if is_ip_banned(ip):
        return jsonify({"valid": False, "reason": "IP banned"}), 403

    if not SYSTEM_ENABLED:
        return jsonify({"valid": False, "reason": "System disabled"}), 403

    secret = request.headers.get("X-App-Auth")
    if secret != ZX_SECRET:
        return jsonify({"valid": False, "reason": "Unauthorized"}), 403

    data = request.get_json()
    if not data or "userid" not in data:
        return jsonify({"valid": False, "reason": "Missing userid"}), 400

    userid = str(data["userid"])

    db = get_db()

    # Log IP
    db.execute(
        "INSERT INTO ip_logs (userid, ip, timestamp) VALUES (?, ?, ?)",
        (userid, ip, int(time.time()))
    )

    row = db.execute(
        "SELECT * FROM users WHERE userid = ?",
        (userid,)
    ).fetchone()

    if row is None:
        random_part = secrets.token_hex(8)
        generated_key = hashlib.sha256(
            (userid + random_part).encode()
        ).hexdigest()

        db.execute(
            "INSERT INTO users VALUES (?, ?, ?, ?)",
            (userid, generated_key, 1, int(time.time()))
        )
        db.commit()
        db.close()

        return jsonify({"valid": True, "new_account": True})

    if row["active"] == 0:
        db.close()
        return jsonify({"valid": False, "reason": "User banned"}), 403

    db.commit()
    db.close()

    return jsonify({"valid": True})

# ==========================
# ADMIN LOGIN (TEXT ONLY)
# ==========================

@app.route("/admin-login", methods=["POST"])
def admin_login():
    data = request.get_json()

    if not data:
        return "Send JSON: {username, password}"

    if data.get("username") == ADMIN_USER and data.get("password") == ADMIN_PASS:
        session["admin"] = True
        return "Login successful"

    return "Invalid credentials"

# ==========================
# DASHBOARD (TEXT)
# ==========================

@app.route("/admin-panel")
def admin_panel():
    if not session.get("admin"):
        return "Unauthorized"

    db = get_db()

    users = db.execute("SELECT * FROM users").fetchall()
    banned_ips = db.execute("SELECT * FROM banned_ips").fetchall()

    output = "=== ZX ADMIN PANEL ===\n\n"

    output += f"System Enabled: {SYSTEM_ENABLED}\n\n"

    output += "Users:\n"
    for u in users:
        output += f"- {u['userid']} | Active: {bool(u['active'])}\n"

    output += "\nBanned IPs:\n"
    for ip in banned_ips:
        output += f"- {ip['ip']}\n"

    db.close()
    return output

# ==========================
# BAN USER
# ==========================

@app.route("/ban-user/<userid>")
def ban_user(userid):
    if not session.get("admin"):
        return "Unauthorized"

    db = get_db()
    db.execute("UPDATE users SET active = 0 WHERE userid = ?", (userid,))
    db.commit()
    db.close()

    return f"User {userid} banned."

# ==========================
# BAN IP
# ==========================

@app.route("/ban-ip/<ip>")
def ban_ip(ip):
    if not session.get("admin"):
        return "Unauthorized"

    db = get_db()
    db.execute(
        "INSERT OR IGNORE INTO banned_ips VALUES (?, ?)",
        (ip, int(time.time()))
    )
    db.commit()
    db.close()

    return f"IP {ip} banned."

# ==========================
# TOGGLE SYSTEM
# ==========================

@app.route("/toggle-system")
def toggle_system():
    global SYSTEM_ENABLED
    if not session.get("admin"):
        return "Unauthorized"

    SYSTEM_ENABLED = not SYSTEM_ENABLED
    return f"System Enabled: {SYSTEM_ENABLED}"

# ==========================
# HOME
# ==========================

@app.route("/")
def home():
    return "ZXAuth Online"

# ==========================
# RUN
# ==========================

if __name__ == "__main__":
    app.run()
