# タスク管理アプリ "自律"

RubyとCGIを用いて習慣づけのためのタスク管理アプリを作りました。
習慣づけを促すツールや勉強の復習のリズム管理のツールとして使えます。  
主な機能は以下。  
- 登録したタスクが決められた周期で出てくる。
- 一通り習慣づけられるくらいまでこなすと経験値が貯まる。(経験値の使いみちは。。。)
- 周期は現在、毎日、毎週、毎月、エビングハウスの忘却曲線に沿った周期(勉強の復習用、1日後、3日後、1週間後、、、に復讐すると効率がよいっていうアレ)
- session管理によるログインを用いているので、もちろんユーザごとに切り分けられている。

### 使った技術、知識
- Ruby
- CGI
- SQLite3(DB設計も第３正規化まで行っている)
- Cookie、session管理
- 他、ヒアドキュメントを用いているのでJavaScript, HTMLなど
- インジェクション対策(正規表現などを使ったバリデーションやエスケープ処理など)
- begin rescueなどのエラー処理  

### 設計書  
セキュリティ関連の事とか、MVCモデルで設計したらもっとすっきりするのでRailsを使ったらよかった。  
![wp20191212-5](https://user-images.githubusercontent.com/39507181/71557275-5e580600-2a87-11ea-9465-f1797e75c042.jpg)

### イメージ
ヒアドキュメントでCSSやるとごちゃるからCSSによる装飾はしてない。  
![Screenshot from 2019-12-29 22-07-19](https://user-images.githubusercontent.com/39507181/71557293-9a8b6680-2a87-11ea-89c4-46a1ef4c050c.png)