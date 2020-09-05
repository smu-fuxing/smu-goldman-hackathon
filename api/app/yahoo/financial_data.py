import numpy as np
import pandas as pd
import yfinance as yf
from yahoofinancials import YahooFinancials
from datetime import date, datetime, timedelta


def yahoo_financials(tickers, start_date, time_interval='daily'):
  """
  Pulls historical pricing data for stocks, currencies, ETFs, mutual funds, U.S. Treasuries, cryptocurrencies,
  commodities, and indexes.
  :param tickers: list of tickers
  :param start_date: ‘YYYY-MM-DD’ format and is the first day that data will be pulled for
  :param time_interval: 'daily','weekly','monthly' and default is daily
  :return: a dictionary with each ticker as key and stock data as value
  """
  res_dict = {}
  end_date = date.today().strftime("%Y-%m-%d")
  print(end_date)
  for ticker in tickers:
    financials = YahooFinancials(ticker)
    json_obj = financials.get_historical_price_data(start_date, end_date, time_interval)
    ohlv = json_obj[ticker]['prices']

    res_dict[ticker] = {}
    for row in ohlv:
      formatted_date = datetime.fromtimestamp(row.pop('date')).strftime("%Y-%m-%d %H:%M:%S")
      del row['formatted_date']
      res_dict[ticker][formatted_date] = row
  return res_dict


def yfinance(tickers, start_date, time_interval='1d'):
  """
  Pulls historical pricing data for stocks, currencies, ETFs, mutual funds, U.S. Treasuries, cryptocurrencies,
  commodities, and indexes.
  :param tickers: list of tickers
  :param start_date: ‘YYYY-MM-DD’ format and is the first day that data will be pulled for
  :param time_interval: 1m,2m,5m,15m,30m,60m,90m,1h,1d,5d,1wk,1mo,3mo and default is 1d
  :return:
  """
  res_dict = {}
  start_date = datetime.strptime(start_date, "%Y-%m-%d") + timedelta(days=1)
  end_date = date.today()
  for ticker in tickers:
    df = yf.download(ticker, start_date, end_date, interval=time_interval)
    df.rename(columns={"Open": 'open', "High": 'high', "Low": 'low', "Close": 'close', "Adj Close": 'adjclose', "Volume": 'volume'}, inplace=True)
    df.index = df.index.strftime("%Y-%m-%d %H:%M:%S")
    res_dict[ticker] = df.to_dict('index')
  return res_dict

# print(yahoo_financials(['AAPL'], '2020-09-03'))
# print(yfinance(['AAPL'], '2020-09-03'))

