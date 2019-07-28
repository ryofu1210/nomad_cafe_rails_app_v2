<template>
  <div class="item-display">
    <p class="item-display__text">{{ item.body }}</p>
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
