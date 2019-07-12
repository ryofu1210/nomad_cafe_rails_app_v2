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
.item-form{
  border:1px solid #ddd;
  margin-bottom:30px;

}
.item-form__header{
  font-size:12px;
  background-color:#eee;
  font-weight: bold;
  padding:2px 5px;
}
.item-form__content{
  padding:15px 10px;

}
.item-form__textarea{
  width:100%;
  font-size:20px;
  background-color:#eee;
}
</style>
