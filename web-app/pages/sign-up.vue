<template>
  <div class="container mx-auto px-6 pt-10 pb-48">
    <div class="flex content-center">
      <div class="rounded-lg bg-gray-200 flex-grow">
        <div class="px-6 py-6 flex-col">
          <h2>Sign Up</h2>

          <div class="mt-4">
            <input class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none" placeholder="Email"/>
          </div>

          <div class="mt-4">
            <input class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none" type="password"
                   placeholder="Password"/>
          </div>

          <div class="mt-4">
            <input class="w-full text-lg px-3 py-2 rounded bg-white focus:outline-none" type="password"
                   placeholder="Confirm Password"/>
          </div>

          <div class="mt-6">
            <n-link to="/app">
              <button
                class="w-full py-2 px-4 font-bold bg-blue-600 text-lg rounded text-white hover:bg-gray-700 focus:outline-none">
                Sign Up
              </button>
            </n-link>
          </div>

          <div class="mt-4">
            <n-link to="/sign-in" class="">
              <div class="text-sm text-center leading-snug">
                Already have an account? <u>You can sign in here</u>.
              </div>
            </n-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style>
</style>
