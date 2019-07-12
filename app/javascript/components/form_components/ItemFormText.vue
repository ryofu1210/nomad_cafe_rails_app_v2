<template>
  <div class="item-form">
    <p class="item-form__header">本文</p>
    <div class="item-form__content">
      <textarea 
        v-model="dataBody"
        class="item-form__textarea"
      >
      </textarea>
    </div>
    <div>
      <button @click="handleUpdate(dataBody, sortrank)">閉じる</button>
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
      dataBody: this.body
    }
  },

  methods: {
    handleUpdate(body, sortrank){
      const newItem = {body:body}
      this.$store.dispatch('updateItem', {newItem:newItem,sortrank:sortrank})
      this.$emit("editing-event")
    },
  }


}
</script>

<style scoped>
</style>
