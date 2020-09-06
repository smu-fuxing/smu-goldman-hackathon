<template>
  <div class="flex">
    <div class="flex flex-col w-full">
      <label class="block text-white text-sm font-bold mb-2">
        {{ item.name }}
      </label>
      <select
        class="text-lg px-3 py-2 rounded focus:outline-none placeholder-goldman-darkBlue bg-transparent border-2 border-goldman-lightGrey text-white bg-opacity-75"
        style="height: 47px">
        <option v-for="option in item.options">{{ option }}</option>
      </select>
    </div>
  </div>
</template>

<script>
export default {
  name: "DropDownList",
  props: {
    item: Object,
  },
}
</script>

<style scoped>

</style>
