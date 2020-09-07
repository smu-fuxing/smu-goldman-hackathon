<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="px-6 full-width">
      <h1 class="text-gray-900 text-4xl">Strategy</h1>
      <h3 class="text-gray-700 text-xl">Saving Account</h3>

      <form class="mt-4" @submit.prevent="onRecommend">
        <div v-for="input in inputs" class="py-1">
          <div class="flex flex-col w-full">
            <label class="block text-black text-sm font-bold mb-1">
              {{ input.title }}
            </label>

            <input
              :required="input.required"
              type="number"
              class="text-lg px-3 py-2 rounded focus:outline-none placeholder-goldman-darkBlue bg-transparent border-2 border-goldman-darkBlue text-goldman-darkBlue bg-opacity-75"
              v-model="input.value"
            />
          </div>
        </div>

        <div class="mt-6 w-full">
          <button
                  class="w-full py-3 px-4 font-bold text-white uppercase rounded bg-goldman-darkBlue hover:bg-gray-700 focus:outline-none">
            RECOMMEND
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import TextInput from "~/components/academy/TextInput";

export default {
  components: {TextInput},
  data() {
    return {
      inputs: [
        {title: 'Bank Balance (REQUIRED)', value: 0, field: 'bank_balance', required: true},
        {title: 'Monthly Salary Credited to Bank', value: 0, field: 'monthly__salary_credited'},
        {title: 'Monthly Credit Card Spending', value: 0, field: 'monthly_credit_card'},
        {title: 'Total Monthly Bill Amount', value: 0, field: 'total_monthly_bill'},
        {title: 'No. of Bills per Month', value: 0, field: 'no_bills_per_month'},
        {title: 'Annual Lump Sum Investment', value: 0, field: 'unit_trust_annual_lum_sum_investment'},
        {title: 'Monthly Investment', value: 0, field: 'unit_trust_monthly_investment'},
        {title: 'Loan Monthly Installment', value: 0, field: 'home_loan_monthly_installment'},
        {title: 'Annual Insurance Spend', value: 0, field: 'insurance_annual_expenditure'},
      ]
    }
  },
  methods: {
    onRecommend() {
      const query = {}
      this.inputs.forEach(({value, field}) => {
          query[field] = value
      })

      this.$router.push({
        path: '/strategy/accounts', query
      })
    }
  }
}
</script>

<style>
</style>
