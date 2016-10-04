require "./../spec_helper"

describe Travis::Repository do
  context "when finding all" do
    it "returns an array of repositories" do
      repositories = Travis::Repository.all
      (repositories.size).should eq(25)
    end

    context "when param specified" do
      it "returns an array of repositories filtered by the param" do
        repositories = Travis::Repository.all("glossier")
        repository = repositories.first
        (repository.slug).should eq("glossier/demo_segment")
      end
    end
  end
end
