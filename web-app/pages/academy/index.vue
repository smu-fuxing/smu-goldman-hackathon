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
        <video-playlist-card v-for="playlist in playlists" :key="playlist.name" class="py-4 mr-3"
                             style="flex: 0 0 auto; width: 300px" :playlist="playlist"></video-playlist-card>
      </div>
    </div>
  </div>
</template>

<script>
import ArticleCard from "~/components/academy/ArticleCard";
import VideoPlaylistCard from "~/components/academy/VideoPlaylistCard";

export default {
  name: "index",
  components: {ArticleCard, VideoPlaylistCard},
  data: function () {
    return {
      articles: [],
      playlists: [
        {
          name: "Investing Basics",
          urlToImage: "https://wealthfund.in/blog/wp-content/uploads/2017/03/wealthfund-personal-finance.jpg",
          videos: ["hE2NsJGpEq4", "_tEbIzKbZhY", "IuyejHOGCro", "kqr-h-pmky4", "00aPTfg3L9I", "3N6xlCxyWKY"]
        },
        {
          name: "Financial Planning",
          urlToImage: "https://www.manulife.com.sg/en/insights/_jcr_content/root/responsivegrid_641029165/responsivegrid/responsivegrid/contentteaser_518570_2106506410.coreimg.jpeg/1575362588384.jpeg",
          videos: ["3ez10ADR_gM", "NI9TLDIPVcs", "B43YEW2FvDs", "g9aDizJpd_s"]
        },
        {
          name: "Fundamentals of Economics",
          urlToImage: "https://news.yale.edu/sites/default/files/styles/featured_media/public/adobestock_257957753_ynews.jpeg?itok=I9HGiWNW&c=07307e7d6a991172b9f808eb83b18804",
          videos: ["3ez10ADR_gM", "NI9TLDIPVcs", "B43YEW2FvDs", "g9aDizJpd_s"]
        }
      ]
    }
  },
  async asyncData({$axios}) {
    const data = await $axios.$get("https://api.mavis-gs.com/news/academy")
    return {articles: data.articles}
  },
}
</script>

<style scoped>

</style>
