<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="px-6 full-width">
      <h1 class="text-gray-900 text-4xl">Strategy</h1>
      <h3 class="text-gray-700 text-xl">Personal Finances</h3>

      <div class="rounded-lg mt-4">
        <strategy-card v-for="calculator in calculators" :key="calculator.name" class="py-4 mr-3"
                         style="flex: 0 0 auto; width: 300px" :playlist="calculator"></strategy-card>
      </div>
    </div>
  </div>
</template>

<script>
import StrategyCard from "~/components/strategy/StrategyCard";

export default {
  components: {StrategyCard},
  data() {
    return {
      calculators: [
        {
          name: "Saving Accounts",
          urlToImage: "https://dollarsandsense.sg/wp-content/uploads/2017/07/best-savings-account-2017-header.jpg",
          type: "savings"
        },
        {
          name: "Fundamental Analysis",
          urlToImage: "https://d28wu8o6itv89t.cloudfront.net/images/FundamentalAnalysisjpg-1581061384337.jpeg",
          type: "analysis"
        },
      ]
    }
  },
  methods: {
  }
}
</script>

<style>
</style>
