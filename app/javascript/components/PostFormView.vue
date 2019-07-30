<template>
  <div>
    <div class="vue-flash" v-if="notice_mode || alert_mode">
      <div class="vue-flash-message vue-flash-message__notice" v-if="notice_mode">
        {{notice_message}}
      </div>
      <div class="vue-flash-message vue-flash-message__alert" v-if="alert_mode">
        {{alert_message}}
      </div>
    </div>
    <div class="form-header">
      <div class="row form-group">
        <label 
          class="col-form-label col-2"
          for="post_name"
        >
        店舗名
        </label>
        <input 
          type="text" 
          v-model="post.name" 
          class="form-control col-7" 
          maxlength="50"
          id="post_name"
        >
        <p v-if="name_message" >{{name_message}}</p>
      </div>
      <div class="row form-group">
        <label 
          class="col-form-label col-2"
          for="post_description"
        >
        説明文
        </label>
        <textarea 
          v-model="post.description" 
          class="form-control col-7"
          rows="3"
          maxlength="150"
          id="post_description"
        ></textarea>
        <p v-if="description_message" >{{description_message}}</p>
      </div>
      <div class="header-image__box row form-group">
        <label class="col-form-label col-2">画像</label>
        <div class="col-7">
          <input type="file" @change="handleUploadFile" class="fomr-control-file">
          <div class="preview-img__box mt-2">
            <img
              class="preview-img__file"
              :src="post.image"
              alt=""
              id="post_image"
            />
          </div>
        </div>
      </div>
      <div class="row form-group">
        <label class="col-form-label col-2">エリア選択</label>
        <select v-model="selected_area" options="areas" >
          <option 
            v-for="area in areas" 
            :value="area.id" 
            :key="area.id"
            :id="`post_area_ids_${area.id}`"
          >
          {{area.name}}
          </option>
        </select>
        <p v-if="area_message" > {{ area_message }}</p>
      </div>      
      <ul class="row form-group">
        <label 
          class="col-form-label col-2" 
          for="post[tags]"
        >
        タグ選択
        </label>
        <!-- <li class="mr-3"> -->
          <label 
            v-for="tag in tags" 
            :key="tag.id" 
            class="form-check-label mr-5"
            :for="`post_tag_ids_${tag.id}`"
          >
            <input 
              type="checkbox" 
              v-model="selected_tags" 
              :value="tag.id"
              class="form-check-input"
              :id="`post_tag_ids_${tag.id}`"
              name="post[tags]"
            >
            {{tag.name}}
          </label>
        <!-- </li> -->
      </ul>

    </div>

    <div 
      class="container-items"
      v-if="this.$route.params.id"
    >
      <ItemComponentList :items="items" />
    </div>
    <div class="container-submit">
      <button 
        v-if="post.status == 'accepted'"
        class="container-submit__button"
        @click="handlePublish(post)"
      >
      非公開にする
      </button>

      <button 
        v-else-if="post.status == 'editing'"
        class="container-submit__button"
        @click="handlePublish(post)"
      >
      公開にする
      </button>

      <button 
        class="container-submit__button"
        @click="handleSubmit(post, items, selected_area, selected_tags)"
      >
      保存
      </button>
      <!-- <router-link :to="{ name: 'PostPreviewModal'}">
        <h3>プレビュー</h3>
      </router-link> -->
    </div>
  <router-view />
  </div>
</template>

<script>
import ItemComponentList from './ItemComponentList';
import { setTimeout } from 'timers';

export default {
  name: 'PostFormView',

  components: {
    ItemComponentList,
  },

  data(){
    return {
      // message: "",
      progress: false,
      post: {},
      items: [],
      name_message: '',
      description_message: '',
      areas: [],
      selected_area: '',
      area_message: '',
      tags: [],
      selected_tags: [],
      notice_message: '',
      notice_mode: false,
      alert_message: '',
      alert_mode: false,

    }
  },

  created(){
    this.LoadItems()
  },

  watch:{
    'post':{
      handler:()=>{
        // console.log("statusの値が変わりました。")
      },
      deep: true
    }
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

    setFlashMessage(message, mode){
      if(mode === "notice"){
        this.notice_message = message
        this.notice_mode = true
        setTimeout(()=>{
          this.notice_mode = false
        },2000)
      }else if(mode === "alert"){
        this.alert_message = message
        this.alert_mode = true
        setTimeout(()=>{
          this.alert_mode = false
        },2000)
      }
    },

    LoadItems(){
      this.setProgress("読み込み中...")
      const id = this.$route.params.id
      // console.log(id)
      if(id){
        this.$store.dispatch('fetchAllItems',{id})
          .catch(err => {
            Promise.reject(err)
          })
          .then(()=>{
            this.post = this.$store.state.post
            // this.status = this.$store.state.post.status
            this.items = this.$store.state.items
            this.areas = this.$store.state.areas
            this.selected_area = this.$store.state.post.area_id
            this.tags = this.$store.state.tags
            this.selected_tags = this.$store.state.post.tag_ids
            this.resetProgress()
          })
          // this.setPostParams()
      }else{
        this.$store.dispatch('fetchNewItems')
          .catch(err => {
            Promise.reject(err)
          })
          .then(()=>{
            this.post = this.$store.state.post
            // this.status = this.$store.state.post.status
            this.items = this.$store.state.items
            this.areas = this.$store.state.areas
            this.tags = this.$store.state.tags
            this.resetProgress()
          })
      }
    },

    handleSubmit(post, items, selected_area, selected_tags){
      if(!this.canSave()){return;}
      const id = this.$route.params.id
      if(id){
        this.$store.dispatch('update', {id, post, items, selected_area, selected_tags})
          .then(()=>{
            this.setFlashMessage("保存に成功しました。","notice")
          })
          .catch(()=>{
            this.setFlashMessage("保存に失敗しました。","alert")
          })
      }else{
        this.$store.dispatch('create', {post, items, selected_area, selected_tags})
          .then(()=>{
            this.setFlashMessage("保存に成功しました。","notice")
          })
          .catch(()=>{
            this.setFlashMessage("保存に失敗しました。","alert")
          })
        }
    },

    handlePublish(post){
      const id = this.$route.params.id

      if(post.status == "editing"){
        this.$store.dispatch('accepted',{id})
          .then(()=>{
            this.setFlashMessage("公開状況を公開に変更しました。","notice")
          })
          .catch(()=>{
            this.setFlashMessage("公開状況の更新に失敗しました。","alert")
          })
      }else if(post.status == "accepted"){
        this.$store.dispatch('editing',{id})
          .then(()=>{
            this.setFlashMessage("公開状況を下書きに変更しました。","notice")
          })
          .catch(()=>{
            this.setFlashMessage("公開状況の更新に失敗しました。","alert")
          })
      }
    },

    canSave(){
      let error_count = 0
      if(this.post.name.length == 0){
        this.name_message = '店名は必ず入力してください。'
        error_count += 1
      }
      if(this.post.description.length == 0){
        this.description_message = '説明文は必ず入力してください。'
        error_count += 1
      }
      if(this.selected_area.length == 0){
        this.area_message = 'エリアは必ず入力してください。'
        error_count += 1
      }

      if(error_count > 0){
        return false
      }
      this.name_message = ''
      this.description_message = ''
      return true
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
</style>
