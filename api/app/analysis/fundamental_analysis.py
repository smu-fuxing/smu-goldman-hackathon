import FundamentalAnalysis as fa
import pandas as pd
import os
from dotenv import load_dotenv

load_dotenv('.env')  # run from /app directory
API_KEY = os.getenv('FA_API_KEY')


def validate_tickers(tickers):
  if len(tickers) == 0:
    raise ValueError("Please provide at least one ticker.")


def validate_period(period):
  if period not in ['annual', 'quarter']:
    return ValueError("Period can only be 'annual' or 'quarter'.")


def get_supported_exchanges():
  companies = fa.available_companies(API_KEY)
  return companies.exchange.unique()


def get_profiles(tickers):
  validate_tickers(tickers)
  res = pd.DataFrame()

  try:
    for ticker in tickers:
      profile = fa.profile(ticker, API_KEY)
      profile.columns = [ticker]
      profile.dropna(axis=0, inplace=True)
      res = pd.concat([res, profile], axis=1)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return res.to_dict()


def get_quotes(tickers):
  validate_tickers(tickers)
  res = pd.DataFrame()

  try:
    for ticker in tickers:
      quotes = fa.quote(ticker, API_KEY)
      quotes.columns = [ticker]
      quotes.dropna(axis=0, inplace=True)
      res = pd.concat([res, quotes], axis=1)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return res.to_dict()


def get_ratings(tickers):
  validate_tickers(tickers)
  res = pd.DataFrame()

  try:
    for ticker in tickers:
      ratings = fa.rating(ticker, API_KEY)[['score']]  # higher score better {1...5}
      ratings.columns = [ticker]
      ratings.dropna(axis=0, inplace=True)
      res = pd.concat([res, ratings], axis=1)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return res.to_dict()


def get_dcfs(tickers, period):
  validate_tickers(tickers)
  validate_period(period)
  res = pd.DataFrame()

  try:
    for ticker in tickers:
      dcfs = fa.discounted_cash_flow(ticker, API_KEY, period)
      dcfs.drop(['date', 'Stock Price'], inplace=True)
      dcfs.index = [ticker]
      dcfs.dropna(axis=1, inplace=True)
      res = pd.concat([res, dcfs], axis=0)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return res.to_dict('index')


def get_balance_sheet(ticker, period):
  validate_period(period)

  try:
    balance = fa.balance_sheet_statement(ticker, API_KEY, period)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return balance.to_dict()



def get_income_statement(ticker, period):
  validate_period(period)

  try:
    income = fa.income_statement(ticker, API_KEY, period)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return income.to_dict()


def get_cashflow_statement(ticker, period):  # period can be 'annual or 'quarter'
  validate_period(period)

  try:
    cashflow = fa.cash_flow_statement(ticker, API_KEY, period)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return cashflow.to_dict()


def get_key_metrics(ticker, period):
  validate_period(period)

  try:
    metrics = fa.key_metrics(ticker, API_KEY, period)
  except:
    raise ValueError("System is temporarily unavailable. Please try again later.")

  return metrics.to_dict()
