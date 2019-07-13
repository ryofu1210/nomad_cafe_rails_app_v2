<template>
  <div class="post-view">
    
    <!-- <img :src="post_params.image" > -->
    <div class="container-header">
      <PostEditHeader :post="post_params" />
    </div>
    <div class="container-items">
      <ItemComponentList :items="items" />
    </div>
    <div class="container-submit__box">
      <button 
        class="container-submit__button"
        @click="handleSubmit(post_params, items)"
      >
      保存
      </button>
    </div>
  </div>
</template>

<script>
import ItemComponentList from './ItemComponentList';
import PostEditHeader from './PostEditHeader';

export default {
  name: 'PostEditView',

  components: {
    ItemComponentList,
    PostEditHeader
  },

  data: ()=> {
    return {
      // message: "Hello Vue! Post Edit View",
      // id: this.$route.params.id,

    }
  },

  created(){
    this.LoadItems()
  },

  computed: {
    items (){
      return this.$store.state.items
    },

    post_params (){
      return this.$store.state.post
    }
  },

  methods: {
    LoadItems(){
      const id = this.$route.params.id
      // console.log(id)
      // const id = parseInt(this.$route.params.id)
      this.$store.dispatch('fetchAllItems',{id})
    },

    handleSubmit(post_params, items){
      const id = this.$route.params.id
      this.$store.dispatch('update', {id, post_params, items})
    }
  }
}
</script>

<style scoped>
.container-items{
  width:600px;
  height:100%;
  margin:0 auto;
}
.container-submit__box{
  position:fixed;
  bottom:0;
  left:0;
  width:100%;
  padding:15px 0;
  background-color:rgba(0, 0, 0, 0.3);
}
.container-submit__button{
  color:white;
  background-color:#3f51b5;
  border:1px solid #283593;
  padding:7px 10px;
  font-size:12px;
  font-weight: bold;
  cursor: pointer;
}
</style>
