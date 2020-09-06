<template>
  <div class="bg-goldman-darkGrey border-b-2 border-goldman-lightGrey border-opacity-25">
    <div class="container mx-auto">
      <nav class="flex items-center justify-between flex-wrap p-5">
        <div class="flex flex-col  flex-shrink-0 text-white mr-10">
          <span class="font-semibold text-xl tracking-tight">Mavis</span>
          <span class="font-light text-white text-opacity-75 text-sm tracking-tight -mt-2">By Goldman Sachs</span>
        </div>
        <div class="block lg:hidden">
          <button @click="isOpen = !isOpen" type="button" class="block text-white hover:text-white focus:text-white focus:outline-none">
            <svg class="h-6 w-6 fill-current" viewBox="0 0 24 24">
              <path v-if="isOpen" fill-rule="evenodd" d="M18.278 16.864a1 1 0 0 1-1.414 1.414l-4.829-4.828-4.828 4.828a1 1 0 0 1-1.414-1.414l4.828-4.829-4.828-4.828a1 1 0 0 1 1.414-1.414l4.829 4.828 4.828-4.828a1 1 0 1 1 1.414 1.414l-4.828 4.829 4.828 4.828z"/>
              <path v-if="!isOpen" fill-rule="evenodd" d="M4 5h16a1 1 0 0 1 0 2H4a1 1 0 1 1 0-2zm0 6h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2zm0 6h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2z"/>
            </svg>
          </button>
        </div>
        <div class="w-full flex-grow hidden lg:block lg:flex lg:items-center lg:w-auto">
          <div class="text-sm lg:flex-grow">
            <a href="/academy" class="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-500 mr-6">
              Dashboard
            </a>
            <a href="/academy" class="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-500 mr-6">
              Academy
            </a>
            <a href="/leaderboard" class="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-500 mr-6">
              Leaderboard
            </a>
            <a href="/news" class="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-500 mr-6">
              News
            </a>
            <a href="/strategy" class="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-500 mr-6">
              Strategy
            </a>
            <a href="/profile" class="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-500">
              Profile
            </a>
          </div>
        </div>
      </nav>
      <div :class="isOpen ? 'block' : 'hidden'" class="px-4 pt-1 pb-4">
        <a href="/dashboard" class="block px-2 py-1 text-white font-semibold rounded hover:bg-gray-800">Dashboard</a>
        <a href="/academy" class="block px-2 py-1 text-white font-semibold rounded hover:bg-gray-800">Academy</a>
        <a href="/leaderboard" class="mt-1 block px-2 py-1 text-white font-semibold rounded hover:bg-gray-800">Leaderboard</a>
        <a href="/news" class="mt-1 block px-2 py-1 text-white font-semibold rounded hover:bg-gray-800">News</a>
        <a href="/strategy" class="mt-1 block px-2 py-1 text-white font-semibold rounded hover:bg-gray-800">Strategy</a>
        <a href="/profile" class="mt-1 block px-2 py-1 text-white font-semibold rounded hover:bg-gray-800">Profile</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "NavHeader",
  data() {
    return {
      isOpen: false,
    }
  },
}
</script>

<style scoped>

</style>
