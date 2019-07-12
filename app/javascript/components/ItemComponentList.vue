<template>
  <div class="item-component-list">
    <h1>ItemComponentList</h1>
    {{ items }}
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
  }
  // data (){
  //   return {
  //     items: {
  //       type:Array,
  //       default: ()=>{
  //         return []
  //       }
  //     }
  //   }
  // },


}
</script>

<style scoped>
</style>
