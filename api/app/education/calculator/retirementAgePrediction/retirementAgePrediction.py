import numpy as np
import pandas as pd
import uncertainties as unc
import uncertainties.unumpy as unp
from education.calculator.retirementAgePrediction.src import shiller
from education.calculator.retirementAgePrediction.src import simulation
from scipy import stats

# loop = 10000
# starting_age = 65
# yearly_expense=50000.00
# starting_assets=500000.00
# stock_fraction=0.5
# state_abbrev='IA'
# demographic_group='white female'


def retirementAgePrediction(loop, starting_age, yearly_expense, starting_assets, stock_fraction,state_abbrev, demographic_group):

    histories = simulation.run_histories(yearly_expense = yearly_expense, starting_assets=starting_assets, stock_fraction=stock_fraction,
                    starting_age=starting_age, state_abbrev=state_abbrev, demographic_group=demographic_group, n_mc=loop)

    final_assets = []

    for i in range(loop):
        final_assets.append(histories[i][-1])

    final_assets = np.array(final_assets)

    run_out_of_money_hist = np.array(final_assets < 0.0, dtype=np.float64)
    run_out_of_money = unc.ufloat(run_out_of_money_hist.mean(),
                                run_out_of_money_hist.std() / np.sqrt(loop))

    return run_out_of_money
