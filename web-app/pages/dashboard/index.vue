<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Home</h2>
    </div>
    <div>
      <h2 class="text-gray-900 text-xl px-6 text-goldman-gold">Bank Accounts</h2>
      <div v-for="(bank, index) in banks" :class="{ 'bg-gray-300' : index % 2 === 0}">
        <nuxt-link to="/dashboard/bank">
          <div class="flex items-center justify-between mr-2 py-3">
            <div class="">
              <p class="ml-6 text-lg font-bold">{{ bank.name }}</p>
              <p class="ml-6 text-sm">{{ bank.account }}</p>
            </div>
            <div class="mr-4">
              <span class="inline-block align-middle text-md">{{ bank.balance }}</span>
            </div>
          </div>
        </nuxt-link>
      </div>
    </div>
    <div class="mt-10">
      <h2 class="text-gray-900 text-xl px-6 text-goldman-gold">Holdings</h2>
      <div v-for="(holding, index) in holdings" :class="{ 'bg-gray-300' : index % 2 === 1}">
        <nuxt-link v-if="holding.name === 'Stocks'" to="/dashboard/stock">
          <div class="flex items-center justify-between mr-2 py-3">
            <div class="">
              <p class="ml-6 text-lg font-bold">{{ holding.name }}</p>
            </div>
            <div class="mr-4 text-right">
              <p class="text-md">{{ holding.balance }}</p>
              <template v-if="holding.change !== undefined">
                <p v-if="holding.change.type === 'positive'" class="text-sm text-green-700">
                  {{ '+' + holding.change.value + ' (+' + holding.change.percentage + '%)' }}</p>
                <p v-else class="text-sm text-red-700">
                  {{ '-' + holding.change.value + ' (-' + holding.change.percentage + '%)' }}</p>
              </template>
            </div>
          </div>
        </nuxt-link>
        <div v-else class="flex items-center justify-between mr-2 py-3">
          <div class="">
            <p class="ml-6 text-lg font-bold">{{ holding.name }}</p>
          </div>
          <div class="mr-4 text-right">
            <p class="text-md">{{ holding.balance }}</p>
            <template v-if="holding.change !== undefined">
              <p v-if="holding.change.type === 'positive'" class="text-sm text-green-700">
                {{ '+' + holding.change.value + ' (+' + holding.change.percentage + '%)' }}</p>
              <p v-else class="text-sm text-red-700">
                {{ '-' + holding.change.value + ' (-' + holding.change.percentage + '%)' }}</p>
            </template>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      banks: [
        {
          name: "POSB Savings",
          account: "104-83456-8",
          balance: "SGD 434.83",
        },
        {
          name: "SC JumpStart",
          account: "056-76390-0",
          balance: "SGD 18,894.50",
        },
        {
          name: "OCBC Savings",
          account: "104-83456-8",
          balance: "SGD 5,367.80",
        }],
      holdings: [
        {
          name: "Bonds",
          balance: "SGD 0.00",
        },
        {
          name: "Stocks",
          balance: "SGD 3,363.33",
          change: {
            type: "positive",
            value: 103.43,
            percentage: 5.41
          }
        },
        {
          name: "ETFs",
          balance: "SGD 2,013.63",
          change: {
            type: "negative",
            value: 371.87,
            percentage: 9.96
          }
        },
      ]
    }
  },
}
</script>

<style>
</style>
