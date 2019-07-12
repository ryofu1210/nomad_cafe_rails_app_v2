<template>
  <div>
    <h1>ItemDisplayHeading</h1>
    <h2>{{ item.title }}</h2>
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
</style>
