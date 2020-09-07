<template>
  <nuxt-link v-bind:to="'/strategy/' + playlist.type">
    <div class="rounded">
      <div class="max-w-sm lg:max-w-full lg:flex shadow">
        <div class="relative text-white">
          <div
            class="newscard h-40 lg:h-auto lg:w-48 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l overflow-hidden bg-opacity-50"
            v-bind:style="{ 'background-image': 'url(' + playlist.urlToImage + ')' }">
          </div>
          <span class="font-bold text-xl mb-2 text-left text-white absolute bottom-0 px-4">{{
              playlist.name
            }}</span>
        </div>
      </div>
    </div>
  </nuxt-link>
</template>

<script>
export default {
  name: "ArticleCard",
  props: {
    playlist: {
      type: Object,
      default: null,
      required: true,
    },
  },
  methods: {}
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
