# memoapp

localhostで動作する最低限の機能しかないメモアプリです。

'SinatraでシンプルなWebアプリを作ろう'の課題提出物です。

## 必要条件(Requirements)

Ruby 3.0.0+

## 使い方(Usage)

### セットアップ方法

```zsh
% git clone -b <branch> https://github.com/futa4095/memoapp.git
% cd memoapp
% bundle install
```

例えばdevmemoブランチからcloneする場合は`git clone -b devmemo https://github.com/futa4095/memoapp.git`にします。

mainブランチからcloneする場合は、ブランチの指定を省略可能です。

### サーバーの起動

```zsh
% bundle exec ruby app.rb
```

ブラウザで <http://localhost:4567> にアクセスするとメモアプリを使用できます。

起動したターミナルから、Ctrl-Cでサーバーを停止します。

## ライセンス(License)

This software is released under the MIT License.
