<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="rounded-lg full-width px-6">
      <h2 class="text-gray-900 text-4xl">Leaderboard</h2>
    </div>
    <div class="flex justify-start mx-5 pt-2 pb-4 border-b border-gray-400">
      <div>
        <img :src="profile.profileImage"
             class="w-24 rounded-full border-solid border-goldman-lightGrey border-4">
      </div>
      <div>
        <!--        <div class="ml-5 text-xl font-bold">{{ profile.name }}</div>-->
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
        <div>
          <input
            class="ml-5 mt-2 bg-white appearance-none border-2 border-gray-200 rounded py-1 pl-2 text-gray-700 leading-tight border-gray-600"
            placeholder="Find Friends">
        </div>
      </div>
    </div>

    <div class="mt-2">
      <div class="flex items-center justify-center">
        <button @click="overallSelected = true"
                class="mr-1 bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-l"
                v-bind:class="{'bg-gray-500':overallSelected}">
          Overall
        </button>
        <button @click="overallSelected = false"
                class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-r"
                v-bind:class="{'bg-gray-500':!overallSelected}">
          Weekly
        </button>
      </div>
    </div>

    <div class="mt-2">
      <div v-for="(friend, index) in friends" :class="{ 'bg-gray-300' : index % 2 === 1}">
        <div class="flex items-center justify-between mx-4 py-3">
          <div class="flex items-center">
            <img :src="friend.profileImage"
                 class="w-16 rounded-full border-solid border-goldman-lightGrey border-4">
            <span class="ml-6 text-xl font-bold">{{ friend.name }}</span>
          </div>
          <div class="mr-4">
            <span v-if="overallSelected" class="inline-block align-middle text-lg font-light">{{
                friend.overall
              }}</span>
            <span v-else class="inline-block align-middle text-lg font-light">{{ friend.weekly }}</span>
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
      overallSelected: true,
      profile: {
        name: "Gigi Teo",
        profileImage: "https://media-exp1.licdn.com/dms/image/C5103AQGI0dregkBLXg/profile-displayphoto-shrink_800_800/0?e=1605139200&v=beta&t=OA-OGNNlLR8AG9YZ2n9eMEErvZvqFO2OlQ1XlXr3ndk",
        overall: 369,
        weekly: 70
      },
      friends:
        [
          {
            name: "Fuxing",
            profileImage: "https://avatars1.githubusercontent.com/u/4266087?s=460&u=4a3b98a573ffeb1d80b3ebe163eeec17d4856d32&v=4",
            overall: 220,
            weekly: 40
          },
          {
            name: "Joel-David",
            profileImage: "https://avatars3.githubusercontent.com/u/4586209?s=460&u=daccf464c93966a6bb3cc909fb5c7785ff7f6ec4&v=4",
            overall: 180,
            weekly: 20
          },
          {
            name: "Ding Yang",
            profileImage: "https://avatars2.githubusercontent.com/u/38830767?s=460&u=8a75121de01411c174e7b0d93547b7673d7d43ac&v=4",
            overall: 1,
            weekly: 0
          },
        ]
    }
  },
}
</script>

<style scoped>

</style>
