import os
import sqlite3
import secrets
import hashlib
import time

from flask import (
    Flask,
    request,
    jsonify,
    render_template,
    redirect,
    session,
)

app = Flask(__name__)
app.secret_key = "ZX_SUPER_SECRET_KEY"

# ===== Configuração =====

DATABASE_PATH = "zxauth.db"
ZX_SECRET = "SUA_CHAVE_SECRETA_AQUI"

ADMIN_USER = "admin"
ADMIN_PASS = "Chave"
SYSTEM_ENABLED = True
ADMIN_SESSION_TIME = 1800

# ===========================
# SQLITE HELPER FUNCTIONS
# ===========================

def get_db():
    conn = sqlite3.connect(DATABASE_PATH)
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
        );
    """)
    db.commit()
    db.close()

init_db()

# ===========================
# STATUS & HOME
# ===========================

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/status")
def status():
    return {"status": "online", "system_enabled": SYSTEM_ENABLED}

# ===========================
# AUTH ROUTE (CLIENT)
# ===========================

@app.route("/auth", methods=["POST"])
def auth():
    global SYSTEM_ENABLED

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
            "INSERT INTO users (userid, generated_key, active, created_at) VALUES (?, ?, ?, ?)",
            (userid, generated_key, 1, int(time.time()))
        )
        db.commit()
        db.close()

        return jsonify({
            "valid": True,
            "new_account": True,
            "generated_key": generated_key
        })

    if row["active"] == 0:
        db.close()
        return jsonify({"valid": False, "reason": "User banned"}), 403

    generated_key = row["generated_key"]
    db.close()

    return jsonify({"valid": True, "generated_key": generated_key})

# ===========================
# ADMIN LOGIN
# ===========================

@app.route("/admin-login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        user = request.form.get("username")
        pwd = request.form.get("password")

        if user == ADMIN_USER and pwd == ADMIN_PASS:
            session["admin"] = True
            session["login_time"] = int(time.time())
            return redirect("/admin-panel")

    return render_template("admin_login.html")

# ===========================
# ADMIN PANEL
# ===========================

@app.route("/admin-panel")
def admin_panel():
    if not session.get("admin"):
        return redirect("/admin-login")

    if "login_time" in session:
        if int(time.time()) - session["login_time"] > ADMIN_SESSION_TIME:
            session.clear()
            return redirect("/admin-login")

    db = get_db()
    rows = db.execute("SELECT * FROM users").fetchall()
    users = [dict(row) for row in rows]
    db.close()

    return render_template(
        "admin_panel.html",
        users=users,
        system_enabled=SYSTEM_ENABLED,
    )

# ===========================
# TOGGLE USER BAN
# ===========================

@app.route("/toggle-ban/<userid>")
def toggle_ban(userid):
    if not session.get("admin"):
        return redirect("/admin-login")

    db = get_db()
    row = db.execute(
        "SELECT * FROM users WHERE userid = ?",
        (userid,)
    ).fetchone()

    if row:
        new_status = 0 if row["active"] == 1 else 1
        db.execute(
            "UPDATE users SET active = ? WHERE userid = ?",
            (new_status, userid)
        )
        db.commit()

    db.close()
    return redirect("/admin-panel")

# ===========================
# KILL SWITCH
# ===========================

@app.route("/toggle-system")
def toggle_system():
    global SYSTEM_ENABLED

    if not session.get("admin"):
        return redirect("/admin-login")

    SYSTEM_ENABLED = not SYSTEM_ENABLED
    return redirect("/admin-panel")

# ===========================
# ADMIN LOGOUT
# ===========================

@app.route("/admin-logout")
def admin_logout():
    session.clear()
    return redirect("/admin-login")

# ===========================
# RUN
# ===========================

if __name__ == "__main__":
    app.run()
