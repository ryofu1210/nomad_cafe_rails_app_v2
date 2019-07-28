<template>
  <div class="item-display">
    <!-- <h1>ItemDisplayHeading</h1> -->
    <h2 class="item-display__heading">{{ item.title }}</h2>
    <!-- {{datatitle}} -->
  </div>
</template>

<script>
export default {
  name: 'ItemDisplayHeading',

  props: {
    item: {
      type: Object
    }
  },

  // data(){
  //   return{
  //     datatitle: this.item.title
  //   }
  // }

}
</script>

<style scoped>
</style>
