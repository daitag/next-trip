class Post < ApplicationRecord
	belongs_to :user
	has_many :post_images, dependent: :destroy
	accepts_attachments_for :post_images, attachment: :image
	has_many :favorites, dependent: :destroy
	has_many :good_places, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :alerts, dependent: :destroy
	has_many :post_tags,dependent: :destroy
	has_many :tags, through: :post_tags,dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true

	enum prefecture: {
    北海道:'北海道',青森県:'青森県',岩手県:'岩手県',宮城県:'宮城県',秋田県:'秋田県',山形県:'山形県',福島県:'福島県',
    茨城県:'茨城県',栃木県:'栃木県',群馬県:'群馬県',埼玉県:'埼玉県',千葉県:'千葉県',東京都:'東京都',神奈川県:'神奈川県',
    新潟県:'新潟県',富山県:'富山県',石川県:'石川県',福井県:'福井県',山梨県:'山梨県',長野県:'長野県',
    岐阜県:'岐阜県',静岡県:'静岡県',愛知県:'愛知県',三重県:'三重県',
    滋賀県:'滋賀県',京都府:'京都府',大阪府:'大阪府',兵庫県:'兵庫県',奈良県:'奈良県',和歌山県:'和歌山県',
    鳥取県:'鳥取県',島根県:'島根県',岡山県:'岡山県',広島県:'広島県',山口県:'山口県',
    徳島県:'徳島県',香川県:'香川県',愛媛県:'愛媛県',高知県:'高知県',
    福岡県:'福岡県',佐賀県:'佐賀県',長崎県:'長崎県',熊本県:'熊本県',大分県:'大分県',宮崎県:'宮崎県',鹿児島県:'鹿児島県',沖縄県:'沖縄県'
  	}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def good_placed_by?(user)
		good_places.where(user_id: user.id).exists?
	end

	def alerted_by?(user)
		alerts.where(user_id: user.id).exists?
	end

	ransacker :favorites_count do
    	query = '(SELECT COUNT(favorites.post_id) FROM favorites where favorites.post_id = posts.id GROUP BY favorites.post_id)'
    	Arel.sql(query)
  	end

  	ransacker :good_places_count do
    	query = '(SELECT COUNT(good_places.post_id) FROM good_places where good_places.post_id = posts.id GROUP BY good_places.post_id)'
    	Arel.sql(query)
  	end
end
