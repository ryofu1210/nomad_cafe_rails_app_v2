import client from './client';
import * as types from './mutation-types';
import ItemParameter from '../util';

const actions = {
  fetchAllItems: ({commit},{id})=>{
    // console.log(id)
    return client.get(`/api/posts/${id}.json`)
            .then((res) => commit(types.FETCH_ALL_ITEMS,res.data))
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


  update: ({commit},{id, post_params, items})=>{
    // console.log(id)
    // console.log("action")
    // console.log(post_params)
    const ItemParams = new ItemParameter(post_params, items)
    const item_params = ItemParams.trim()
    // console.log("item_params")
    // console.log(item_params)
    return client.patch(`/api/posts/${id}.json`, {post: item_params})
            // .then((res) => commit(types.FETCH_ALL_ITEMS,res.data))
  },


};

export default actions; 