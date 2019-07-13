<template>
  <div class="post-view">
    <!-- {{message}} -->
    <!-- <p class="post_params">{{datapostparams}}</p> -->
    <div>
      <label>Name</label>
      <input type="text" v-model="post.name" >
    </div>
    <div>
      <label>Description</label>
      <textarea v-model="post.description" ></textarea>
    </div>
    <div class="header-image__box">
      <label>画像</label>
      <input type="file" @change="handleUploadFile">
      <div class="preview-item">
        <!-- <p class="preview-item-name">{{ imageName }}</p> -->
        <img
          class="preview-item-file"
          :src="post.image"
          alt=""
        />
      </div>
    </div>



    <!-- <input type="text" v-model="post.name" > -->
    <!-- <img :src="post_params.image" > -->
    <!-- <div class="container-header">
      <PostEditHeader :post="post" />
    </div> -->
    <div class="container-items">
      <ItemComponentList :items="items" />
    </div>
    <div class="container-submit__box">
      <button 
        class="container-submit__button"
        @click="handleSubmit(post, items)"
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

  data(){
    return {
      message: "",
      progress: false,
      // datapostparams: this.$store.state.post
      // datapostparams: this.post_params
      post: {},
      items: [],
    }
  },

  created(){
    this.LoadItems()
  },

  computed: {
    // items (){
    //   return this.$store.state.items
    // },

    // post_params (){
    //   return this.$store.state.post
    // }
  },

  methods: {
    // setPostParams(){
    //   this.datapostparams = this.post_params
    // },

    setProgress(message){
      this.progress = true
      this.message = message
    },

    resetProgress(){
      this.progress = false
      this.message = ""
    },

    LoadItems(){
      this.setProgress("読み込み中...")
      const id = this.$route.params.id
      this.$store.dispatch('fetchAllItems',{id})
        .catch(err => {
          Promise.reject(err)
        })
        .then(()=>{
          this.post = this.$store.state.post
          this.items = this.$store.state.items
          this.resetProgress()
        })
        // this.setPostParams()
    },

    handleSubmit(post, items){
      const id = this.$route.params.id
      this.$store.dispatch('update', {id, post, items})
    },



    handleUpdate(imagePath, sortrank){
      const newItem = {image:imagePath}
      this.$store.dispatch('updateItem', {newItem:newItem,sortrank:sortrank})
      // this.$emit("editing-event")
      // console.log(this.$store.state.items)
    },

    handleUploadFile(e){
      console.log(this.post.name)
      // console.log(e)
      const files = e.target.files || e.dataTransfer.files;
      this.createImage(files[0])
      // this.imageName = files[0].name
    },

    createImage(file){
      const reader = new FileReader();
      reader.onload = e => {
        // console.log(e)
        // this.imagePath = e.target.result;
        this.post.image = e.target.result;
      };
      reader.readAsDataURL(file)
      // console.log(this.imagePath)
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

.preview-item{
  width:400px;
  height:100%;
}
.preview-item-file{
  width:100%;
  height:100%;
}

</style>
