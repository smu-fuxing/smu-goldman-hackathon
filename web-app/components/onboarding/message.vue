<template>
  <div class="px-6 py-6 flex-col">
    <div class="flex content-center py-10">
      <girl-clip-board-with-bg class="w-full h-50"/>
    </div>
    <div class="text-center pt-10">
      <h2 class="text-white text-4xl">{{ item.header }}</h2>
    </div>
    <div class="text-center pt-5">
      <p class="text-white text-opacity-75">{{ item.text }}</p>
    </div>
  </div>
</template>

<script>
import GirlClipBoardWithBg from "~/images/GirlClipBoardWithBg";

export default {
  components: {
    GirlClipBoardWithBg
  },
  name: "message",
  props: {
    item: Object,
  },
  methods: {
    next_step: function () {
      this.$emit('eventname', 1)
    }
  }
}
</script>

<style scoped>

</style>
