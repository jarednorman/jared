require "spec_helper"

RSpec.describe JarEd do
  describe ".jared" do
    subject { described_class.jared }

    it { is_expected.to eq "norman" }
  end
end
