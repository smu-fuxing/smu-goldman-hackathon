import FundamentalAnalysis as fa
import pandas as pd
import os
from dotenv import load_dotenv
load_dotenv('../.env')
API_KEY = os.getenv('FA_API_KEY')


def get_supported_exchanges():
  companies = fa.available_companies(API_KEY)
  return companies.exchange.unique()


def get_profile(tickers):
  res = pd.DataFrame()

  for ticker in tickers:
    profile = fa.profile(ticker, API_KEY)
    profile.columns = [ticker]
    profile.dropna(axis=0, inplace=True)
    res = pd.concat([res, profile], axis=1)

  return res.to_dict()


def get_quotes(tickers):
  res = pd.DataFrame()

  for ticker in tickers:
    quotes = fa.quote(ticker, API_KEY)
    quotes.columns = [ticker]
    quotes.dropna(axis=0, inplace=True)
    res = pd.concat([res, quotes], axis=1)

  return res.to_dict()


def get_ratings(tickers):
  res = pd.DataFrame()
  for ticker in tickers:
    ratings = fa.rating(ticker, API_KEY)[['score']]  # higher score better {1...5}
    ratings.columns = [ticker]
    ratings.dropna(axis=0, inplace=True)
    res = pd.concat([res, ratings], axis=1)
  return res.to_dict()


def get_dcfs(tickers, period):  # period can be 'annual or 'quarter
  if period not in ['annual', 'quarter']:
    return {}

  res = pd.DataFrame()
  for ticker in tickers:
    dcfs = fa.discounted_cash_flow(ticker, API_KEY, period)
    dcfs.drop(['date', 'Stock Price'], inplace=True)
    dcfs.index = [ticker]
    dcfs.dropna(axis=1, inplace=True)
    res = pd.concat([res, dcfs], axis=0)
  return res.to_dict('index')


def get_balance_sheet(ticker, period):  # period can be 'annual or 'quarter
  if period not in ['annual', 'quarter']:
    return {}

  balance = fa.balance_sheet_statement(ticker, API_KEY, period)
  return balance.to_dict()


def get_income_statement(ticker, period):  # period can be 'annual or 'quarter
  if period not in ['annual', 'quarter']:
    return {}

  income = fa.income_statement(ticker, API_KEY, period)
  return income.to_dict()


def get_cashflow_statement(ticker, period):  # period can be 'annual or 'quarter
  if period not in ['annual', 'quarter']:
    return {}

  cashflow = fa.cash_flow_statement(ticker, API_KEY, period)
  return cashflow.to_dict()


def get_key_metrics(ticker, period):
  if period not in ['annual', 'quarter']:
    return {}

  metrics = fa.key_metrics(ticker, API_KEY, period)
  return metrics.to_dict()

print(get_key_metrics('AAL', 'annual'))
