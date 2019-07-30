<template>
  <div class="item-form">
    <p class="item-form__header">イメージ</p>
    <div class="item-form__content">
      <input type="file" @change="handleUploadFile">
      <div class="item-form__imgbox">
        <!-- <p class="preview-item-name">{{ imageName }}</p> -->
        <img
          v-show="imagePath"
          class="item-form__img"
          :src="imagePath"
          alt=""
        />
      </div>
      <!-- <p class="item-form__imagePath">URL：{{ imagePath }}</p> -->
    </div>
    <div class="item-form__message">
      <p>{{ message }}</p>
    </div>
    <div class="item-form__btns">
      <button 
        @click="handleUpdate(imagePath, sortrank)"
        class="item-form__btn-save"
      >
      閉じる
      </button>
      <button 
        @click="handleCansel(sortrank)"
        class="item-form__btn-cansel"
      >
      キャンセル
      </button>
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
