require "spec_helper"
require "helpers/bigdecimal_extras"

describe BigDecimal do
  describe "#round_up_to_nearest" do
    let(:n) { 5 }
    subject { described_class }

    context "5" do
      context "when 0 or 5" do
        it "should remain the same" do
          %w(0 5).each do |figure|
            expect(subject.new(figure).round_up_to_nearest(n)).to eq(BigDecimal(figure))
          end
        end
      end

      context "when 1, 2, 3 or 4" do
        it "should be rounded up to 5" do
          %w(1 2 3 4).each do |figure|
            expect(subject.new(figure).round_up_to_nearest(n)).to eq(BigDecimal("5"))
          end
        end
      end

      context "when 6, 7, 8 or 9" do
        it "should be rounded up to 10" do
          %w(6 7 8 9).each do |figure|
            expect(subject.new(figure).round_up_to_nearest(n)).to eq(BigDecimal("10"))
          end
        end
      end
    end
  end
end
