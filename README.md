# 東京ノマドカフェ
PC作業が捗る、Wifi・コンセント・長時間居座り可のおすすめカフェをまとめたWebサービスです。転職活動用に制作しました。
<img width="1210" alt="スクリーンショット 2019-07-31 23 15 16" src="https://user-images.githubusercontent.com/40624966/62219405-3c2f5e80-b3e9-11e9-838a-cb5118fb2e39.png">


# テストユーザ
- email:test@example.com
- password：password

# リンク
http://nomad-cafe.tokyo

# 機能
- 投稿の一覧表示機能
- 投稿一覧の検索・ソート機能
- 投稿のお気に入り登録機能（ajax）
- Redisを用いた日次アクセスランキング集計機能
- Vue.jsを用いた投稿の新規・編集機能
- deviseを用いたユーザ認証機能

# 使用技術
- Ruby 2.3.3
- Ruby on Rails 5.2.3
- Vue.js 3.8.2
  - VueRouter
  - Vuex
  - axios
- Redis 3.2.12
- MySQL 5.7
- Rspec
- AWS
  - S3
  - EC2
  - VPC
  - RDS for MySQL
  - CodeDeploy
  - Route53
- CircleCI
- github
- SendGrid
- Unicorn
- Nginx

# クラウドアーキテクチャ
![Untitled Diagram (1)](https://user-images.githubusercontent.com/40624966/62220185-97ae1c00-b3ea-11e9-9f9a-a43b9354a071.png)

WebアプリケーションはEC2、RDSの1台ずつの構成です。RedisはEC2インスタンス上にRedisサーバを起動して使用しています。
CI/CDは、githubのmasterブランチへのマージをトリガーに、CircleCIからCodeDeployを呼び出し、CodeDeploy経由でEC2インスタンスへ自動デプロイを行っています。

画像ファイルはEC2上のRailsアプリケーションからS3へ保存、S3からCDN配信をしています。
メール配信には、SMTPサーバとして外部サービスであるSendGridを使用しています。

# Vue.jsを使った投稿編集機能
![投稿編集画面サンプル動画 mov](https://user-images.githubusercontent.com/40624966/62218655-d8f0fc80-b3e7-11e9-93dc-3bf56d9fb568.gif)

ユーザの新規投稿画面、編集画面にはVue.jsを用いています。

Post投稿では「見出し」「画像」「本文」という３つのアイテムを任意の個数、任意の順番で登録可能です。
データベースでは、1つの投稿を表す「Post」モデルに対して、投稿内の各要素を表す「Item」をhas_manyで関連付け、
「Item」では、見出しを表す「ItemHeading」、本文を表す「ItemText」、画像を表す「ItemImage」とポリモーフィック関連で紐づけています。

```
class Post < ApplicationRecord
    has_many :items
end

class Item < ApplicationRecord
    belongs_to :post
    belongs_to :target, polymorphic: true
end

class ItemHeading < ApplicationRecord
    has_one :item, as: :target
end

class ItemText < ApplicationRecord
    has_one :item, as: :target
end

class ItemImage < ApplicationRecord
    has_one :item, as: :target
end
```
<img width="1158" alt="スクリーンショット 2019-07-31 23 57 02" src="https://user-images.githubusercontent.com/40624966/62222826-f5446780-b3ee-11e9-88be-2a72d440d3ad.png">

# テスト
- RSpec
- 統合テスト(system spec)
- 機能テスト(request spec)
- 単体テスト(モデル)

テストに関しましてはテストが書けることをアピールする為、全ての機能はテストしていません。

