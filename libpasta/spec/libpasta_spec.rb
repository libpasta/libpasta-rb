require "spec_helper"

RSpec.describe Libpasta do
  it "has a version number" do
    expect(Libpasta::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(Pasta::hash_password "hello123").not_to be nil
  end
end
