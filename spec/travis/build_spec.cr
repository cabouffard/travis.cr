require "./../spec_helper"

describe Travis::Build do
  context "when finding" do
    it "returns a build object" do
      build = Travis::Build.find(163790355)
      (build.class).should eq(Travis::Build)
    end
  end
end
