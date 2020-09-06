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
      <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
          <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
        </svg>
      </div>
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
