<template>
  <div>
    <!-- <h1>ItemDisplayHeading</h1> -->
    <h2 class="heading">{{ item.title }}</h2>
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


}
</script>

<style scoped>
.heading{
  padding: 0 0 0 10px;
  border-left: 5px solid red;
  font-size: 25px;
}
</style>
