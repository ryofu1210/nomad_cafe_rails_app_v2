<template>
  <div class="item-display__imgbox">
    <!-- <h1>ItemDisplayImage</h1> -->
    <img class="item-display__img" :src="item.image">
    <!-- {{item}} -->
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
.item-display__imgbox{
  width:400px;
  height: auto;
}
.item-display__img{
  width:100%;
  height:100%;
}
</style>
