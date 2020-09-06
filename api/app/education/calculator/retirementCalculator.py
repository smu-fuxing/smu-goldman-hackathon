"""ages are in years
contribution, and savings are in dollars
avg_annual_return is a ratio, so 1.07 is a 7% annual return
let's say I'm 25 years old, I am going to contribute $2000/yr in bonds (~5% return), and I've already invested $5700 in bonds

>>> retirement_calculator(25, 2000, 5700, avg_annual_return=1.05)
281727.48414409667
So I could expect to have $281,727 saved when I am 65 years old."""

def retirement_calculator(current_age, yearly_contribution=0, current_savings=0, 
        retirement_age=65, avg_annual_return=1.07):
    
    years_until_retirement = retirement_age - current_age
    
    savings = current_savings * (avg_annual_return ** years_until_retirement)
    while years_until_retirement > 0:
        years_until_retirement -= 1
        savings += yearly_contribution * (avg_annual_return ** years_until_retirement)
    
    return (retirement_age, savings)