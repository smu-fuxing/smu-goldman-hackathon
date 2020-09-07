<template>
  <div class="container mx-auto pt-6 pb-10 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Holdings</h2>
    </div>
    <div class="rounded-lg">
      <div class="flex justify-between mb-4">
        <p class="text-gray-900 text-xl px-6 font-bold">Stocks</p>
        <div>
          <p class="text-gray-900 text-lg px-6 font-bold mb-1">{{ holdings.total }}</p>
        </div>
      </div>
      <div>
        <div v-for="(datum, index) in holdings.data" :class="{ 'bg-gray-300' : index % 2 === 0}">
          <div class="flex items-center justify-between mx-4 py-3">
            <div class="flex items-center">
              <div class="ml-3">
                <p class="text-md font-bold">{{ datum.label }}</p>
              </div>
            </div>
            <div class="mr-4">
              <p class="text-md">{{ datum.value }}</p>
            </div>
          </div>
        </div>
      </div>
      <div>
        <div class="flex pt-4">
          <div class="flex flex-col w-full pt-5 px-6">
            <select @change="getStocks($event)"
              class="text-lg px-3 py-2 rounded focus:outline-none bg-transparent border-2 border-goldman-darkBlue text-goldman-darkBlue bg-opacity-75"
              style="height: 47px">
              <option v-for="stock in holdings.stocks" :value="stock">{{ stock }}</option>
            </select>
          </div>
        </div>
<!--        <div class="flex w-full justify-between mt-4">-->
<!--          <div>-->
<!--            <p class="text-gray-900 text-md px-6 font-bold mb-1">NASDAQ AAPL</p>-->
<!--            <p class="text-gray-900 text-md -mt-2 px-6 font-light mb-1">Apple</p>-->
<!--          </div>-->
<!--          <div class="text-right">-->
<!--            <p class="text-gray-900 text-md px-6 font-bold mb-1">SGD -110.10</p>-->
<!--            <p class="text-gray-900 text-md -mt-2 px-6 font-light mb-1">-6.25%</p>-->
<!--          </div>-->
<!--        </div>-->
        <div>
          <div v-for="(datum, index) in stockData" :class="{ 'bg-gray-300' : index % 2 === 0}">
            <div class="flex items-center justify-between mx-4 py-3">
              <div class="flex items-center">
                <div class="ml-3">
                  <p class="text-md font-bold">{{ index }}</p>
                </div>
              </div>
              <div class="mr-4">
                <p class="text-md">{{ datum['Portf'].toFixed(4) }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import DropDownList from "~/components/onboarding/DropDownList";
import Graph from "@/images/Graph";

export default {
  name: "bank",
  components: {
    DropDownList, Graph
  },
  data() {
    return {
      stockData: {},
      holdings: {
        total: "SGD 3,363.33",
        data: [
          {
            label: 'Cumulative Returns ($)',
            value: "-371.87",
          },
          {
            label: 'Annualized Returns',
            value: "0.3881",
          },
          {
            label: 'Annualized Volatility',
            value: "0.2599",
          },
          {
            label: 'Annualized Sharpe Ratio',
            value: "1.4929",
          },
          {
            label: 'Maximum Drawdown',
            value: "-0.3413",
          }
        ],
        stocks: ["GOOG", "TSLA"],
        selectedStock: "GOOG"
      }
    }
  },
  mounted() {
    this.showLine = true // showLine will only be set to true on the client. This keeps the DOM-tree in sync.
    this.getStocks('GOOG')
  },
  asyncData() {
    const lineData = [40, 39, 10, 40, 39, 80, 40] // some data
    return {lineData}
  },
  methods: {
    getStocks(event) {
      if (event !== 'GOOG') {
        this.selectedStock = event.target.value
      } else {
        this.selectedStock = 'GOOG'
      }
      const data = this.$axios.$get("https://api.mavis-gs.com/api/perf-analysis",
        {
          params: {
            tickers: this.selectedStock,
            start: "01012020",
            end: "07092020",
            init_cap: 1,
            riskfree_rate: 0,
            weights: 1,
          }
        })
        .then(response => (this.stockData = response.data))
        .catch(function (error) {
          console.log(error);
        })
    }
  }
}
</script>

<style scoped>

</style>
