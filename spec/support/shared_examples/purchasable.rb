RSpec.shared_examples "purchasable" do
  let(:model) { described_class.new }

  describe "validations" do
    subject { build(described_class.to_s.underscore.to_sym) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  end

  describe '#price=' do
    it 'converts the price to a BigDecimal' do
      model.price = '19.99'
      expect(model.price).to eq(BigDecimal('19.99'))
    end

    it 'handles integer values correctly' do
      model.price = '20'
      expect(model.price).to eq(BigDecimal('20'))
    end

    it 'handles float values correctly' do
      model.price = '20.50'
      expect(model.price).to eq(BigDecimal('20.50'))
    end

    it 'handles invalid values gracefully' do
      model.price = 'abcd'
      expect(model.price).to be_nil
      expect(model).to be_invalid
    end
  end
end
