<template>
  <div class="post-detail-modal">
    <div class="wrapper">
      <div class="container">
        <div class="header">
          PreviewHeaderPreviewHeaderPreviewHeaderPreviewHeaderPreviewHeader
        </div>
        <div class="body">
          PreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreview
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PostPreviewModal',

  props: {
  },

  data() {
    return{
    }
  },

  mounted(){
  },


  computed: {
  },

  methods: {
  }
}
</script>

<style scoped>
.post-detail-modal {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}
.wrapper {
  display: table-cell;
  vertical-align: middle;
}
.container {
  width: 480px;
  min-height:800px;
  margin: 0 auto;
  padding: 8px;
  background-color: #fff;
  border-radius: 0.5em;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
}
.header {
  text-align: right;
}
.header button {
  width: 16px;
  cursor: pointer;
}
.body {
  width: 100%;
}
</style>
