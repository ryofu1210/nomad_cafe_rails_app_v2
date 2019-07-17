<template>
  <div class="item-form">
    <p class="item-form__header">イメージ</p>
    <!-- <div class="item-form__content">
      <div class="item-form__content-imgbox">
        <img class="item-form__content-img" :src="image.url">
        <p>{{dataImage.url}}</p>
      </div>
      <input 
        type="file" 
        class="item-form__file"
      >
    </div> -->
    <div class="item-form__content-imgbox">
      <label>画像</label>
      <input type="file" @change="handleUploadFile">
      <div class="preview-item">
        <p class="preview-item-name">{{ imageName }}</p>
        <img
          v-show="imagePath"
          class="item-form__content-img"
          :src="imagePath"
          alt=""
        />
        {{imagePath}}
      </div>
    </div>
    <div>
      <p>{{ message }}</p>
    </div>
    <div>
      <button 
        @click="handleUpdate(imagePath, sortrank)"
      >
      閉じる
      </button>
      <button @click="handleCansel(sortrank)">キャンセル</button>
      <!-- <p>{{dataTitle}}</p> -->
    </div>
  </div>
</template>

<script>
export default {
  name: 'ItemFormImage',

  props: {
    // item: {
    //   type:Object
    // }
    image: {
      type:String
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
    return{
      imagePath: this.image,
      imageName:'',
      message: ''
    }
  },

  methods: {
    handleUpdate(imagePath, sortrank){
      if(imagePath.length === 0){
        this.message = '画像を選択してください。'
        return
      }
      const newItem = {image:imagePath}
      this.$store.dispatch('updateItem', {newItem:newItem,sortrank:sortrank})
      this.$emit("editing-event")
      this.message = ''
      // console.log(this.$store.state.items)
    },

    handleUploadFile(e){
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
    },

    handleCansel(sortrank){
      this.$store.dispatch('deleteItem',{sortrank})
    }
  }
}
</script>

<style scoped>
.item-form__content-imgbox{
  width:100px;
  height:auto;
}

.item-form__content-img{
  width:100%;
  height: 100%;
}
</style>
