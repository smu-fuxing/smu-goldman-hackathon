from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/api', methods=['POST', 'GET'])
def api():
  return jsonify({'data': {}}), 403


if __name__ == '__main__':
  # Only for debugging while developing
  app.run(host='0.0.0.0', debug=True, port=5001)
