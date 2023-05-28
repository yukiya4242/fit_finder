# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password',
                  password_confirmation: 'password') if Rails.env.development?

AdminUser.create!(email: 'admin@example.com', password: 'password',
                  password_confirmation: 'password') if Rails.env.production?

users = User.create!(
  [
    {email: 'yamada.taro@test.com', username: '山田太郎', password: 'password', location: "東京都渋谷区", introduction: "こんにちは、山田太郎です。東京で働いています。最近、健康のためにトレーニングを始めました。よろしくお願いします。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image1.png"), filename:"test_image1.png")},
    {email: 'suzuki.hanako@test.com', username: '鈴木花子', password: 'password', location: "北海道札幌市中央区", introduction: "鈴木花子と申します。北海道で暮らしており、ヨガとピラティスが大好きです。一緒に健康的なライフスタイルを追求しましょう！", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image2.png"), filename:"test_image2.png")},
    {email: 'sato.ichiro@test.com', username: '佐藤一郎', password: 'password', location: "福岡県福岡市中央区", introduction: "福岡の佐藤一郎です。毎日のランニングが私の生活の一部になっています。新しいランニングコースの探索が趣味です。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image3.png"), filename:"test_image3.png")},
    {email: 'takahashi.mariko@test.com', username: '高橋真理子', password: 'password', location: "愛知県名古屋市中区", introduction: "名古屋在住の高橋真理子です。週末は必ずハイキングに出かけます。自然と共に身体を動かすことが好きです。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image4.png"), filename:"test_image4.png")},
    {email: 'tanaka.kenichi@test.com', username: '田中健一', password: 'password', location: "青森県青森市中区", introduction: "田中健一と申します。青森で暮らしています。スキーシーズンが待ち遠しい！トレーニングは冬に備えて、夏から始めます。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image5.png"), filename:"test_image5.png")},
    {email: 'watanabe.harumi@test.com', username: '渡辺晴美', password: 'password', location: "京都府京都市左京区", introduction: "京都の渡辺春美です。最近、ダンスエクササイズにハマっています。楽しく身体を動かすことが一番だと思っています。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image6.png"), filename:"test_image6.png")},
    {email: 'ito.chika@test.com', username: '伊藤千晴', password: 'password', location: "神奈川県横浜市青葉区", introduction: "横浜で暮らす伊藤千夏です。毎週、地元のジムに通って筋トレをしています。よろしくお願いします。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image7.png"), filename:"test_image7.png")},
    {email: 'kobayashi.ryuji@test.com', username: '小林龍二', password: 'password', location: "沖縄県那覇市赤嶺", introduction: "沖縄の小林龍二です。海が近いので、週末はSUPやカヤックでトレーニングしています。海と共に活動する仲間を求めています", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image8.png"), filename:"test_image8.png")},
    {email: 'nakamura.asuka@test.com', username: '中村明日香', password: 'password', location: "京都府京都市右京区", introduction: "京都の中村明日香です。自分自身の身体と心のバランスを保つために、ヨガを日常に取り入れています。一緒にヨガを楽しみましょう！", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image9.png"), filename:"test_image9.png")},
    {email: 'murayama.daiki@test.com', username: '村山大輝', password: 'password', location: "宮城県仙台市青葉区", introduction: "仙台在住の村山大輝です。筋トレが趣味で、特にアームレスリングが得意です。共に成長できるトレーニングパートナーを探しています。", profile_picture: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test_image10.png"), filename:"test_image10.png")}
    
    ]
  )