import os
from flask import Flask, send_file, jsonify

app = Flask(__name__)

BASE_DIR = os.path.abspath("files")

# ===== HOME =====
@app.route("/")
def home():
    return jsonify({
        "status": "online",
        "service": "ZX FILE SERVER"
    })


# ===== FILE EXPLORER JSON =====
@app.route("/files/", defaults={"req_path": ""})
@app.route("/files/<path:req_path>")
def files(req_path):
    abs_path = os.path.join(BASE_DIR, req_path)

    # segurança básica
    if not abs_path.startswith(BASE_DIR):
        return jsonify({"error": "acesso negado"}), 403

    if not os.path.exists(abs_path):
        return jsonify({"error": "404"}), 404

    # arquivo
    if os.path.isfile(abs_path):
        return send_file(abs_path)

    # pasta → retorna JSON
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


# ===== RUN =====
if __name__ == "__main__":
    app.run(debug=True)
