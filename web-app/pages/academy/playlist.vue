<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-3xl">Videos</h2>
      <h2 class="text-gray-900 text-xl text-goldman-gold">{{ this.$route.query.name }}</h2>
      <div class="flex flex-wrap justify-between">
        <div v-for="video in videos" class="w-full sm:w-1/2 md:w-1/2 lg:w-1/3 p-2 mb-4">
          <youtube class="py-4" :player-resize="true" :player-fit-parent="true" player-width="310" player-height="200"
                   :video-id="video"></youtube>
          <div class="flex justify-between">
            <div>
              <span class="text-sm">50</span>
              <img class="h-4 inline-block" src="~/static/img/coin-2.png" style="filter: invert(100%);">
            </div>
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold text-xs px-2 rounded">
              Watched
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "playlist",
  data() {
    return {
      videos: this.$route.query.videos.split(","),
    }
  },
}
</script>

<style scoped>
iframe {
  width: 100%;
  max-width: 650px; /* Also helpful. Optional. */
}
</style>
