<template>
  <div>
    {{ post.image }}
    <div>
      <label>Name</label>
      <input type="text" v-model="dataname" >
    </div>
    <div>
      <label>Description</label>
      <textarea v-model="datadesc" ></textarea>
    </div>
    <div class="header-image__box">
      <label>画像</label>
      <input type="file" @change="handleUploadFile">
      <div class="preview-item">
        <p class="preview-item-name">{{ imageName }}</p>
        <img
          class="preview-item-file"
          :src="imagePath"
          alt=""
        />
      </div>
    </div>
  </div>
</template>

<script>
// import PostEditHeder from './PostEditHeader';
// import { setTimeout } from 'timers';

export default {
  name: 'PostFormHeader',

  props: {
    post: {
      type: Object,
      required:true
    }
  },

  data() {
    return{
      dataname: "",
      imagePath: this.post.image,
      imageName: '',
      datadesc: "",
    }
  },

  mounted(){
    // this.loadImage(this.post.name)
    this.$nextTick(()=>{
      this.dataname = this.post.name
    })
  },


  computed: {
    // returnImage(){
    //   this.imagePath = this.post.image
    //   this.dataname = this.post.name
    //   this.datadesc = this.post.description
    //   return this.imagePath
    // }
  },

  methods: {
    // loadImage(name){
    //   console.log(name)
    //   this.dataName = "aaaaaaaa"
    //   this.imagePath = this.post.image
    //   this.post.image = this.post.image
    // },

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
      this.imageName = files[0].name
    },

    createImage(file){
      const reader = new FileReader();
      reader.onload = e => {
        // console.log(e)
        this.imagePath = e.target.result;
      };
      reader.readAsDataURL(file)
      // console.log(this.imagePath)
    }
  }
}
</script>

<style scoped>
.header-image__box{
  width:400px;
  height:auto;
}
.preview-item-file{
  width:100%;
  height:100%;
}

</style>
