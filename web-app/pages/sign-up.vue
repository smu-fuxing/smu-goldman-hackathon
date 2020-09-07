<template>
  <div class="bg-goldman-darkBlue full-width h-full">
    <div class="container md:w-3/5 lg:w-1/3 mx-auto px-6 pt-10 bg-goldman-darkBlue h-screen">
      <div class="flex content-center">
        <div class="rounded-lg flex-grow">
          <div class="px-6 py-6 flex-col">
            <img src="~/static/Goldman_Sachs.svg" class="rounded w-24"/>
          </div>
          <form class="px-6 py-6 flex-col" @submit.prevent="signUp">
            <h2 class="text-white text-4xl text-goldman-gold">Welcome</h2>
            <div class="mt-4 rounded bg-white py-2 px-4" v-if="errorMessage">
              <h6 class="text-black">{{ errorMessage }}</h6>
            </div>
            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2">
                Email
              </label>
              <input
                type="email"
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none placeholder-goldman-darkBlue bg-goldman-lightGrey bg-opacity-75"
                placeholder="Email" v-model="username"/>
            </div>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2">
                Password
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none placeholder-goldman-darkBlue bg-goldman-lightGrey bg-opacity-75"
                type="password"
                minlength="8"
                v-model="password"
                placeholder="Password"/>
            </div>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2">
                Confirm Password
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none placeholder-goldman-darkBlue bg-goldman-lightGrey bg-opacity-75"
                minlength="8"
                type="password" v-model="confirmPassword"
                placeholder="Password"/>
            </div>

            <div class="mt-20">
              <div>
                <button
                  class="w-full py-3 px-4 font-bold bg-goldman-accent text-sm uppercase rounded text-white hover:bg-gray-700 focus:outline-none">
                  Create Account
                </button>
              </div>
            </div>
            <div class="mt-4">
              <n-link to="/sign-in" class="">
                <div class="text-sm text-center leading-snug text-white text-opacity-75">
                  Already have an account? <u>You can sign in here</u>.
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
      confirmPassword: "",
      errorMessage: ""
    }
  },
  methods: {
    signUp() {
      if (!this.username || !this.password || !this.confirmPassword) {
        return
      }
      if (this.password !== this.confirmPassword) {
        return
      }

      this.$amplify.signUp(this.username, this.password)
        .then((user) => {
          return this.$router.push({path: '/onboarding/'})
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
