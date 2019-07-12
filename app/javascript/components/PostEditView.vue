<template>
  <div class="post-view">
    <h1>PostEditView</h1>
    <!-- <ul>
      <li v-for="item in items" :key="item.id">
        {{item.sortrank}}
      </li>
    </ul> -->
    <ItemComponentList :items="items" />
  </div>
</template>

<script>
import ItemComponentList from './ItemComponentList';

export default {
  name: 'PostEditView',

  components: {
    ItemComponentList
  },

  data: ()=> {
    return {
      message: "Hello Vue! Post Edit View",

      // items:{
      //   type: Array,
      //   default: ()=>{
      //     return []
      //   } 
      // },
    }
  },

  mounted(){
    this.LoadItems()
  },

  computed: {
    items (){
      return this.$store.state.items
    }
  },

  methods: {
    LoadItems(){
      const id = this.$route.params.id
      console.log(id)
      // const id = parseInt(this.$route.params.id)
      this.$store.dispatch('fetchAllItems',{id})
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
