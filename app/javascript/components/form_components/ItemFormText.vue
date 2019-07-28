<template>
  <div class="item-form">
    <p class="item-form__header">本文</p>
    <div class="item-form__content">
      <textarea 
        v-model="dataBody"
        class="item-form__textarea"
        rows="5"
      >
      </textarea>
    </div>
    <div class="item-form__message">
      <p>{{ message }}</p>
    </div>
    <div class="item-form__btns">
      <button 
        @click="handleUpdate(dataBody, sortrank)"
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
    </div>
  </div>
</template>

<script>
export default {
  name: 'ItemFormText',

  props: {
    body: {
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
      dataBody: this.body,
      message: ''
    }
  },

  methods: {
    handleUpdate(body, sortrank){
      if(body.length === 0){
        this.message = '入力してください。'
        return
      }

      const newItem = {body:body}
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
</style>
