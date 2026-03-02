from flask import Flask, request, jsonify, render_template, redirect, session
import os
import json
import secrets
import hashlib
import time

app = Flask(__name__)
app.secret_key = "zx_super_secret_key"

# ==============================
# CONFIGURAÇÕES
# ==============================

USERS_FOLDER = "USERS"
ADMIN_USER = "admin"
ADMIN_PASS = "Chave"
SYSTEM_ENABLED = True
ADMIN_SESSION_TIME = 1800  # 30 min session

# ===== Cria USERS se não existir
if not os.path.exists(USERS_FOLDER):
    os.makedirs(USERS_FOLDER)

# ==============================
# FUNÇÕES AUXILIARES
# ==============================

def user_file(userid):
    return os.path.join(USERS_FOLDER, f"{userid}.json")

def load_user(userid):
    path = user_file(userid)
    if not os.path.exists(path):
        return None
    with open(path, "r") as f:
        return json.load(f)

def save_user_data(userid, data):
    with open(user_file(userid), "w") as f:
        json.dump(data, f, indent=4)

def list_users():
    return [
        f.replace(".json", "")
        for f in os.listdir(USERS_FOLDER)
        if f.endswith(".json")
    ]

# ==============================
# HOME E STATUS
# ==============================

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/status")
def status():
    return {"status": "online", "system_enabled": SYSTEM_ENABLED}

# ==============================
# AUTENTICAÇÃO
# ==============================

@app.route("/auth", methods=["GET", "POST"])
@app.route("/auth/", methods=["GET", "POST"])
def auth():
    global SYSTEM_ENABLED

    if not SYSTEM_ENABLED:
        return jsonify({"valid": False, "reason": "System disabled"})

    # Captura userid
    userid = request.args.get("userid") or request.form.get("userid")
    if not userid:
        return jsonify({"valid": False, "reason": "Missing userid"})

    # Se usuário não existe → cria
    data = load_user(userid)
    if data is None:
        # gera key única
        random_part = secrets.token_hex(8)
        gen_key = hashlib.sha256((userid + random_part).encode()).hexdigest()
        data = {
            "userid": userid,
            "generated_key": gen_key,
            "active": True,
            "created_at": int(time.time())
        }
        save_user_data(userid, data)
        return jsonify({"valid": True, "new_account": True, "generated_key": gen_key})

    # válido apenas se ativo
    if not data.get("active", False):
        return jsonify({"valid": False, "reason": "User banned"})

    return jsonify({"valid": True, "generated_key": data.get("generated_key")})

# ==============================
# ADMIN LOGIN
# ==============================

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

# ==============================
# ADMIN PANEL
# ==============================

@app.route("/admin-panel")
def admin_panel():
    if not session.get("admin"):
        return redirect("/admin-login")

    # Verifica sessão
    if "login_time" in session:
        if int(time.time()) - session["login_time"] > ADMIN_SESSION_TIME:
            session.clear()
            return redirect("/admin-login")

    users = [load_user(u) for u in list_users()]

    return render_template("admin_panel.html", users=users, system_enabled=SYSTEM_ENABLED)

# ==============================
# BAN / TOGGLE / LOGOUT
# ==============================

@app.route("/toggle-ban/<userid>")
def toggle_ban(userid):
    if not session.get("admin"):
        return redirect("/admin-login")

    data = load_user(userid)
    if data:
        data["active"] = not data.get("active", True)
        save_user_data(userid, data)

    return redirect("/admin-panel")

@app.route("/toggle-system")
def toggle_system():
    global SYSTEM_ENABLED
    if not session.get("admin"):
        return redirect("/admin-login")
    SYSTEM_ENABLED = not SYSTEM_ENABLED
    return redirect("/admin-panel")

@app.route("/admin-logout")
def admin_logout():
    session.clear()
    return redirect("/admin-login")

# ==============================
# RUN
# ==============================

if __name__ == "__main__":
    app.run(port=5000)
