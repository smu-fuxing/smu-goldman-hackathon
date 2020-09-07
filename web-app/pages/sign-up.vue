<template>
  <div class="bg-goldman-darkBlue full-width h-full">
    <div class="container md:w-1/3 mx-auto px-6 pt-10 bg-goldman-darkBlue h-screen">
      <div class="flex content-center">
        <div class="rounded-lg flex-grow">
          <div class="px-6 py-6 flex-col">
            <img src="~/static/Goldman_Sachs.svg" class="rounded w-24"/>
          </div>
          <div class="px-6 py-6 flex-col">
            <h2 class="text-white text-4xl text-goldman-gold">Welcome</h2>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2" for="username">
                Username
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none placeholder-goldman-darkBlue bg-goldman-lightGrey bg-opacity-75"
                placeholder="Username"/>
            </div>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2" for="username">
                Password
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none placeholder-goldman-darkBlue bg-goldman-lightGrey bg-opacity-75"
                type="password"
                placeholder="Password"/>
            </div>

            <div class="mt-4">
              <label class="block text-white text-sm font-bold mb-2" for="username">
                Confirm Password
              </label>
              <input
                class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none placeholder-goldman-darkBlue bg-goldman-lightGrey bg-opacity-75"
                type="password"
                placeholder="Password"/>
            </div>

            <div class="mt-20">
              <n-link to="/onboarding/">
                <button
                  class="w-full py-3 px-4 font-bold bg-goldman-accent text-sm uppercase rounded text-white hover:bg-gray-700 focus:outline-none">
                  Create Account
                </button>
              </n-link>
            </div>
            <div class="mt-4">
              <n-link to="/sign-in" class="">
                <div class="text-sm text-center leading-snug text-white text-opacity-75">
                  Already have an account? <u>You can sign in here</u>.
                </div>
              </n-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'no-nav',
}
</script>

<style>
</style>
