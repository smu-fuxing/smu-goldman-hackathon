<template>
  <div class="bg-goldman-darkBlue full-width">
    <div class="container md:w-3/5 lg:w-1/3 mx-auto px-6 pt-10 bg-goldman-darkBlue h-screen">
      <div class="flex content-center">
        <div class="rounded-lg flex-grow">
          <div class="px-6 py-6 flex-col">
            <img src="~/static/Goldman_Sachs.svg" class="rounded w-24"/>
          </div>
          <form class="px-6 py-6 flex-col" @submit.prevent="signIn">
            <h2 class="text-white text-4xl text-goldman-gold">Hello</h2>

            <div class="mt-4 rounded bg-white py-2 px-4" v-if="errorMessage">
              <h6 class="text-black">{{ errorMessage }}</h6>
            </div>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2">
                Email
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none bg-goldman-lightGrey bg-opacity-75"
                v-model="username" type="email" placeholder="Email"/>
            </div>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2">
                Password
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none bg-goldman-lightGrey bg-opacity-75"
                v-model="password" type="password" minlength="8" placeholder="Password"/>
            </div>

            <div class="mt-20">
              <div>
                <button
                  class="w-full py-2 px-4 font-bold bg-goldman-accent text-lg rounded text-white hover:bg-gray-700 focus:outline-none">
                  Sign In
                </button>
              </div>
            </div>

            <div class="mt-4">
              <n-link to="/sign-up" class="">
                <div class="text-sm text-center leading-snug text-white text-opacity-75">
                  Don't have an account? <u>You can register one here</u>.
                </div>
              </n-link>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  layout: 'no-nav',
  data() {
    return {
      username: "",
      password: "",
      errorMessage: ""
    }
  },
  methods: {
    signIn() {
      if (!this.password || !this.username) {
        return
      }

      this.$amplify.signIn(this.username, this.password)
        .then((user) => {
          this.$router.push({path: '/dashboard'})
        })
        .catch((err) => {
          this.errorMessage = err.message
        })
    }
  }
}
</script>

<style>
</style>
