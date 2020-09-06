def calculate_insurance_monthly_interest(bank_balance):

    def singlife_account(bank_balance):

        if bank_balance > 500 and bank_balance < 10000:
            bank_interest = 0.025
        else:
            bank_interest = 0

        return bank_interest * bank_balance

    def singtel_dash_easyearn(bank_balance):

        if bank_balance > 2000 and bank_balance < 20000:
            bank_interest = 0.02
        else:
            bank_interest = 0
        
        return bank_interest * bank_balance

    def etiqa_elastiq(bank_balance):

        if bank_balance > 5000 and bank_balance < 50000:
            bank_interest = 0.018
        else:
            bank_interest = 0
        
        return bank_interest * bank_balance

    all_interests = {}

    all_interests['Singlife Account'] = singlife_account(bank_balance)
    all_interests['Singtel Dash EasyEarn'] = singtel_dash_easyearn(bank_balance)
    all_interests['Etiqa ELASTIQ'] = etiqa_elastiq(bank_balance)


    return {k: v for k, v in sorted(all_interests.items(), key=lambda item: item[1])}

print(calculate_insurance_monthly_interest(49999))