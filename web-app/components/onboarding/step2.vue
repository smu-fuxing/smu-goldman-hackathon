<template>
  <div class="flex-col">
    <h2 class="text-white text-xl md:text-2xl mb-10 text-goldman-gold">Getting Started</h2>

    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <text-input :item="{name: 'Number of Dependents'}"></text-input>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <text-input :item="{name: 'Monthly Gross Household Income'}"></text-input>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <text-input :item="{name: 'Monthly Expenses'}"></text-input>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <text-input :item="{name: 'Monthly Savings'}"></text-input>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <drop-down-list :item="{name: 'Employment Status', options: ['Student', 'Full Time', 'Part Time', 'Unemployed']}"></drop-down-list>
      </div>
    </div>
  </div>
</template>

<script>
import DropDownList from "~/components/onboarding/DropDownList";
import TextInput from "~/components/onboarding/TextInput";

export default {
  components: {DropDownList, TextInput},
  name: "step1"
}
</script>

<style scoped>

</style>
