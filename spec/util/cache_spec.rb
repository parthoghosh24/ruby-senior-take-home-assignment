require 'spec_helper'
require 'vandelay/util/cache'

RSpec.describe Vandelay::Util::Cache do
  describe "Cache" do
    context  "when not expired" do
        before do
            Vandelay::Util::Cache.instance.write('foo', 'bar', 5)
        end

        it "returns correct value" do
            expect(Vandelay::Util::Cache.instance.read('foo')).to eq('bar')
        end
    end

    context  "when expired" do
        before do
            Vandelay::Util::Cache.instance.write('foo', 'bar', 1)
            sleep 2
        end

        it "returns nil" do
            expect(Vandelay::Util::Cache.instance.read('foo')).to eq(nil)
        end
    end
  end
end
