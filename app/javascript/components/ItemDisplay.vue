<template>
  <div>
    <h1>ItemDisplay</h1>
    <!-- <p>{{ item }}</p> -->
    <ItemDisplayHeading 
      v-if="item.target_type === 'ItemHeading'" 
      :item="item" 
    />
    <ItemDisplayText 
      v-else-if="item.target_type === 'ItemText'" 
      :item="item" 
    />
    <ItemDisplayImage 
      v-else-if="item.target_type === 'ItemImage'" 
      :item="item" 
    />
  </div>
</template>

<script>
import ItemDisplayHeading from './display_components/ItemDisplayHeading';
import ItemDisplayText from './display_components/ItemDisplayText';
import ItemDisplayImage from './display_components/ItemDisplayImage';


export default {
  name: 'ItemDisplay',

  components: {
    ItemDisplayHeading,
    ItemDisplayText,
    ItemDisplayImage
  },

  props: {
    item: {
      type: Object
    }
  }



}
</script>

<style scoped>
</style>
