# 東京ノマドカフェ
PC作業が捗る、Wifi・コンセント・長時間居座り可のおすすめカフェをまとめたWebサービスです。転職活動用に制作しました。

# テストユーザ
- email:test@example.com
- password：password

# リンク
http://nomad-cafe.tokyo

# 使用技術
- Ruby 2.3.3
- Rails(5.2)
- Vue.js 3.8.2
  - VueRouter
  - Vuex
  - axios
- Redis
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
![Untitled Diagram](https://user-images.githubusercontent.com/40624966/62217259-4b141200-b3e5-11e9-82fc-21d2f422125e.png)
WebアプリケーションはEC2、RDSの1台ずつの構成です。RedisはEC2インスタンス上にRedisサーバを起動して使用しています。
CI/CDは、githubのmasterブランチへのマージをトリガーに、CircleCIからCodeDeployを呼び出し、CodeDeploy経由でEC2インスタンスへ自動デプロイを行っています。

画像ファイルはEC2上のRailsアプリケーションからS3へ保存、S3からCDN配信をしています。

# Vue.jsを使った投稿編集機能
![投稿編集画面サンプル動画 mov](https://user-images.githubusercontent.com/40624966/62218655-d8f0fc80-b3e7-11e9-93dc-3bf56d9fb568.gif)

# テスト
- RSpec
- 統合テスト(system spec)
- 機能テスト(request spec)
- 単体テスト(モデル等)
テストに関しましてはテストが書けることをアピールする為、全ての機能はテストしていません。

