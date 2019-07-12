<template>
<div>
  <h1>ItemForm</h1>
  <ItemFormHeading 
    v-if="item.target_type === 'ItemHeading'"
    v-bind="item"
    @editing-event="UpdateEditing"
  />
  <ItemFormText 
    v-else-if="item.target_type === 'ItemText'" 
  />
  <ItemFormImage 
    v-else-if="item.target_type === 'ItemImage'" 
  />

</div>
</template>

<script>
import ItemFormHeading from './form_components/ItemFormHeading';
import ItemFormText from './form_components/ItemFormText';
import ItemFormImage from './form_components/ItemFormImage';


export default {
  name: 'ItemForm',

  components: {
    ItemFormHeading,
    ItemFormText,
    ItemFormImage
  },

  props: {
    item: {
      type: Object
    }
  },

  methods: {
    UpdateEditing(){
      this.$emit('editing-event')
    }
  }

}
</script>

<style scoped>
</style>
