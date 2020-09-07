<template>
  <div class="container mx-auto pt-6 pb-10 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Strategy</h2>
    </div>
    <div class="rounded-lg">
      <div class="flex justify-between">
        <p class="text-gray-900 text-xl px-6 font-bold">Fundamental Analysis</p>
      </div>
      <div>
        <div class="flex pt-4">
          <div class="flex flex-col w-full pt-5 px-6">
            <select @change="getStocks($event)"
                    class="text-lg px-3 py-2 rounded focus:outline-none bg-transparent border-2 border-goldman-darkBlue text-goldman-darkBlue bg-opacity-75"
                    style="height: 47px">
              <option v-for="(stock, index) in holdings.stocks" :value="index">{{ stock }}</option>
            </select>
          </div>
        </div>
        <div>
          <table class="table-auto">
            <thead>
            <tr>
              <th class="px-4 py-2"></th>
              <th class="px-4 py-2">Score</th>
              <th class="px-4 py-2">Remarks</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(datum, index) in data" :class="{ 'bg-gray-300' : index % 2 === 0}">
              <td class="border px-4 py-2">{{ datum.label }}</td>
              <td class="border px-4 py-2">{{ datum.value }}</td>
              <td class="border px-4 py-2">{{ datum.remarks }}</td>
            </tr>
            </tbody>
          </table>
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
      data : {},
      holdings: {
        data: [
          [{
            label: 'Prove To Book',
            value: "4",
            remarks: "Buy",
          },
            {
              label: 'Return on Assets',
              value: "4",
              remarks: "Buy",
            },
            {
              label: 'Discounted Cash Flow',
              value: "5",
              remarks: "Strong Buy",
            },
            {
              label: 'Price to Earning',
              value: "3",
              remarks: "Neutral",
            },
            {
              label: 'Return on Equity',
              value: "5",
              remarks: "Strong Buy",
            },
            {
              label: 'Depth to Equity',
              value: "5",
              remarks: "Strong Buy",
            }],
          [{
            label: 'Prove To Book',
            value: "5",
            remarks: "Strong Buy",
          },
            {
              label: 'Return on Assets',
              value: "5",
              remarks: "Strong Buy",
            },
            {
              label: 'Discounted Cash Flow',
              value: "5",
              remarks: "Strong Buy",
            },
            {
              label: 'Price to Earning',
              value: "3",
              remarks: "Neutral",
            },
            {
              label: 'Return on Equity',
              value: "3",
              remarks: "Neutral",
            },
            {
              label: 'Depth to Equity',
              value: "2",
              remarks: "Sell",
            }],
        ],
        stocks: ["TSLA", "AAPL"],
      },
      selectedIndex: 0
    }
  },
  mounted() {
    this.showLine = true // showLine will only be set to true on the client. This keeps the DOM-tree in sync.
    this.data = this.holdings.data[0]
  },
  asyncData() {
    const lineData = [40, 39, 10, 40, 39, 80, 40] // some data
    return {lineData}
  },
  methods: {
    getStocks(event) {
      this.selectedStock = event.target.value
      this.data = this.holdings.data[this.selectedStock]
      // const data = this.$axios.$get("https://api.mavis-gs.com/api/perf-analysis",
      //   {
      //     params: {
      //       tickers: this.selectedStock,
      //       start: "01012020",
      //       end: "07092020",
      //       init_cap: 1,
      //       riskfree_rate: 0,
      //       weights: 1,
      //     }
      //   })
      //   .then(response => (this.stockData = response.data))
      //   .catch(function (error) {
      //     console.log(error);
      //   })
    }
  }
}
</script>

<style scoped>

</style>
