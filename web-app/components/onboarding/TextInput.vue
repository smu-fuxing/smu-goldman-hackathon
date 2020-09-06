<template>
  <div class="flex">
    <div class="flex flex-col w-full">
      <label class="block text-white text-sm font-bold mb-2" :for="item.name">
        {{ item.name }}
      </label>
      <input
        class="text-lg px-3 py-2 rounded focus:outline-none placeholder-goldman-darkBlue bg-transparent border-2 border-goldman-lightGrey text-white bg-opacity-75"
        :placeholder="item.name"/>
    </div>
  </div>
</template>

<script>
export default {
  name: "TextInput",
  props: {
    item: Object,
  },
}
</script>

<style scoped>

</style>
