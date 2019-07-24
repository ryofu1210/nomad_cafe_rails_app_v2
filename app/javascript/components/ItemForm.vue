<template>
<div class="item-form-box">
  <!-- <h1>ItemForm</h1> -->
  <ItemFormHeading 
    v-if="item.target_type === 'ItemHeading'"
    v-bind="item"
    :sortrank="sortrank"
    :totalcount="totalcount"
    @editing-event="UpdateEditing"
  />
  <ItemFormText 
    v-else-if="item.target_type === 'ItemText'" 
    v-bind="item"
    :sortrank="sortrank"
    :totalcount="totalcount"
    @editing-event="UpdateEditing"
  />
  <ItemFormImage 
    v-else-if="item.target_type === 'ItemImage'" 
    v-bind="item"
    :sortrank="sortrank"
    :totalcount="totalcount"
    @editing-event="UpdateEditing"
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
    },

    sortrank: {
      type:Number,
      required: true
    },

    totalcount: {
      type:Number,
      required: true
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
<style>
</style>
