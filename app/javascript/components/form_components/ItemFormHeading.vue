<template>
  <div class="item-form">
    <p class="item-form__header">見出し</p>
    <div class="item-form__content">
      <input 
        type="text" 
        v-model="dataTitle"
        class="item-form__textarea"
      >
    </div>
    <div class="item-form__message">
      <p>{{ message }}</p>
    </div>
    <div class="item-form__btns">
      <button 
        @click="handleUpdate(dataTitle, sortrank)"
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
  name: 'ItemFormHeading',

  props: {
    // item: {
    //   type:Object
    // }
    title: {
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
      dataTitle: this.title,
      message: ''
    }
  },

  methods: {
    handleUpdate(title, sortrank){
      if(title.length === 0){
        this.message = '入力してください。'
        return
      }
      // this.$store.dispatch("updateItem",title)
      console.log(title)
      const newItem = {title:title}
      this.$store.dispatch('updateItem', {newItem:newItem,sortrank:sortrank})
      this.$emit("editing-event")

      this.message = ''
    },

    handleCansel(sortrank){
      this.$store.dispatch('deleteItem',{sortrank})
    }
  }
}
</script>

<style scoped>
/* .item-form{
  border:1px solid #ddd;
  margin-bottom:30px;

}
.item-form__header{
  font-size:12px;
  background-color:#eee;
  font-weight: bold;
  padding:2px 5px;
}
.item-form__content{
  padding:15px 10px;

}
.item-form__textarea{
  width:100%;
  font-size:25px;
  background-color:#eee;
} */
</style>
