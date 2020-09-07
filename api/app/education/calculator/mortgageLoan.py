import pandas as pd
import numpy as np
from datetime import date

# home_price = 400000
# downpayment = 30000
# interest = 0.04
# years = 30
# payments_year = 12
# start_date = 01012021

def calculateMortgageLoan(home_price, downpayment, interest, years, payments_year, start_date):

    mortgage = home_price - downpayment

    rng = pd.date_range(start_date, periods=years * payments_year, freq='MS')
    rng.name = "Payment Date"
    df = pd.DataFrame(index=rng, columns=['Payment', 'Principal Paid', 'Interest Paid', 'Ending Balance'], dtype='float')
    df.reset_index(inplace=True)
    df.index += 1
    df.index.name = "Period"

    #Monthly Payment
    df['Payment'] = -1 * np.pmt(interest/12, years*payments_year, mortgage)

    #Principal Payment
    df['Principal Paid']  = -1 * np.ppmt(interest/payments_year, df.index , years * payments_year, mortgage)

    #Interest Payment
    df['Interest Paid'] = -1 * np.ipmt(interest/payments_year, df.index , years * payments_year, mortgage)


    df = df.round(2)

    df['Ending Balance'] = 0
    df.loc[1, "Ending Balance"] = mortgage - df.loc[1, "Principal Paid"]


    for period in range(2, len(df)+1):
        previous_balance = df.loc[period-1, 'Ending Balance']
        principal_paid = df.loc[period, "Principal Paid"]

        if previous_balance == 0:
            df.loc[period, ['Payment', 'Principal Paid', 'Interest Paid', 'Ending Balance']] == 0
            continue
        elif principal_paid <= previous_balance:
            df.loc[period, 'Ending Balance'] = previous_balance - principal_paid


    df['Payment Date'] = df['Payment Date'].apply(lambda x: str(x).split(' ')[0])

    last_date = df['Payment Date'].iloc[-1]
    last_payment = df['Payment'].iloc[-1]
    return (last_date, last_payment)