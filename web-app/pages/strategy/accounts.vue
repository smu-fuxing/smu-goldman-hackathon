<template>
  <div class="container mx-auto pt-6 pb-48 bg-goldman-grey h-full overflow-hidden">
    <div class="px-6 full-width">
      <h1 class="text-gray-900 leading-tight text-4xl">Strategy</h1>
      <h3 class="text-gray-700 text-xl">Recommended Saving Account</h3>

      <div class="mt-2">
        <div v-for="item in items" class="py-3">
          <div class="bg-white rounded p-4">
            <h4 class="text-black font-bold">{{ item.title }}</h4>

            <div class="flex justify-between items-end">
              <div>
                <div class="flex items-center mt-1 mb-1">
                  <div class="font-bold text-gray-800">
                    S${{ item.value }}
                  </div>
                </div>

                <div class="text-xs text-gray-700">INTEREST PER MONTH</div>
              </div>

              <button class="bg-goldman-darkBlue text-white px-3 py-2 rounded-lg font-medium">
                Apply
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  asyncData({$axios, query}) {
    return $axios.get('https://api.mavis-gs.com/api/savings-account', {params: query})
      .then(({data: {data: map}}) => {
        return {
          map, query,
          items: Object.keys(map)
            .map((key) => {
              return {
                title: key,
                value: Math.round(map[key] * 100) / 100
              }
            })
            .filter(({value}) => value > 0)
            .sort((a, b) => b.value - a.value)
        }
      })
  }
}
</script>
