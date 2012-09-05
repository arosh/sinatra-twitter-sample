# 概要

Ruby製のWEBアプリケーションフレームワークSinatraを用いた、「[ツイッターでログインするWebサービスの基礎 (全19回) - ドットインストール](http://dotinstall.com/lessons/tw_connect_php)」の実装です。

# 使い方

* [Twitter Developers](https://dev.twitter.com/) でアプリケーションを登録し、 consumer key/secret を取得する。登録の際、Callback URLに何らかのURLを指定していないと認証に失敗します。
* token.rb に consumer key/secret を定義する。
* app.rb の callback\_url を適切に設定する。
* `gem install bundle`
* `bundle install --path vendor/bundle`
* `bundle exec rake db:migrate`
* `bundle exec rackup`

# 注意書き

token.rb内に consumer key/secret を定義することを想定しています。

```ruby
CONSUMER_KEY = 'xxxxxxxx'
CONSUMER_SECRET = 'xxxxxxxx'
```

また、callback\_urlはローカル開発環境で開発を行うことを前提に設定されています。

