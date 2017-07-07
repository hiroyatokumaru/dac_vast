# キューポイントクラス
class Cuepoint < ApplicationRecord
  has_and_belongs_to_many :campaigns
  has_many :results, foreign_key: 'id', dependent: :destroy
  
  validates :name, presence: true,
                   uniqueness: true,
                   length: {in: 5..20}
end
