from flask import Flask, send_from_directory, jsonify, Response, abort, request, url_for, redirect
import os, json

app = Flask(__name__)

# ===== PATHS =====
BASE_DIR = os.path.abspath("files")
BASE_PATH = os.path.abspath(".")
SCRIPTS_PATH = os.path.join(BASE_PATH, "scripts")
SCR_PATH = os.path.join(BASE_PATH, "templates")
LIBRARY_PATH = os.path.join(BASE_PATH, "library")
BASE_API = os.path.join(BASE_DIR, "APIs")
JSONLOADER_FILE = os.path.join(BASE_API, "jsonloader.lua")
SERVER_MANAGER_DIR = os.path.join(BASE_DIR, "servermanager")
JSON_FILE = os.path.join(SERVER_MANAGER_DIR, "applist.json")

# ===== HOME =====
@app.route("/")
def home():
    file_path = os.path.join(BASE_DIR, "templates", "home.html")
    if not os.path.exists(file_path):
        return "home.html não encontrado", 404
    with open(file_path, "r", encoding="utf-8") as f:
        html = f.read()
    return Response(html, mimetype="text/html")

# ===== UPLOAD =====
UPLOAD_BASE = os.path.join(os.getcwd(), "files")

# garantir que pasta existe
os.makedirs(UPLOAD_BASE, exist_ok=True)

@app.route("/upload/<path:folder>", methods=["GET", "POST"])
def upload_file(folder):
    target_folder = os.path.join(UPLOAD_BASE, folder)

    # segurança
    if not os.path.abspath(target_folder).startswith(os.path.abspath(UPLOAD_BASE)):
        return abort(403)

    os.makedirs(target_folder, exist_ok=True)

    if request.method == "POST":
        if "file" not in request.files:
            return "Nenhum arquivo enviado"

        file = request.files["file"]

        if file.filename == "":
            return "Arquivo inválido"

        filepath = os.path.join(target_folder, file.filename)
        file.save(filepath)

        return f"Arquivo enviado para /files/{folder}/{file.filename}"

    return f"""
    <html>
    <body style="background:#111;color:white;font-family:Arial;text-align:center;">
        <h1>Upload para /files/{folder}</h1>

        <form method="POST" enctype="multipart/form-data">
            <input type="file" name="file"><br><br>
            <button type="submit">Enviar</button>
        </form>
    </body>
    </html>
    """

# ===== ZX STORE =====
@app.route("/zx-store")
@app.route("/zx-store/app")
def zx_store():
    json_path = os.path.join(BASE_DIR, "servermanager", "applist.json")
    if not os.path.exists(json_path):
        return "<h1>JSON de apps não encontrado</h1>", 404

    try:
        with open(json_path, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception as e:
        return f"<h1>Erro ao ler JSON:</h1><p>{e}</p>", 500

    apps = data.get("apps", [])

    html = """
    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
    <meta charset="UTF-8">
    <title>ZX Store</title>
    <style>
      body { font-family:sans-serif; background:#0e0e0e; color:#fff; padding:20px; }
      h1 { text-align:center; color:#4fc3f7; }
      .app-card { background:#1b1b1b; padding:15px; margin:10px 0; border-radius:10px; }
      .app-card a { color:#4fc3f7; text-decoration:none; display:block; margin:5px 0; }
      .app-card a:hover { text-decoration:underline; }
    </style>
    </head><body>
    <h1>ZX Store</h1>
    """

    if not apps:
        html += "<p>Nenhum app encontrado.</p>"
    else:
        for app in apps:
            html += '<div class="app-card">'
            html += f'<strong>{app.get("Name","Sem Nome")}</strong> — {app.get("Data","")}<br>'
            desc = app.get("Desc")
            if desc:
                html += f'<em>{desc}</em><br>'
            for link in app.get("Links", []):
                # cada link aparece como texto clicável
                html += f'<a href="{link}" target="_blank">{link}</a>'
            html += "</div>"

    html += "</body></html>"

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

# ===== ZXIY =====
@app.route("/infinite")
def iy():
    path = os.path.join(SCRIPTS_PATH, "IY.lua")
    if not os.path.exists(path):
        return "não encontrado", 404
    response = send_from_directory(SCRIPTS_PATH, "IY.lua")
    response.headers["Cache-Control"] = "no-store"
    return response

# ===== ESP =====
@app.route("/esp")
def esp():
    path = os.path.join(SCRIPTS_PATH, "forsaken-ESP.lua")
    if not os.path.exists(path):
        return "não encontrado", 404
    response = send_from_directory(SCRIPTS_PATH, "forsaken-ESP.lua")
    response.headers["Cache-Control"] = "no-store"
    return response

# ===== BobbyHub =====
@app.route("/bobbyhub")
def bobbyhub():
    path = os.path.join(SCRIPTS_PATH, "bobbyhub.lua")
    if not os.path.exists(path):
        return "não encontrado", 404
    response = send_from_directory(SCRIPTS_PATH, "bobbyhub.lua")
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
