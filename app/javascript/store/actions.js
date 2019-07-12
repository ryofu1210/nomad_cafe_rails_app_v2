import client from './client';
import * as types from './mutation-types';

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
  }


};

export default actions; 