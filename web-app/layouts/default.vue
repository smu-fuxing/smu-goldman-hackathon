<template>
  <div class="h-screen bg-goldman-grey">
    <NavHeader/>
    <div>
      <Nuxt/>
    </div>
  </div>
</template>

<style>

</style>
<script>
import NavHeader from "@/components/nav/NavHeader";

export default {
  components: {NavHeader}
}
</script>
