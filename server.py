from flask import Flask, send_from_directory, jsonify, Response, abort
import os

app = Flask(__name__)

# ===== PATHS =====
BASE_DIR = os.path.abspath("files")
BASE_PATH = os.path.abspath(".")
SCRIPTS_PATH = os.path.join(BASE_PATH, "scripts")
SCR_PATH = os.path.join(BASE_PATH, "templates")
LIBRARY_PATH = os.path.join(BASE_PATH, "library")
BASE_API = os.path.join(BASE_DIR, "APIs")
JSONLOADER_FILE = os.path.join(BASE_API, "jsonloader.lua")

# ===== HOME =====
@app.route("/")
def home():
    file_path = os.path.join(BASE_DIR, "templates", "home.html")
    if not os.path.exists(file_path):
        return "home.html não encontrado", 404
    with open(file_path, "r", encoding="utf-8") as f:
        html = f.read()
    return Response(html, mimetype="text/html")

# ===== APIs =====
@app.route("/api/jsonloader")
def api_jsonloader():
    if os.path.isfile(JSONLOADER_FILE):
        return send_from_directory(BASE_API, "jsonloader.lua")
    else:
        abort(404, description="jsonloader.lua não encontrado")

# ===== DEBUG =====
@app.route("/debug")
def debug():
    path = os.path.join(BASE_DIR, "templates")
    if not os.path.exists(path):
        return f"PASTA NÃO EXISTE: {path}"
    return str(os.listdir(path))

# ===== FILE EXPLORER (JSON) =====
@app.route("/files/", defaults={"req_path": ""})
@app.route("/files/<path:req_path>")
def files(req_path):
    abs_path = os.path.join(BASE_DIR, req_path)
    # segurança básica
    if not abs_path.startswith(BASE_DIR):
        return jsonify({"error": "acesso negado"}), 403
    if not os.path.exists(abs_path):
        return jsonify({"error": "404"}), 404
    if os.path.isfile(abs_path):
        return send_from_directory(BASE_DIR, req_path)
    items = []
    for file in os.listdir(abs_path):
        filepath = os.path.join(abs_path, file)
        items.append({
            "name": file,
            "type": "folder" if os.path.isdir(filepath) else "file",
            "path": f"/files/{req_path}/{file}".replace("//", "/")
        })
    return jsonify({
        "path": f"/{req_path}",
        "items": items
    })

# ===== ZXLIB =====
@app.route("/zxlib")
def zxlib():
    path = os.path.join(SCRIPTS_PATH, "lib.lua")
    if not os.path.exists(path):
        return "ZXLIB não encontrado", 404
    response = send_from_directory(SCRIPTS_PATH, "lib.lua")
    response.headers["Cache-Control"] = "no-store"
    return response

# ===== ZXHUB =====
@app.route("/zxhub")
def zxhub():
    path = os.path.join(SCRIPTS_PATH, "zxhub.lua")
    if not os.path.exists(path):
        return "ZXHUB não encontrado", 404
    response = send_from_directory(SCRIPTS_PATH, "zxhub.lua")
    response.headers["Cache-Control"] = "no-store"
    return response

# ===== MUSIC LIST =====
@app.route("/musiclist")
def musiclist():
    path = os.path.join(LIBRARY_PATH, "songlist.json")
    if not os.path.exists(path):
        return jsonify({"error": "arquivo não encontrado"}), 404
    response = send_from_directory(LIBRARY_PATH, "songlist.json")
    response.headers["Cache-Control"] = "no-store"
    return response

# ===== RUN =====
if __name__ == "__main__":
    app.run(debug=True)
