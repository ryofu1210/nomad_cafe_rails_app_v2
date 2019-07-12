import _ from 'lodash';

export default class IteemParameter{
  constructor(post, items){
    this.post = post;
    this.items = items;
    this.result = null;
  }

  trim(){
    console.log("ItemParameter")
    console.log(this.post)
    console.log(this.items)
    this.result = {
      name: this.post.name,
      description: this.post.description,
      image: this.post.image,
      status: this.post.status,
      items_attributes: 
        this.items.map(item => this.trimItem(item))
    }
    return this.result
  }

  trimItem(item){
    const commonParams = {
      id: item.id,
      post_id: item.post_id,
      sortrank: item.sortrank,
      target_type: item.target_type,
      target_id: item.target_id,
    }
    let newParams; 

    switch(item.target_type){
      case "ItemHeading":
        newParams = {
          title: item.title
        }
        break;
      case "ItemText":
        newParams = {
          body: item.body
        }
        break;
      case "ItemImage":
        newParams = {
          image: item.image
        }
        break;
    }
    return _.merge(commonParams, newParams)
  }
}