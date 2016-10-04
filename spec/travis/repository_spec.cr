require "./../spec_helper"

describe Travis::Repository do
  context "when finding all" do
    it "returns an array of repositories" do
      repositories = Travis::Repository.find_all
      (repositories.size).should eq(25)
    end

    context "with a key specified" do
      it "returns an array of repositories corresponding to the key" do
        repositories = Travis::Repository.find_all("glossier")
        repository = repositories.first
        (repository.slug).should eq("glossier/demo_segment")
      end
    end
  end
end
