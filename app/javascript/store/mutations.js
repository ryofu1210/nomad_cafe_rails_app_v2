import * as types from './mutation-types';
import _ from 'lodash';

export default {
  [types.FETCH_ALL_ITEMS] (state, payload){
    const items = payload.items.map(item => {
      return _.merge( item , { isNew:false, editing:false } )
    })
    state.items = items
    state.post = payload.post
    state.areas = payload.areas
    state.tags = payload.tags
    // state.status = payload.post.status
  },
  

  [types.ADD_ITEM] (state, payload) {
    const {type, totalcount} = payload
    const commonParams = {
      post_id: state.post.id,
      sortrank: totalcount,
      isNew: true,
      editing: true
    }
    let targetParams;
    switch(type){
      case "heading":
        targetParams = {target_type:"ItemHeading", title: ""}
        break
      case "text":
        targetParams = {target_type:"ItemText", body: ""}
        break
      case "image":
          targetParams = {target_type:"ItemImage", image: ""}
          break
    
    }
    const item = _.merge(commonParams,targetParams)
    state.items.splice(totalcount,0,item)
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
  },

  [types.UPDATE_ITEM] (state, payload){
    const {newItem, sortrank} = payload
    console.log(state.items[sortrank])
    state.items[sortrank] = _.merge(state.items[sortrank], newItem)
  },

  [types.UPDATE_STATUS] (state, payload){
    const status = payload
    state.post = _.merge( state.post , { status: status } )
  },


}