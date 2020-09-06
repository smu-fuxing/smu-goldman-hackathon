from flask import Flask, request, jsonify
import analysis.fundamental_analysis as fa
import yahoo.financial_data as fd

app = Flask(__name__)


@app.route('/api/profiles')  # /profiles?ticker=PIH&ticker=TSLA&ticker=FCCY
def ticker_profiles():
  tickers = request.args.getlist('ticker', type=str)
  try:
    data = fa.get_profiles(tickers)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/quotes')
def ticker_quotes():
  tickers = request.args.getlist('ticker', type=str)
  try:
    data = fa.get_quotes(tickers)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/ratings')
def ticker_ratings():
  tickers = request.args.getlist('ticker', type=str)
  try:
    data = fa.get_ratings(tickers)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/dcfs')
def ticker_dcfs():
  tickers = request.args.getlist('ticker', type=str)
  period = request.args.get('period')

  try:
    data = fa.get_dcfs(tickers, period)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/balance-sheet/<string:ticker>')
def ticker_balance_sheet(ticker):
  period = request.args.get('period')

  try:
    data = fa.get_balance_sheet(ticker, period)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/income-statement/<string:ticker>')
def ticker_income_statement(ticker):
  period = request.args.get('period')

  try:
    data = fa.get_income_statement(ticker, period)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/cashflow-statement/<string:ticker>')
def ticker_cashflow_statement(ticker):
  period = request.args.get('period')

  try:
    data = fa.get_cashflow_statement(ticker, period)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/metrics/<string:ticker>')
def ticker_metrics(ticker):
  period = request.args.get('period')

  try:
    data = fa.get_key_metrics(ticker, period)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/api/yahoo-financials')  # daily, weekly, monthly intervals
def yahoo_financials():
  tickers = request.args.getlist('ticker', type=str)
  time_interval = request.args.get('interval')
  start_date = request.args.get('start')

  try:
    data = fd.get_yahoo_financials(tickers, start_date) if time_interval is None else fd.get_yahoo_financials(tickers, start_date, time_interval)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@ app.route('/api/yfinance')  # 1d,5d,1wk,1mo,3mo intervals
def yfinance():
  tickers = request.args.getlist('ticker', type=str)
  time_interval = request.args.get('interval')
  start_date = request.args.get('start')

  try:
    data = fd.get_yfinance(tickers, start_date) if time_interval is None else fd.get_yfinance(tickers, start_date, time_interval)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


if __name__ == '__main__':
  # Only for debugging while developing
  app.run(host='0.0.0.0', debug=True, port=5001)
