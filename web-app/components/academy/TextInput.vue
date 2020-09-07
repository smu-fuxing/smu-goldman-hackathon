<template>
  <div class="flex mt-3">
    <div class="flex flex-col w-full">
      <label class="block text-black text-sm font-bold mb-1" :for="item.name">
        {{ item.name }}
      </label>
      <input
        :type="type"
        class="text-lg px-3 py-2 rounded focus:outline-none placeholder-goldman-darkBlue bg-transparent border-2 border-goldman-darkBlue text-goldman-darkBlue bg-opacity-75"
        :placeholder="item.name" v-model="value" @keyup="$emit('update:value', value);"/>
    </div>
  </div>
</template>

<script>
export default {
  name: "TextInput",
  props: {
    item: Object,
    value: String,
    type: String,
  },
}
</script>

<style scoped>

</style>
