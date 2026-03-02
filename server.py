from flask import Flask, request, jsonify, session, redirect, render_template, render_template_string
import os
import time
import json

app = Flask(__name__)
app.secret_key = "zx_is_c00l"

# ===== CONFIG =====

SYSTEM_ENABLED = True  # Kill switch global

ADMIN_USER = "admin"
ADMIN_PASS = "Chave"  # troque aqui

# Lista de chaves válidas
VALID_KEYS = {
    "ABC123": {"banned": False},
    "ZX999": {"banned": False},
}

# Guarda info dos usuários (read/write em arquivo se quiser depois)
DATA_FOLDER = "users"
if not os.path.exists(DATA_FOLDER):
    os.makedirs(DATA_FOLDER)

# ===== ROTAS =====

@app.route("/")
def home():
    return {"status": "online", "system_enabled": SYSTEM_ENABLED}

@app.route("/status")
def status():
    return {"status": "online", "system_enabled": SYSTEM_ENABLED}

@app.route("/auth")
def auth():
    global SYSTEM_ENABLED

    if not SYSTEM_ENABLED:
        return jsonify({"valid": False, "reason": "System disabled"})

    key = request.args.get("key")

    if not key:
        return jsonify({"valid": False, "reason": "No key provided"})

    if key in VALID_KEYS:
        if VALID_KEYS[key]["banned"]:
            return jsonify({"valid": False, "reason": "Key banned"})
        return jsonify({"valid": True})

    return jsonify({"valid": False, "reason": "Invalid key"})

# ===== ADMIN LOGIN =====

@app.route("/admin-login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        user = request.form.get("username")
        password = request.form.get("password")

        if user == ADMIN_USER and password == ADMIN_PASS:
            session["admin"] = True
            session["login_time"] = int(time.time())
            return redirect("/admin-panel")

    return render_template_string("""
        <h2>ZX Admin Login</h2>
        <form method="POST">
            <input name="username" placeholder="Username"><br><br>
            <input name="password" type="password" placeholder="Password"><br><br>
            <button type="submit">Login</button>
        </form>
    """)

# ===== ADMIN PANEL =====

@app.route("/admin-panel")
def admin_panel():
    global SYSTEM_ENABLED

    if not session.get("admin"):
        return redirect("/admin-login")

    # controla sessão
    # (pode adicionar timeout se quiser futuramente)

    return render_template_string("""
        <h1>ZX Admin Panel</h1>

        <p><strong>Kill Switch:</strong> {{ "ENABLED" if system else "DISABLED" }}</p>
        <a href="/toggle-system">Toggle Kill Switch</a><br><br>

        <h3>Keys:</h3>
        {% for key, data in keys.items() %}
            <div>
                <strong>{{key}}</strong> → banned: {{data["banned"]}}
                <a href="/toggle-ban/{{key}}">[Toggle Ban]</a>
            </div>
        {% endfor %}
        <br>
        <a href="/admin-logout">Logout Admin</a>
    """, system=SYSTEM_ENABLED, keys=VALID_KEYS)

@app.route("/toggle-system")
def toggle_system():
    global SYSTEM_ENABLED
    if not session.get("admin"):
        return redirect("/admin-login")

    SYSTEM_ENABLED = not SYSTEM_ENABLED
    return redirect("/admin-panel")

@app.route("/toggle-ban/<key>")
def toggle_ban(key):
    if not session.get("admin"):
        return redirect("/admin-login")

    if key in VALID_KEYS:
        VALID_KEYS[key]["banned"] = not VALID_KEYS[key]["banned"]

    return redirect("/admin-panel")

@app.route("/admin-logout")
def admin_logout():
    session.clear()
    return redirect("/admin-login")

# ===== RUN =====

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 10000)))
