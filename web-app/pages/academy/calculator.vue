<template>
  <div class="container mx-auto pt-6 pb-20 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-3xl">Calculator</h2>
      <h2 class="text-gray-900 text-xl text-goldman-gold capitalize">{{
          this.$route.query.name.split('-').join(' ')
        }}</h2>
      <div class="flex pt-4">
        <div class="flex flex-col w-full" v-if="this.$route.query.name === 'mortgage'">
          <div>
            <text-input type="number" :value.sync="mortgage.homePrice" :item="{name: 'Home Price'}"></text-input>
            <text-input type="number" :value.sync="mortgage.downpayment" :item="{name: 'Down Payment'}"></text-input>
            <text-input type="number" :value.sync="mortgage.interest" :item="{name: 'Interest'}"></text-input>
            <text-input type="number" :value.sync="mortgage.years" :item="{name: 'Years'}"></text-input>
            <text-input type="number" :value.sync="mortgage.paymentYear" :item="{name: 'Payment Year'}"></text-input>
            <text-input type="date" :value.sync="mortgage.startDate" :item="{name: 'Start Date'}"></text-input>
            <div class="flex justify-center mt-6">
              <button
                class="bg-goldman-darkBlue w-2/3 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button"
                @click="getMortgageLoan()">
                Calculate
              </button>
            </div>
          </div>
          <div class="text-center mt-10 border rounded p-4 bg-gray-300" v-if="this.mortgageResult !== ''">
            <p class="text-xl">You will need to pay</p>
            <div>
              <span class="text-5xl font-bold">{{ '$' + this.mortgageResult[1] }}</span>
              <span class="text-2xl">/month</span>
            </div>
            <p class="text-xl">till <b>{{ ' ' + $moment(this.mortgageResult[0]).format('MMMM YYYY') }}</b></p>
          </div>
        </div>
        <div class="flex flex-col w-full" v-if="this.$route.query.name === 'retirement-savings'">
          <div>
            <text-input type="number" :value.sync="retirementSavings.currentAge" :item="{name: 'Current Age'}"></text-input>
            <text-input type="number" :value.sync="retirementSavings.yearlyContribution"
                        :item="{name: 'Yearly Contribution'}"></text-input>
            <text-input type="number" :value.sync="retirementSavings.currentSavings" :item="{name: 'Current Savings'}"></text-input>
            <text-input type="number" :value.sync="retirementSavings.retirementAge" :item="{name: 'Retirement Age'}"></text-input>
            <text-input type="number" :value.sync="retirementSavings.avgAnnualReturn"
                        :item="{name: 'Average Annual Return'}"></text-input>
            <div class="flex justify-center mt-6">
              <button
                class="bg-goldman-darkBlue w-2/3 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button"
                @click="getRetirementSavings()">
                Calculate
              </button>
            </div>
          </div>
          <div class="text-center mt-10 border rounded p-4 bg-gray-300" v-if="this.retirementSavingsResult !== ''">
            <p class="text-xl">You can expect to have</p>
            <p class="text-5xl font-bold">{{ '$' + this.retirementSavingsResult }}</p>
            <p class="text-xl">saved when you are {{ retirementSavings.currentAge }}</p>
          </div>
        </div>
        <div class="flex flex-col w-full" v-if="this.$route.query.name === 'retirement-age'">
          <form action="/">
            <text-input type="number" :value.sync="retirementAge.loop" :item="{name: 'Loop'}"></text-input>
            <text-input type="number" :value.sync="retirementAge.startingAge"
                        :item="{name: 'Starting Age'}"></text-input>
            <text-input type="number" :value.sync="retirementAge.yearlyExpense" :item="{name: 'Yearly Expenses'}"></text-input>
            <text-input type="number" :value.sync="retirementAge.startingAssets" :item="{name: 'Starting Assets'}"></text-input>
            <text-input type="number" :value.sync="retirementAge.stockFraction"
                        :item="{name: 'Stock Fractions'}"></text-input>
            <div class="flex justify-center mt-6">
              <button
                class="bg-goldman-darkBlue w-2/3 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button"
                @click="getRetirementAge()">
                Calculate
              </button>
            </div>
            <div class="text-center mt-10 border rounded p-4 bg-gray-300" v-if="this.retirementAgeResult !== ''">
              <p class="text-xl">The probability of you running out of money is...</p>
              <p class="text-5xl font-bold">{{ (this.retirementAgeResult.split("+")[0] * 100) + '%' }}</p>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TextInput from "~/components/academy/TextInput";

export default {
  components: {TextInput},
  name: "calculator",
  data() {
    return {
      mortgage:
        {homePrice: "", downpayment: "", interest: "", years: "", paymentYear: "", startDate: ""},
      retirementSavings:
        {currentAge: "", yearlyContribution: "", currentSavings: "", retirementAge: "", avgAnnualReturn: ""},
      retirementAge:
        {loop: "", startingAge: "", yearlyExpense: "", startingAssets: "", stockFraction: ""},
      mortgageResult: "",
      retirementSavingsResult: "",
      retirementAgeResult: ""
    }
  },
  methods: {
    getMortgageLoan() {
      let _date = ""
      if (this.$moment(this.mortgage.startDate, "DD-MM-YYYY", true).isValid()) {
        _date = this.$moment(this.mortgage.startDate, "DD-MM-YYYY").format('DDMMYYYY')
      } else {
        _date = this.$moment(this.mortgage.startDate, "DD MMM YYYY").format('DDMMYYYY')
      }

      const data = this.$axios.$get("https://api.mavis-gs.com/api/mortgage-loan",
        {
          params: {
            home_price: this.mortgage.homePrice,
            downpayment: this.mortgage.downpayment,
            interest: this.mortgage.interest,
            years: this.mortgage.years,
            payments_year: this.mortgage.paymentYear,
            start_date: _date,
          }
        })
        .then(response => (this.mortgageResult = response.data))
        .catch(function (error) {
          console.log(error);
        })
    },
    getRetirementSavings() {
      this.$axios.$get("https://api.mavis-gs.com/api/retirement-calculator",
        {
          params: {
            current_age: this.retirementSavings.currentAge,
            year_contribution: this.retirementSavings.yearlyContribution,
            current_savings: this.retirementSavings.currentSavings,
            retire_age: this.retirementSavings.retirementAge,
            avg_annual_return: this.retirementSavings.avgAnnualReturn,
          }
        })
        .then(response => (this.retirementSavingsResult = response.data[1]))
        .catch(function (error) {
          console.log(error);
        })
    },
    getRetirementAge() {
      const data = this.$axios.$get("https://api.mavis-gs.com/api/retirement-age",
        {
          params: {
            loop: this.retirementAge.loop,
            start_age: this.retirementAge.startingAge,
            year_expense: this.retirementAge.yearlyExpense,
            start_assets: this.retirementAge.startingAssets,
            stock_frac: this.retirementAge.stockFraction,
          }
        })
        .then(response => (this.retirementAgeResult = response.data))
        .catch(function (error) {
          console.log(error);
        })
    }
  }
}
</script>

<style scoped>
</style>
