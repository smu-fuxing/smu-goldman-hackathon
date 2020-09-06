def calculate_monthly_interest(bank_balance = 0, monthly__salary_credited = 0, monthly_credit_card = 0, total_monthly_bill = 0, 
                                no_bills_per_month = 0, unit_trust_annual_lum_sum_investment = 0, unit_trust_monthly_investment = 0,
                                home_loan_monthly_installment = 0, home_loan_monthly_installment_more_200k = False, insurance_annual_expenditure = 0):

    def standard_chartered_jumpstart(bank_balance):

        #Standard Chartered JumpStart
        if bank_balance <= 20000:
            bank_interest = 1.00
        else:
            bank_interest = 0.01

        return bank_interest/100 * bank_balance

    def standard_chartered_bonussaver(bank_balance, monthly__salary_credited, no_bills_per_month, monthly_credit_card, 
                                    home_loan_monthly_installment, insurance_annual_expenditure):
        #Standard Chartered Bonus Saver
        bank_interest = 0
        if monthly__salary_credited > 3000:
            bank_interest += 1
        else:
            bank_interest += 0.05

        if no_bills_per_month > 0:
            bank_interest += 0.1

        if monthly_credit_card > 2000:
            bank_interest += 0.8
        elif monthly_credit_card > 0:
            bank_interest += 0.3

        if home_loan_monthly_installment > 0:
            bank_interest += 0.85

        if insurance_annual_expenditure > 0:
            bank_interest += 0.85
        
        return bank_interest/100 * bank_balance

    def BOC_smartsaver(bank_balance, monthly__salary_credited, no_bills_per_month, monthly_credit_card):
        #BOC SmartSaver
        bank_interest = 0.1

        if 6000 <= monthly__salary_credited:
            bank_interest = 0.5
        elif 2000 < monthly__salary_credited < 6000:
            bank_interest = 0.3

        if no_bills_per_month > 0:
            if bank_interest < 0.3:
                bank_interest = 0.3

        if monthly_credit_card > 0:
            if bank_interest < 0.3:
                bank_interest = 0.3
        
        return bank_interest/100 * bank_balance

    def  CIMB_fastsaver(bank_balance):
        #CIMB FastSaver
        if bank_balance < 50000:
            total_amount = 0.5 * bank_balance
        elif 50000 <= bank_balance < 75000:
            total_amount = (0.5/100 * 50000) + ((bank_balance - 50000) * 0.8/100)
        elif 75000 <= bank_balance < 100000:
            total_amount = (0.5/100 * 50000) + (250000 * 0.8/100) + ((bank_balance - 75000) * 1.5/100)
        else:
            total_amount = (0.5/100 * 50000) + (250000 * 0.8/100) + (25000 * 1.5/100) 

        bank_interest = total_amount - bank_balance
        return bank_interest

    def  DBS_multiplier(bank_balance, monthly__salary_credited, unit_trust_annual_lum_sum_investment, unit_trust_monthly_investment, home_loan_monthly_installment, insurance_annual_expenditure):
        #DBS Multiplier
        bank_interest = 0.05
        if monthly__salary_credited > 0:
            bank_interest = 0.7 

        if unit_trust_annual_lum_sum_investment > 0 or unit_trust_monthly_investment > 0 or home_loan_monthly_installment > 0 or insurance_annual_expenditure > 0:
            #depends, so assume average 2.5%
            bank_interest += 2.5

        return bank_interest/100 * bank_balance


    def maybank_saveup(bank_balance, monthly__salary_credited, monthly_credit_card, total_monthly_bill, no_bills_per_month, 
                    unit_trust_annual_lum_sum_investment, unit_trust_monthly_investment, home_loan_monthly_installment, insurance_annual_expenditure):
        #Maybank SAVE UP
        bank_interest = 0.1875
        category_count = 0
        if monthly__salary_credited > 0:
            category_count += 1
        if monthly_credit_card > 0:
            category_count += 1
        if total_monthly_bill > 0 or no_bills_per_month > 0:
            category_count += 1
        if unit_trust_annual_lum_sum_investment > 0 or unit_trust_monthly_investment > 0:
            category_count += 1
        if home_loan_monthly_installment > 0:
            category_count += 1
        if insurance_annual_expenditure > 0:
            category_count += 1

        if category_count > 2: 
            bank_interest += 2.75
        elif category_count == 2:
            bank_interest += 0.8
        elif category_count == 1:
            bank_interest += 0.3
        
        return bank_balance * bank_interest/100

    def OCBC360(bank_balance, unit_trust_annual_lum_sum_investment, unit_trust_monthly_investment, insurance_annual_expenditure):
        #OCBC360
        bank_interest = 0.05
        if monthly__salary_credited > 1800:
            bank_interest += 0.6
        if unit_trust_annual_lum_sum_investment > 0 or unit_trust_monthly_investment > 0:
            bank_interest += 0.6
        if insurance_annual_expenditure > 0:
            bank_interest += 0.6
        #if current bank balance > 500 than previous month + 0.2

        return bank_balance * bank_interest/100

    def UOB_One(bank_balance, monthly__salary_credited, monthly_credit_card, no_bills_per_month):
        #UOB One
        bank_interest = 0.05
        if monthly__salary_credited > 2000 + monthly_credit_card > 500:
            bank_interest = 0.75
        elif no_bills_per_month > 3 + monthly_credit_card > 500:
            bank_interest = 0.75

        return bank_balance * bank_interest/100

    all_interests = {}

    all_interests['Standard Chartered JumpStart'] = standard_chartered_jumpstart(bank_balance)
    all_interests['Standard Chartered Bonus Saver'] = standard_chartered_bonussaver(bank_balance, monthly__salary_credited, no_bills_per_month, monthly_credit_card, 
                                    home_loan_monthly_installment, insurance_annual_expenditure)
    all_interests['BOC SmartSaver'] = BOC_smartsaver(bank_balance, monthly__salary_credited, no_bills_per_month, monthly_credit_card)
    all_interests['CIMB FastSaver'] = CIMB_fastsaver(bank_balance)
    all_interests['DBS Multiplier'] = DBS_multiplier(bank_balance, monthly__salary_credited, unit_trust_annual_lum_sum_investment, unit_trust_monthly_investment, home_loan_monthly_installment, insurance_annual_expenditure)
    all_interests['Maybank SAVEUP'] = maybank_saveup(bank_balance, monthly__salary_credited, monthly_credit_card, total_monthly_bill, no_bills_per_month, 
                                    unit_trust_annual_lum_sum_investment, unit_trust_monthly_investment, home_loan_monthly_installment, insurance_annual_expenditure)
    all_interests['OCBC360'] = OCBC360(bank_balance, unit_trust_annual_lum_sum_investment, unit_trust_monthly_investment, insurance_annual_expenditure)
    all_interests['UOB One'] = UOB_One(bank_balance, monthly__salary_credited, monthly_credit_card, no_bills_per_month)

    return {k: v for k, v in sorted(all_interests.items(), key=lambda item: item[1])}
