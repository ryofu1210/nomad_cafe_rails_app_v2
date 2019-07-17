<template>
  <div>
    <!-- <h1>ItemDisplayHeading</h1> -->
    <h2 class="heading">{{ item.title }}</h2>
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
.heading{
  padding: 0 0 0 10px;
  border-left: 5px solid red;
  font-size: 25px;
}
</style>
