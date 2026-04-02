import os
import sqlite3
import hashlib
from flask import Flask, request, jsonify, session, send_file

app = Flask(__name__)
app.secret_key = "troca_essa_chave_aqui"

# ===== CONFIG =====
BASE_DIR = os.path.abspath("files")
ADMIN_PASSWORD_HASH = hashlib.sha256("Chave".encode()).hexdigest()

# ===== DATABASE =====
def get_db():
    return sqlite3.connect("database.db")

# ===== AUTH =====
@app.route("/admin-login", methods=["POST"])
def admin_login():
    data = request.get_json()

    if not data or "password" not in data:
        return jsonify({"error": "Senha necessária"}), 400

    password_hash = hashlib.sha256(data["password"].encode()).hexdigest()

    if password_hash == ADMIN_PASSWORD_HASH:
        session["admin"] = True
        return jsonify({"status": "logado"})
    else:
        return jsonify({"error": "senha errada"}), 401


@app.route("/admin-logout")
def admin_logout():
    session.pop("admin", None)
    return jsonify({"status": "deslogado"})


# ===== BAN SYSTEM (CORRIGIDO) =====
@app.route("/ban-user/<userid>")
def ban_user(userid):
    if not session.get("admin"):
        return "Unauthorized", 403

    db = get_db()
    cursor = db.cursor()
    cursor.execute("INSERT INTO banned_users (userid) VALUES (?)", (userid,))
    db.commit()
    db.close()

    return f"User {userid} banido"


@app.route("/ban-ip/<ip>")
def ban_ip(ip):
    if not session.get("admin"):
        return "Unauthorized", 403

    db = get_db()
    cursor = db.cursor()
    cursor.execute("INSERT INTO banned_ips (ip) VALUES (?)", (ip,))
    db.commit()
    db.close()

    return f"IP {ip} banido"


# ===== FILE EXPLORER =====
@app.route("/files/", defaults={"req_path": ""})
@app.route("/files/<path:req_path>")
def files(req_path):
    if not session.get("admin"):
        return "Unauthorized", 403

    abs_path = os.path.join(BASE_DIR, req_path)

    # segurança
    if not abs_path.startswith(BASE_DIR):
        return "Acesso negado", 403

    if not os.path.exists(abs_path):
        return "404", 404

    # arquivo
    if os.path.isfile(abs_path):
        return send_file(abs_path)

    # pasta
    files = os.listdir(abs_path)

    html = f"""
    <style>
    body {{ background: black; color: #0f0; font-family: monospace; }}
    a {{ color: #0f0; text-decoration: none; }}
    </style>

    <h1>ZX FILE SYSTEM /{req_path}</h1>
    <ul>
    """

    if req_path != "":
        parent = "/".join(req_path.split("/")[:-1])
        html += f'<li><a href="/files/{parent}">../</a></li>'

    for file in files:
        filepath = os.path.join(req_path, file)
        html += f'<li><a href="/files/{filepath}">{file}</a></li>'

    html += "</ul>"

    return html


# ===== HOME =====
@app.route("/")
def home():
    return "ZX-AUTH ONLINE"


# ===== RUN =====
if __name__ == "__main__":
    app.run(debug=True)
