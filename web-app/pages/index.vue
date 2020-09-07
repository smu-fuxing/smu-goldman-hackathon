<template>
  <div>
  </div>
</template>

<script>
export default {
  asyncData({$amplify}) {
    return {
      user: $amplify.getUser()
    }
  },
  mounted() {
    if (this.$amplify.getUser()) {
      this.$router.push('/dashboard')
    } else {
      this.$router.push('/sign-in')
    }
  }
}
</script>

<style>
</style>
