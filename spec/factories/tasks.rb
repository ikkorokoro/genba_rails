FactoryBot.define do
  factory :task do
    name {'テストを書く'}
    description {'rspec&capybara&factorybotを準備する'}
    user #associationが組まれ、:userで作られたUserオブジェクトが利用することができる
  end
end