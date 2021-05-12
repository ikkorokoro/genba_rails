class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  #独自メソッドの場合は複数形のsは不要
  validate :validate_name_not_including_conma

  private

  def validate_name_not_including_conma
    errors.add(:name, 'カンマを含めることはできません') if name&.include?(',')
  end
end
