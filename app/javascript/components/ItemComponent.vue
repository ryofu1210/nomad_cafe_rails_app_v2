<template>
  <div class="item-component">
    <h1>ItemComponentList</h1>
    <div>
      {{ item.sortrank }}
    </div>
    <div>
      <button @click="handleDown(sortrank, totalcount)">下に移動</button>
      <button @click="handleUp(sortrank)">上に移動</button>
      <button @click="handleUpdate">修正</button>
      <button @click="handleDelete">削除</button>
    </div>
    <div class="component">
      <ItemForm 
        v-if="editing === true" 
        :item="item" 
        @editing-event="UpdateEditing"
      />
      <ItemDisplay v-else :item="item" />
    </div>
  </div>
</template>

<script>
import ItemDisplay from './ItemDisplay';
import ItemForm from './ItemForm';

export default {
  name: 'ItemComponent',

  components: {
    ItemDisplay,
    ItemForm
  },

  data (){
    return{
      editing: false
    }
  },

  props: {
    item:{
      type:Object
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
    handleDown (sortrank, totalcount){
      this.$store.dispatch('moveItemDown',{sortrank, totalcount})
    },

    handleUp (sortrank){
      this.$store.dispatch('moveItemUp',{sortrank})
    },

    handleUpdate(){
      this.editing = true
    },

    handleDelete (sortrank){
      this.$store.dispatch('deleteItem',{sortrank})
    },

    UpdateEditing(){
      this.editing = false
    }
}


}
</script>

<style scoped>
.item-component{
  border: 1px solid black;
}
</style>
