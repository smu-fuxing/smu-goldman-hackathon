<template>
  <div class="container mx-auto pt-6 pb-10 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Bank Account</h2>
    </div>
    <div class="rounded-lg">
      <p class="text-gray-900 text-xl px-6 font-bold">POSB Savings</p>
      <p class="text-gray-900 text-md px-6 mb-6">104-83456-8</p>
      <div class="flex justify-between">
        <p class="text-gray-900 text-lg px-6 font-bold mb-1">1-7 Sep 2020</p>
        <p class="text-gray-900 text-lg px-6 font-bold mb-1">Total: $159.60</p>
      </div>
      <div class="mx-6">
        <div class="py-2 px-4 w-full rounded border bg-gray-300 shadow">
          <bar-chart :data="barChartData" height="280"/>
        </div>
      </div>
      <div class="mt-6 py-2 px-4 w-full">
        <div class="border-t pt-8"></div>
        <doughnut-chart :data="doughnutData" :options="{legend: {display: false}} " height="280"/>
      </div>
      <div class="mt-5">
        <div v-for="(spending, index) in spendingData" :class="{ 'bg-gray-300' : index % 2 === 0}">
          <div class="flex items-center justify-between mx-4 py-3">
            <div class="flex items-center">
              <ShoppingIcon v-if="spending.name === 'Shopping'"></ShoppingIcon>
              <DiningIcon v-else-if="spending.name === 'Dining'"></DiningIcon>
              <TransportIcon v-else-if="spending.name === 'Transport'"></TransportIcon>
              <EntertainmentIcon v-else-if="spending.name === 'Entertainment'"></EntertainmentIcon>
              <OthersIcon v-else-if="spending.name === 'Others'"></OthersIcon>
              <div class="ml-3">
                <p class="text-xl font-bold">{{ spending.name }}</p>
                <p class="text-sm font-light -mt-1">{{ spending.transactions + ' Transactions' }}</p>
              </div>
            </div>
            <div class="mr-4">
              <p class="text-lg font-light">{{ 'SGD ' + spending.amount }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import BarChart from '~/components/graphs/BarChart'
import DoughnutChart from "@/components/graphs/DoughnutChart";
import ShoppingIcon from "@/images/ShoppingIcon"
import DiningIcon from "@/images/DiningIcon"
import TransportIcon from "@/images/TransportIcon"
import EntertainmentIcon from "@/images/EntertainmentIcon"
import OthersIcon from "@/images/OthersIcon"

export default {
  name: "bank",
  components: {
    BarChart, DoughnutChart, ShoppingIcon, DiningIcon, TransportIcon, EntertainmentIcon, OthersIcon
  },
  data() {
    return {
      barChartData: {
        labels: ['1 Sep', '2 Sep', '3 Sep', '4 Sep', '5 Sep', '6 Sep', '7 Sep'],
        datasets: [
          {
            label: 'Spending',
            backgroundColor: "#112D63",
            data: [46, 59, 23, 67, 0, 0, 0]
          }
        ]
      },
      doughnutData: {
        labels: ['Shopping', 'Dining', 'Transport', 'Entertainment', 'Others'],
        datasets: [
          {
            backgroundColor: ["#80A9EA", "#C96A6A", "#C478D0", "#DAD78F", "#69A58C"],
            data: [50.20, 43.13, 20.48, 26.15, 10.69]
          }
        ]
      },
      spendingData: [
        {
          name: "Shopping",
          transactions: 22,
          amount: 59.15
        },
        {
          name: "Dining",
          transactions: 18,
          amount: 43.13
        }, {
          name: "Transport",
          transactions: 3,
          amount: 20.48
        }, {
          name: "Entertainment",
          transactions: 1,
          amount: 26.15
        }, {
          name: "Others",
          transactions: 5,
          amount: 10.69
        }
      ]
    }
  },
  mounted() {
    this.showLine = true // showLine will only be set to true on the client. This keeps the DOM-tree in sync.
  },
  asyncData() {
    const lineData = [40, 39, 10, 40, 39, 80, 40] // some data
    return {lineData}
  }
}
</script>

<style scoped>

</style>
