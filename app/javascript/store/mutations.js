import * as types from './mutation-types';

export default {
  [types.FETCH_ALL_ITEMS] (state, payload){
    state.items = payload
  },
 
  [types.ADD_ITEM] (state, payload) {
  },

  [types.MOVE_ITEM_DOWN] (state, payload){
    const sortrank = payload
    // console.log(sortrank)

    const item = state.items.splice(sortrank, 1)[0]
    state.items.splice(sortrank + 1, 0, item)
  },

  [types.MOVE_ITEM_UP] (state, payload){
    const sortrank = payload
    // console.log(sortrank)

    const item = state.items.splice(sortrank, 1)[0]
    state.items.splice(sortrank - 1, 0, item)
  },

  [types.DELETE_ITEM] (state, payload){
    const sortrank = payload
    state.items.splice(sortrank, 1)
  }


}