<template>
  <div>
    <h1>ItemFormHeading</h1>
    <!-- <form> -->
      <input type="text" v-model="title">
      <button @click="handleUpdate(title)">閉じる</button>
      <p>{{title}}</p>
    <!-- </form> -->
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
    }
  },

  // data (){
  //   return {
  //     title: ''
  //   }
  // },

  methods: {
    handleUpdate(title){
      // this.$store.dispatch("updateItem",title)
      this.$emit("editing-event")
    }
  }
}
</script>

<style scoped>
</style>
