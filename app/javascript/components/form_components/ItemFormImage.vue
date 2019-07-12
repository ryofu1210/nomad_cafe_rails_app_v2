<template>
  <div class="item-form">
    <p class="item-form__header">イメージ</p>
    <div class="item-form__content">
      <div class="item-form__content-imgbox">
        <img class="item-form__content-img" :src="image.url">
        <p>{{dataImage.url}}</p>
      </div>
      <input 
        type="file" 
        class="item-form__file"
      >
    </div>
    <div>
      <button 
        @click="handleUpdate(dataImage, sortrank)"
      >
      閉じる
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
    return{
      dataImage: this.image
    }
  },

  methods: {
    handleUpdate(dataImage, sortrank){
      // this.$store.dispatch("updateItem",title)
      console.log(dataImage)
      const newItem = {image:dataImage}
      this.$store.dispatch('updateItem', {newItem:newItem,sortrank:sortrank})
      this.$emit("editing-event")
    },
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
