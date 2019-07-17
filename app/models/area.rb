class Area < ActiveHash::Base
  include ActiveHash::Associations
  has_many :posts

  self.data = [
      {id: 1, name: '渋谷'}, 
      {id: 2, name: '明大前'}, 
      {id: 3, name: '六本木'},
      {id: 4, name: '代官山'},
      {id: 5, name: '下北沢'}
  ]
end