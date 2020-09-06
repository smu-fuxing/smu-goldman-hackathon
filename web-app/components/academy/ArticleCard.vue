<template>
  <div class="rounded">
    <div class="max-w-sm lg:max-w-full lg:flex shadow rounded">
    <div class="relative text-white">
      <div
        class="newscard h-40 lg:h-auto lg:w-48 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l overflow-hidden bg-opacity-50"
        v-bind:style="{ 'background-image': 'url(' + getImageUrl(news.urlToImage) + ')' }">
      </div>
      <span class="font-bold text-xl mb-2 text-left text-white absolute bottom-0 px-4">{{ getNewsHeadline(news.title) }}</span>
    </div>
      <div
        class="border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal">
        <div class="">
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
    getNewsHeadline(text) {
      if (text == null) {
        return ""
      }

      if (text.length < 60) {
        return text
      }

      const limitedText = text.substr(0, 70);
      if (limitedText.slice(-3) === "...") {
        return limitedText;
      }
      return limitedText + "...";
    },
    getNewsText(text) {
      if (text == null) {
        return ""
      }
      const limitedText = text.substr(0, 80);
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

.newscard::before {
  content: "";
  display: block;
  -webkit-filter: blur(1px) brightness(0.5);
  -moz-filter: blur(1px) brightness(0.5);
  -ms-filter: blur(1px) brightness(0.5);
  -o-filter: blur(1px) brightness(0.5);
  filter: blur(1px) brightness(0.5);
  position: absolute;
  left: 0;
  top: 0;
  right: 0;
  bottom: 0;
  background: inherit;
  z-index: 0;
}
</style>
