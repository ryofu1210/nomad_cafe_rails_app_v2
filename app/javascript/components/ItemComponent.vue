<template>
  <div class="item-component" @mouseover="menuShown = true" @mouseleave="menuShown = false">
    <div class="item-component__menu" v-if="menuShown && !editing">
      <button 
        @click="handleDown(sortrank, totalcount)"
        class="item-component__menu-btn"
      >
      下に移動
      </button>
      <button 
        @click="handleUp(sortrank)"
        class="item-component__menu-btn"
      >
      上に移動
      </button>
      <button 
        v-if="!editing" 
        @click="handleEditingStart(sortrank)"
        class="item-component__menu-btn"
      >
      修正
      </button>
      <button 
        @click="handleDelete(sortrank)"
        class="item-component__menu-btn"
      >
      削除
      </button>
    </div>
    <div class="item-component__content">
      <ItemForm 
        v-if="editing === true" 
        :item="item" 
        :sortrank="sortrank"
        :totalcount="totalcount"
        @editing-event="handleEditingFinish(sortrank)"
      />
      <ItemDisplay 
        v-else 
        :item="item" 
      />
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

  data (){
    return {
      menuShown: false,
    }
  },

  computed: {
    editing(){
      return this.item.editing
    }
  },

  methods: {
    // changeMenuShown (){
    //   if(this.menuShown === true){
    //     this.menuShown = false
    //   }else{
    //     this.menuShown = true
    //   }
    // },

    handleDown (sortrank, totalcount){
      this.$store.dispatch('moveItemDown',{sortrank, totalcount})
    },

    handleUp (sortrank){
      this.$store.dispatch('moveItemUp',{sortrank})
    },

    handleEditingStart(sortrank){
      const newItem = {editing: true}
      this.$store.dispatch('updateItem', {newItem: newItem, sortrank: sortrank})
    },

    // handleEditing(sortrank){
    //   this.$store.dispatch('changeEditing',{sortrank})
    // },

    handleDelete (sortrank){
      this.$store.dispatch('deleteItem',{sortrank})
    },

    handleEditingFinish(sortrank){
      // console.log()
      const newItem = {editing: false}
      this.$store.dispatch('updateItem', {newItem: newItem, sortrank: sortrank})
    }
}


}
</script>

<style scoped>
</style>
