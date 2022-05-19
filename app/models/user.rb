class User < ApplicationRecord  
  has_many :scores, dependent: :destroy
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  # before_save { self.email = email.downcase }
  before_save :email_downcase, unless: :uid?

  validates :name, presence: true, unless: :uid?, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, unless: :uid?, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end

  #importメソッド
  def self.import(file)
    imported_num = 0
  #   #文字コード変換のためにKernel#openとCSV#newを併用
  #   #参考： http://qiita.com/labocho/items/8559576b71642b79df67
    open(file.path, 'r:cp932:utf-8', undef: :replace) do |f|
      csv = CSV.new(f, :headers => :first_row) #エラーが出る
      csv.each do |row|
        next if row.header_row?

  #       #CSVの行情報をHASHに変換
        table = Hash[[row.headers, row.fields].transpose]

  #       #登録済みデータ情報
  #       #登録されてなければ作成
        user = find_by(:id => table['id'])
        if user.nil?
          user = new
        end

  #       #データ情報更新
        user.attributes = table.to_hash.slice(
          *table.to_hash.except(:id, :created_at, :updated_at).keys)

  #       #バリデーションokの場合は保存
        if user.valid?
          user.save!
          imported_num += 1
        end
      end
    end

  #   #更新件数を返却
    imported_num
  end


  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["title", "user_id"]
  end

# # 以下　line用

# def social_profile(provider)
#   social_profiles.select { |sp| sp.provider == provider.to_s }.first
# end

# def set_values(omniauth)
#   return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
#   credentials = omniauth["credentials"]
#   info = omniauth["info"]

#   access_token = credentials["refresh_token"]
#   access_secret = credentials["secret"]
#   credentials = credentials.to_json
#   name = info["name"]
#   # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
# end

# def set_values_by_raw_info(raw_info)
#   self.raw_info = raw_info.to_json
#   self.save!
# end

# # 以上 line用

class << self
  def find_or_create_from_auth_hash(auth_hash)
    user_params = user_params_from_auth_hash(auth_hash)
    find_or_create_by(email: user_params[:email]) do |user|
      user.update(user_params)
    end
  end
  
  private

  def user_params_from_auth_hash(auth_hash)
    {
      name: auth_hash.info.name,
      email: auth_hash.info.email,
      # image: auth_hash.info.image,
    }
  end
end

def email_downcase
  self.email.downcase!
end

end
