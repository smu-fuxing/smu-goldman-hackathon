<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Leaderboard</h2>
    </div>
    <div class="flex justify-start mx-5 pt-2 pb-4 border-b border-gray-400">
      <img :src="profile.profileImage"
           class="w-20 rounded-full border-solid border-goldman-lightGrey border-4">
      <div>
        <div class="ml-5 text-xl font-bold">{{ profile.name }}</div>
        <div class="flex">
          <div class="ml-5">
            <div class="font-bold text-md">Overall</div>
            <span class="font-light text-lg">{{ profile.overall }}</span>
            <img class="h-4 inline-block" src="~/static/img/coin-2.png" style="filter: invert(100%);">
          </div>
          <div class="ml-16">
            <div class="font-bold text-md">Weekly</div>
            <span class="font-light text-lg">{{ profile.weekly }}</span>
            <img class="h-4 inline-block" src="~/static/img/coin-2.png" style="filter: invert(100%);">
          </div>
        </div>
      </div>
    </div>
    <div class="mt-5">
      <div v-for="(friend, index) in friends" :class="{ 'bg-gray-300' : index % 2 === 1}">
        <div class="flex items-center justify-between mx-4 py-3">
          <div class="flex items-center">
            <img :src="friend.profileImage"
                 class="w-16 rounded-full border-solid border-goldman-lightGrey border-4">
            <span class="ml-6 text-xl font-bold">{{ friend.name }}</span>
          </div>
          <div class="mr-4">
            <span class="inline-block align-middle text-lg font-light">{{ friend.overall }}</span>
            <img class="h-4 inline-block" src="~/static/img/coin-2.png" style="filter: invert(100%);">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "index",
  data() {
    return {
      profile: {
        name: "Ding Yang",
        profileImage: "https://avatars2.githubusercontent.com/u/38830767?s=460&u=8a75121de01411c174e7b0d93547b7673d7d43ac&v=4",
        overall: 200,
        weekly: 60
      },
      friends:
        [
          {
            name: "Fuxing",
            profileImage: "https://avatars1.githubusercontent.com/u/4266087?s=460&u=4a3b98a573ffeb1d80b3ebe163eeec17d4856d32&v=4",
            overall: 200,
            weekly: 60
          },
          {
            name: "Joel-David",
            profileImage: "https://avatars3.githubusercontent.com/u/4586209?s=460&u=daccf464c93966a6bb3cc909fb5c7785ff7f6ec4&v=4",
            overall: 200,
            weekly: 60
          }
        ]
    }
  },
}
</script>

<style scoped>

</style>
