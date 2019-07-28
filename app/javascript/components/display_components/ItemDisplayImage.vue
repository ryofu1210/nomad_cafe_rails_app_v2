<template>
  <div class="item-display">
    <div class="item-display__imgbox">
    <img class="item-display__img" :src="item.image">
    </div>
  </div>
</template>

<script>
export default {
  name: 'ItemDisplayImage',

  props: {
    item: {
      type:Object
    }
  }
}
</script>

<style scoped>
</style>
