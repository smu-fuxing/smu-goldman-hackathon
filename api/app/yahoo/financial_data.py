import numpy as np
import pandas as pd
import yfinance as yf
from yahoofinancials import YahooFinancials
from datetime import date, datetime, timedelta


def validate_tickers(tickers):
  if len(tickers) == 0:
    raise ValueError("Please provide at least one ticker.")


def validate_start_date(start_date):
  try:
    start_date = datetime.strptime(start_date, "%Y-%m-%d")
  except:
    raise ValueError('Start should be in YYYY-MM-DD format')
  return start_date + timedelta(days=1)


def get_yahoo_financials(tickers, start_date, time_interval='daily'):
  """
  Pulls historical pricing data for stocks, currencies, ETFs, mutual funds, U.S. Treasuries, cryptocurrencies,
  commodities, and indexes.
  :param tickers: list of tickers
  :param start_date: ‘YYYY-MM-DD’ format and is the first day that data will be pulled for
  :param time_interval: 'daily','weekly','monthly' and default is daily
  :return: a dictionary with each ticker as key and stock data as value
  """
  validate_start_date(start_date)
  validate_tickers(tickers)
  res_dict = {}
  end_date = date.today().strftime("%Y-%m-%d")

  if time_interval not in ['daily', 'weekly', 'monthly']:
    raise ValueError("Interval should be daily, weekly or monthly.")

  try:
    for ticker in tickers:
      financials = YahooFinancials(ticker)
      json_obj = financials.get_historical_price_data(start_date, end_date, time_interval)
      ohlv = json_obj[ticker]['prices']

      res_dict[ticker] = {}
      for row in ohlv:
        formatted_date = datetime.fromtimestamp(row.pop('date')).strftime("%Y-%m-%d %H:%M:%S")
        del row['formatted_date']
        res_dict[ticker][formatted_date] = row
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return res_dict


def get_yfinance(tickers, start_date, time_interval='1d'):
  """
  Pulls historical pricing data for stocks, currencies, ETFs, mutual funds, U.S. Treasuries, cryptocurrencies,
  commodities, and indexes.
  :param tickers: list of tickers
  :param start_date: ‘YYYY-MM-DD’ format and is the first day that data will be pulled for
  :param time_interval: 1d,5d,1wk,1mo,3mo and default is 1d
  :return:
  """
  res_dict = {}
  end_date = date.today()
  start_date = validate_start_date(start_date)
  validate_tickers(tickers)

  if time_interval not in ['1d', '5d', '1wk', '1mo', '3mo']:
    raise ValueError("Interval should be 1m, 2m, 5m, 15m, 30m, 60m, 90m, 1h, 1d, 5d, 1wk, 1mo or 3mo")

  try:
    for ticker in tickers:
      df = yf.download(ticker, start_date, end_date, interval=time_interval)
      df.rename(columns={"Open": 'open', "High": 'high', "Low": 'low', "Close": 'close', "Adj Close": 'adjclose', "Volume": 'volume'}, inplace=True)
      df.index = df.index.strftime("%Y-%m-%d %H:%M:%S")
      res_dict[ticker] = df.to_dict('index')
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return res_dict
