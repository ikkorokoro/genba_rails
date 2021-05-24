class Task < ApplicationRecord
  before_validation :set_nameless_name
  validates :name, presence: true, length: {maximum: 30}
  #独自メソッドの場合は複数形のsは不要
  validate :validate_name_not_including_conma
  belongs_to :user

  private

  def validate_name_not_including_conma
    errors.add(:name, 'カンマを含めることはできません') if name&.include?(',')
  end

  def set_nameless_name
    self.name = '名前なし' if name.blank?
  end
end
