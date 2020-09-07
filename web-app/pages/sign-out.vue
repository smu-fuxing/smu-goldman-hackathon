<template>
  <div>

  </div>
</template>

<script>
export default {
  layout: 'no-nav',
  mounted() {
    this.$amplify.signOut()
      .finally(() => {
        this.$router.push({path: '/sign-in'})
      })
  },
}
</script>

<style>
</style>
