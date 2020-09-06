<template>
  <div class="container mx-auto pt-6 pb-20 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-3xl">Calculator</h2>
      <h2 class="text-gray-900 text-xl text-goldman-gold capitalize">{{
          this.$route.query.name.split('-').join(' ')
        }}</h2>
      <div class="flex pt-4">
        <div class="flex flex-col w-full" v-if="this.$route.query.name === 'mortgage'">
          <form action="/">
            <text-input :value.sync="mortgage.homePrice" :item="{name: 'Home Price'}"></text-input>
            <text-input :value.sync="mortgage.downpayment" :item="{name: 'Down Payment'}"></text-input>
            <text-input :value.sync="mortgage.interest" :item="{name: 'Interest'}"></text-input>
            <text-input :value.sync="mortgage.years" :item="{name: 'Years'}"></text-input>
            <text-input :value.sync="mortgage.paymentYear" :item="{name: 'Payment Year'}"></text-input>
            <text-input :value.sync="mortgage.startDate" :item="{name: 'Start Date'}"></text-input>
            <div class="flex justify-center mt-6">
              <button
                class="bg-goldman-darkBlue w-2/3 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button">
                Calculate
              </button>
            </div>
          </form>
        </div>
        <div class="flex flex-col w-full" v-if="this.$route.query.name === 'retirement-savings'">
          <form action="/">
            <text-input :value.sync="retirementSavings.currentAge" :item="{name: 'Current Age'}"></text-input>
            <text-input :value.sync="retirementSavings.yearlyContribution"
                        :item="{name: 'Yearly Contribution'}"></text-input>
            <text-input :value.sync="retirementSavings.currentSavings" :item="{name: 'Current Savings'}"></text-input>
            <text-input :value.sync="retirementSavings.retirementAge" :item="{name: 'Retirement Age'}"></text-input>
            <text-input :value.sync="retirementSavings.avgAnnualReturn"
                        :item="{name: 'Average Annual Return'}"></text-input>
            <div class="flex justify-center mt-6">
              <button
                class="bg-goldman-darkBlue w-2/3 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button">
                Calculate
              </button>
            </div>
          </form>
        </div>
        <div class="flex flex-col w-full" v-if="this.$route.query.name === 'retirement-age'">
          <form action="/">
            <text-input :value.sync="retirementAge.loop" :item="{name: 'Loop'}"></text-input>
            <text-input :value.sync="retirementAge.startingAge"
                        :item="{name: 'Starting Age'}"></text-input>
            <text-input :value.sync="retirementAge.yearlyExpense" :item="{name: 'Yearly Expenses'}"></text-input>
            <text-input :value.sync="retirementAge.startingAssets" :item="{name: 'Starting Assets'}"></text-input>
            <text-input :value.sync="retirementAge.stockFraction"
                        :item="{name: 'Stock Fractions'}"></text-input>
            <div class="flex justify-center mt-6">
              <button
                class="bg-goldman-darkBlue w-2/3 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button">
                Calculate
              </button>
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
        {loop: "", startingAge: "", yearlyExpense: "", startingAssets: "", stockFraction: ""}
    }
  },
}
</script>

<style scoped>
</style>
