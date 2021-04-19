task_appのバックエンドアプリケーションです。
Ruby on railsを用いてフロントサイドと通信できるようになっています。

作成背景：
Reactのアウトプットをする際に、フロントエンドとバックエンドを切り出したAPIモードでの実装をしてみたく実践しました。

認証機能：
bcryptを使用し、has_secure_passwordメソッドでパスワードのハッシュ化をし、暗号した状態でpasswordを保存しています。
サーバーサイド側では、sessionでユーザーのログイン状態を保持し、ブラウザではクッキーに保存する形で実装しています。

オリジンの許容：
フロントエンドからのリクエストを許可するために、cors.rbに設定しております。
ローカル環境では、http://localhost://3000
本番環境では、http://task-app-demo.com
を許容しています。

テストツール：
Rspec

以上
