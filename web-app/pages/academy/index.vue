<template>
  <div class="mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Academy</h2>
    </div>
    <div class="rounded-lg">
      <h2 class="text-gray-900 text-xl px-6">News</h2>
      <div class="flex flex-no-wrap overflow-x-auto scrolling-touch pl-6">
        <article-card v-for="article in articles" :key="article.url" class="py-4 mr-3" :news="article"
                      style="flex: 0 0 auto; width: 300px"></article-card>
      </div>
    </div>
    <div class="rounded-lg">
      <h2 class="text-gray-900 text-xl px-6">Videos</h2>
      <div class="flex flex-no-wrap overflow-x-auto scrolling-touch pl-6">
        <youtube class="py-4 mr-3" :player-vars="{ autoplay: 1 }" :player-width="300" :player-height="200" video-id="Dugn51K_6WA"/>
        <youtube class="py-4 mr-3" :player-vars="{ autoplay: 1 }" :player-width="300" :player-height="200" video-id="Dugn51K_6WA"/>
        <youtube class="py-4 mr-3" :player-vars="{ autoplay: 1 }" :player-width="300" :player-height="200" video-id="Dugn51K_6WA"/>
      </div>
    </div>
  </div>
</template>

<script>
import ArticleCard from "~/components/news/ArticleCard";

export default {
  name: "index",
  components: {ArticleCard},
  data: function () {
    return {
      articles: []
    }
  },
  async asyncData({$axios}) {
    const data = await $axios.$get("/api/news")
    return {articles: data.articles}
  },
}
</script>

<style scoped>

</style>
