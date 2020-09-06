from flask import Flask, request, jsonify
import analysis.fundamental_analysis as fa
import yahoo.financial_data as fd

import education.calculator.mortgageLoan as ml
import education.calculator.retirementCalculator as rc
import education.calculator.retirementAgePrediction.retirementAgePrediction as rap
import marketplace.perf_analysis as pa
from datetime import date
from datetime import datetime

app = Flask(__name__)


@app.route('/api/mortgage-loan')
def calculateMortgageLoan():
  home_price = request.args.get('home_price', type=int)
  downpayment = request.args.get('downpayment', type=int)
  interest = request.args.get('interest', type=float)
  years = request.args.get('years', type=int)
  payments_year = request.args.get('payments_year', type=int)
  start_date = request.args.get('start_date', type=date)

  data = rc.calculateMortgageLoan(home_price, downpayment, interest, years, payments_year, start_date)
  return jsonify({'data': data}), 200


@app.route('/api/retirement-calculator')
def retirementCalculator():
  current_age = request.args.get('current_age', type=int)
  yearly_contribution = request.args.get('year_contribution', type=int)
  current_savings = request.args.get('current_savings', type=int)
  retirement_age = request.args.get('retire_age', type=int)
  avg_annual_return = request.args.get('avg_annual_return', type=float)

  data = rc.retirement_calculator(current_age=current_age, yearly_contribution=yearly_contribution, current_savings=current_savings,  retirement_age=retirement_age, avg_annual_return=avg_annual_return)
  return jsonify({'data': data}), 200


@app.route('/api/retirement-age')
def retirementage_prediction():
  loop = request.args.get('loop', type=int)
  starting_age = request.args.get('start_age', type=int)
  yearly_expense = request.args.get('year_expense', type=int)
  starting_assets = request.args.get('start_assets', type=int)
  stock_fraction = request.args.get('stock_frac', type=float)

  data = rap.retirementAgePrediction(loop, starting_age, yearly_expense, starting_assets, stock_fraction)
  return jsonify({'data': data}), 200


@app.route('/api/perf-analysis')
def perfAnalysis():
  tickers = request.args.getlist('tickers', type=str)
  start = request.args.get('start', type=str)
  end = request.args.get('end', type=str)
  datestart = datetime.strptime(start, "%d%m%Y").date()
  dateend = datetime.strptime(end, "%d%m%Y").date()
  riskfree_rate = request.args.get('riskfree_rate', type=float)
  portf_weights = request.args.getlist('weights', type=float)
  init_cap = request.args.get('init_cap', type=int)

  data = pa.perfAnalysis(tickers, datestart, dateend, riskfree_rate, portf_weights, init_cap)
  return jsonify({'data': data}), 200


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


@app.route('/api/yfinance')  # 1d,5d,1wk,1mo,3mo intervals
def yfinance():
  tickers = request.args.getlist('ticker', type=str)
  time_interval = request.args.get('interval')
  start_date = request.args.get('start')

  try:
    data = fd.get_yfinance(tickers, start_date) if time_interval is None else fd.get_yfinance(tickers, start_date, time_interval)
  except ValueError as e:
    return jsonify({'error': str(e)}), 400
  return jsonify({'data': data}), 200


@app.route('/_healthcheck')  # 1d,5d,1wk,1mo,3mo intervals
def healthcheck():
  return jsonify({'data': 'ok'}), 200


if __name__ == '__main__':
  # Only for debugging while developing
  app.run(host='0.0.0.0', debug=True, port=5001)
