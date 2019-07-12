<template>
  <div class="item-component__box" @mouseover="menuShown = true" @mouseleave="menuShown = false">
    <div class="item-component__menu" v-if="menuShown && !editing">
      <button @click="handleDown(sortrank, totalcount)">下に移動</button>
      <button @click="handleUp(sortrank)">上に移動</button>
      <button 
        v-if="!editing" 
        @click="handleEditingStart(sortrank)"
      >
      修正
      </button>
      <button @click="handleDelete(sortrank)">削除</button>
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
.item-component__box{
  position: relative;
}
.item-component__menu{
  /* display:fixed; */
  position: absolute;
  top:100;
  left:0;
}
.item-component__content{
  min-height: 50px;
  padding:10px 0 0 0;
  margin-bottom:30px;
}

</style>
