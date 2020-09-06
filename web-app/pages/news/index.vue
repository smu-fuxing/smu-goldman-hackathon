<template>
  <div class="container mx-auto px-6 pt-6 pb-48 bg-goldman-darkBlue h-full">
    <div class="flex content-center">
      <div class="rounded-lg flex-grow">
        <h2 class="text-white text-4xl">Financial News</h2>
        <article-card v-for="article in articles" :key="article.url"  class="py-4" :news="article"></article-card>
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
