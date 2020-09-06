<template>
  <div class="rounded">
    <div class="max-w-sm w-full lg:max-w-full lg:flex shadow">
      <div
        class=" lg:h-auto lg:w-48 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l text-center overflow-hidden">
        <img :src="getImageUrl(news.urlToImage)"/>
      </div>
      <div
        class="border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal">
        <div class="mb-8">
          <div class="text-gray-900 font-bold text-xl mb-2">{{ news.title }}</div>
          <p class="text-gray-700 text-base">{{ getNewsText(news.content) }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ArticleCard",
  props: {
    news: {
      type: Object,
      default: null,
      required: true,
    },
  },
  methods: {
    getNewsText(text) {
      if (text == null) {
        return ""
      }
      const limitedText = text.substr(0, 120);
      if (limitedText.slice(-3) === "...") {
        return limitedText;
      }
      return limitedText + "...";
    },
    getImageUrl(imageUrl) {
      if (imageUrl !== null && imageUrl !== undefined && imageUrl.match(/^https?:\/\//)) {
        return imageUrl;
      }
    },
  },
}
</script>


<style scoped>
a {
  text-decoration: none;
}

.on-hover {
  transition: 0.3s;
  opacity: 0.7;
}
</style>
