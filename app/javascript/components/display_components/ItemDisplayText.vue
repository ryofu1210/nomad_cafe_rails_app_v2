<template>
  <div>
    <h1>ItemDisplayText</h1>
    <p>{{ item.body }}</p>
  </div>

</template>

<script>
export default {
  name: 'ItemDisplayText',

  props: {
    item: {
      type:Object
    }
  }
}
</script>

<style scoped>
</style>
