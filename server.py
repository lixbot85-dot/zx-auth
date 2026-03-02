from flask import Flask, request, jsonify, render_template, redirect, session
import os
import time
import json

app = Flask(__name__)
app.secret_key = "zx_super_secret_key"

# ==============================
# CONFIGURAÇÕES
# ==============================

DATA_FOLDER = "users"
MAX_REQUESTS = 5
STRIKE_LIMIT = 3
STRIKE_RESET_TIME = 300  # 5 min
BAN_TIMES = [60, 300, 900, 3600]  # 1m, 5m, 15m, 1h

DEFAULT_TIME = 3600  # 1 hora por usuário

ADMIN_PASSWORD = "Chave"
ADMIN_SESSION_TIME = 1800  # 30 min

# ==============================
# INICIALIZAÇÃO
# ==============================

if not os.path.exists(DATA_FOLDER):
    os.makedirs(DATA_FOLDER)

# ==============================
# FUNÇÕES DE USER
# ==============================

@app.route("/")
def home():
    return render_template("index.html")

def user_path(userid):
    return os.path.join(DATA_FOLDER, f"{userid}.txt")

def create_user(userid):
    data = {
        "time_left": DEFAULT_TIME,
        "last_login": int(time.time()),
        "requests": 0,
        "last_request_time": 0,
        "strikes": 0,
        "last_strike_time": 0,
        "ban_level": 0,
        "ban_until": 0
    }
    save_user(userid, data)
    return data

def read_user(userid):
    path = user_path(userid)
    if not os.path.exists(path):
        return create_user(userid)
    with open(path, "r") as f:
        return json.load(f)

def save_user(userid, data):
    with open(user_path(userid), "w") as f:
        json.dump(data, f)

# ==============================
# AUTH USER
# ==============================

@app.route("/status")
def status():
    return {"status": "online", "version": "1.0"}

@app.route("/auth", methods=["POST"])
def auth():

    if not request.is_json:
        return jsonify({"status": "invalid"}), 400

    data = request.json
    userid_raw = data.get("userid")

    if not userid_raw:
        return jsonify({"status": "invalid_user"}), 400

    userid = str(userid_raw).strip()

    if not userid.isdigit():
        return jsonify({"status": "invalid_user"}), 400

    user = read_user(userid)
    now = int(time.time())

    # BAN CHECK
    if now < user["ban_until"]:
        return jsonify({
            "status": "banned",
            "ban_remaining": user["ban_until"] - now
        }), 403

    # TEMPO
    elapsed = now - user["last_login"]
    user["time_left"] -= elapsed
    user["last_login"] = now

    if user["time_left"] <= 0:
        user["time_left"] = 0
        save_user(userid, user)
        return jsonify({"status": "expired"}), 403

    # RESET REQUEST POR MINUTO
    if now - user["last_request_time"] >= 60:
        user["requests"] = 0
        user["last_request_time"] = now

    user["requests"] += 1

    # STRIKE SYSTEM
    if user["requests"] > MAX_REQUESTS:

        if now - user["last_strike_time"] > STRIKE_RESET_TIME:
            user["strikes"] = 0

        user["strikes"] += 1
        user["last_strike_time"] = now

        if user["strikes"] >= STRIKE_LIMIT:

            user["ban_level"] += 1
            index = min(user["ban_level"] - 1, len(BAN_TIMES) - 1)
            ban_time = BAN_TIMES[index]

            user["ban_until"] = now + ban_time
            user["strikes"] = 0

            save_user(userid, user)

            return jsonify({
                "status": "banned",
                "ban_time": ban_time,
                "ban_level": user["ban_level"]
            }), 403

        save_user(userid, user)
        return jsonify({
            "status": "warning",
            "strikes": user["strikes"]
        }), 429

    save_user(userid, user)

    return jsonify({
        "status": "ok",
        "time_left": user["time_left"],
        "ban_level": user["ban_level"]
    })

# ==============================
# ADMIN LOGIN
# ==============================

@app.route("/admin-login", methods=["GET", "POST"])
def admin_login():

    if request.remote_addr != "127.0.0.1":
        return "Forbidden", 403

    if request.method == "POST":

        password_input = request.form.get("password")

        if not password_input:
            return "Senha inválida", 400

        if password_input.strip() == ADMIN_PASSWORD:
            session["admin"] = True
            session["login_time"] = int(time.time())
            return redirect("/admin-panel")

        return "Senha incorreta", 403

    return render_template("admin_login.html")

# ==============================
# ADMIN PANEL
# ==============================

@app.route("/admin-panel")
def admin_panel():

    if not session.get("admin"):
        return redirect("/admin-login")

    login_time = session.get("login_time", 0)
    if int(time.time()) - login_time > ADMIN_SESSION_TIME:
        session.clear()
        return redirect("/admin-login")

    files = os.listdir(DATA_FOLDER)
    users = []

    for file in files:
        with open(os.path.join(DATA_FOLDER, file), "r") as f:
            data = json.load(f)
            users.append({
                "userid": file.replace(".txt", ""),
                "time_left": data["time_left"],
                "ban_level": data["ban_level"],
                "ban_until": data["ban_until"]
            })

    return render_template("admin_panel.html", users=users)

# ==============================
# ADMIN LOGOUT
# ==============================

@app.route("/admin-logout")
def admin_logout():
    session.clear()
    return redirect("/admin-login")

# ==============================

if __name__ == "__main__":

    app.run(port=5000)
