<template>
  <div class="item-component-list">
    <!-- <h1>ItemComponentList</h1> -->
    <!-- {{ items }} -->
    <div class="item-component-list__menu">
      <button 
        @click="handleAdd('heading', totalcount)"
        class="item-component-list__menu-btn menu-add__item_heading"
      >
      見出し追加
      </button>
      <button 
        @click="handleAdd('text', totalcount)"
        class="item-component-list__menu-btn menu-add__item_text"
      >
      本文追加
      </button>
      <button 
        @click="handleAdd('image', totalcount)"
        class="item-component-list__menu-btn menu-add__item_image"
      >
      画像追加
      </button>
    </div>
    <ul>
      <li v-for="(item, index) in items" :key="item.id">
        <ItemComponent :item="item" :sortrank="index" :totalcount="totalcount" />
      </li>
    </ul>
  </div>
</template>

<script>
import ItemComponent from './ItemComponent';

export default {
  name: 'ItemComponentList',

  components: {
    ItemComponent
  },

  props: {
    items:{
      type:Array,
      default: ()=>[]
    }
  },

  computed: {
    totalcount() {
      return this.items.length
    }
  },

  methods:{
    handleAdd(type, totalcount){
      this.$store.dispatch('addItem',{type: type, totalcount:totalcount})
    }
  }

}
</script>

<style scoped>
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}
ul li {
  margin: 8px;
  padding: 4px;
  /* border: thin solid black; */
  /* border-radius: 0.5em; */
}
</style>
