### 動作環境

- 検証環境として docker環境を用意しています。
- 下記コマンドを実行すると3000番ポートでRailsサーバーが起動します。
```
$ docker-compose build
$ docker-compose up
```

### バージョン
Ruby及びRuby on Railsのバージョンは下記の通りです。
```
Ruby: 3.0.2
Rails: 6.1.4.1
sqlite3: 1.4.2
```

### セットアップ情報
下記コマンドを実行するとマスターデータを投入します。

```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ bundle exec rails db:seed
```
