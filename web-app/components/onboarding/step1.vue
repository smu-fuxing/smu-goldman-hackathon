<template>
  <div class="flex-col">
    <h2 class="text-white text-xl md:text-2xl mb-10">Getting Started</h2>
    <div class="flex">
      <div class="flex flex-col w-1/3 pr-2">
        <text-input :item="{name: 'Age'}"></text-input>
      </div>
      <div class="flex flex-col w-2/3">
        <drop-down-list :item="{name: 'Gender', options: ['Male', 'Female']}"></drop-down-list>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <drop-down-list :item="{name: 'Marital Status', options: ['Single', 'Married', 'Divorced']}"></drop-down-list>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <text-input :item="{name: 'Number of Dependents'}"></text-input>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <drop-down-list :item="{name: 'Financial Literacy', options: ['Well Versed', 'Noob']}"></drop-down-list>
      </div>
    </div>
    <div class="flex pt-4">
      <div class="flex flex-col w-full">
        <drop-down-list :item="{name: 'Investment Experience', options: ['More than 5 years', 'Less than 5 years', 'No Experience']}"></drop-down-list>
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
