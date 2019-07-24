import client from './client';
import * as types from './mutation-types';
import ItemParameter from '../util';

const actions = {
  fetchAllItems: ({commit},{id})=>{
    return client.get(`/api/posts/${id}/edit.json`)
            .then((res) => commit(types.FETCH_ALL_ITEMS,res.data))
            .catch(err => {throw err})
  },

  fetchNewItems: ({commit})=>{
    return client.get(`/api/posts/new.json`)
            .then((res) => commit(types.FETCH_ALL_ITEMS,res.data))
            .catch(err => {throw err})
  },
  

  moveItemDown: ({commit},{sortrank, totalcount})=>{
    if (sortrank >= totalcount){
      return 
    }
    return commit(types.MOVE_ITEM_DOWN, sortrank)
  },

  moveItemUp: ({commit},{sortrank})=>{
    if (sortrank <= 0){
      return 
    }
    return commit(types.MOVE_ITEM_UP, sortrank)
  },

  deleteItem: ({commit},{sortrank})=>{
    return commit(types.DELETE_ITEM, sortrank)
  },

  addItem: ({commit},{type, totalcount})=>{
    return commit(types.ADD_ITEM, {type, totalcount})
  },

  updateItem: ({commit},{newItem, sortrank})=>{
    console.log("action")
    // console.log(value)
    // console.log(sortrank)
    return commit(types.UPDATE_ITEM, {newItem, sortrank})
  },


  // changeEditing: ({commit},{sortrank})=>{
  //   // console.log("action")
  //   // console.log(value)
  //   // console.log(sortrank)
  //   return commit(types.CHANGE_EDITING, {sortrank})
  // },


  update: ({commit},{id, post, items, selected_area, selected_tags})=>{
    const ItemParams = new ItemParameter(post, items, selected_area, selected_tags)
    const item_params = ItemParams.trim()
    return client.patch(`/api/posts/${id}.json`, {post: item_params})
            // .then((res) => commit(types.FETCH_ALL_ITEMS,res.data))
  },

  create: ({commit},{post, items, selected_area})=>{
    const ItemParams = new ItemParameter(post, items, selected_area, selected_tags)
    const item_params = ItemParams.trim()
    return client.post(`/api/posts.json`, {post: item_params})
            // .then((res) => commit(types.FETCH_ALL_ITEMS,res.data))
  },

  accepted: ({commit},{id})=>{
    const status = "accepted"
    return client.patch(`/api/posts/update_status/${id}.json`, {post: {status: status}})
            .then(() => commit(types.UPDATE_STATUS, status))
            .catch(err => {throw err})
  },

  editing: ({commit},{id})=>{
    const status = "editing"
    return client.patch(`/api/posts/update_status/${id}.json`, {post: {status: status}})
            .then(() => commit(types.UPDATE_STATUS, status))
            .catch(err => {throw err})
  },

};

export default actions; 