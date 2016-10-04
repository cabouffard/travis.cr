require "./../spec_helper"

describe Travis::Repository do
  context "when finding all" do
    it "returns an array of repositories" do
      repositories = Travis::Repository.all
      (repositories.size).should eq(25)
    end
  end
end
