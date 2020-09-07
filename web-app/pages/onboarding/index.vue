<template>
  <div class="bg-goldman-darkBlue full-width h-full">
    <div class="container md:w-3/5 lg:w-1/3 mx-auto md:px-6 md:pt-10 bg-goldman-darkBlue h-screen">
      <div class="container mx-auto px-6 pt-10">
        <div class="shadow w-full bg-white bg-opacity-75 rounded mb-6">
          <div class="bg-goldman-accent rounded leading-none py-1 text-center text-white"
               :style="{ width: step_index/5*100  + '%' }"></div>
        </div>
        <message v-if="step_index <= 1" :item="messages[step_index]" @eventname="incrementStep"></message>
        <div v-else-if="step_index === 2">
          <step1></step1>
        </div>
        <div v-else-if="step_index === 3">
          <step2></step2>
        </div>
        <div v-else-if="step_index === 4">
          <step3></step3>
        </div>
        <div v-else-if="step_index === 5">
          <message :item="messages[2]" @eventname="incrementStep"></message>
        </div>
      </div>
      <div class="mt-20 px-5">
        <div v-if="step_index === 0">
          <button @click="step_index++"
                  class="w-full py-3 px-4 font-bold bg-goldman-accent text-sm uppercase rounded text-goldman-darkBlue hover:bg-gray-700 focus:outline-none">
            Get Started
          </button>
        </div>
        <div v-else class="px-4 pt-6 flex justify-between" v-if="step_index > 0">
          <button @click="step_index--"
                  class="py-3 px-4 font-bold text-sm uppercase rounded text-goldman-accent hover:bg-gray-700 focus:outline-none">
            Back
          </button>
          <button v-if="step_index < 5" @click="step_index++"
                  class="py-3 px-4 font-bold bg-goldman-accent text-sm uppercase rounded text-goldman-darkBlue hover:bg-gray-700 focus:outline-none">
            Next
          </button>
          <nuxt-link v-else to="/dashboard">
            <button
              class="py-3 px-4 font-bold bg-goldman-accent text-sm uppercase rounded text-goldman-darkBlue hover:bg-gray-700 focus:outline-none">
              Done
            </button>
          </nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Message from "~/components/onboarding/message";
import Step1 from "~/components/onboarding/step1";
import Step2 from "~/components/onboarding/step2";
import Step3 from "~/components/onboarding/step3";

export default {
  data() {
    return {
      step_index: 0,
      messages: [
        {
          header: 'Welcome',
          text: 'I am Mavis, your guide to achieve financial independence. I know adulthood may be daunting, so I am here to help.',
        },
        {
          header: 'Before we begin',
          text: 'Every individual is unique. For me to understand you better, please complete the short questionnaire in the next section. It will only take a few minutes, just enough time to cook your instant noodles.',
        },
        {
          header: 'Thank You',
          text: 'Let’s begin on your journey to achieve financial independence!',
        }
      ]
    }
  },
  components: {
    Message, Step1, Step2, Step3
  },
  layout: 'no-nav',
  methods: {
    incrementStep(variable) {
      this.step_index = variable
    }
  }
}
</script>

<style scoped>

</style>
