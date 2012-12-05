require 'spec_helper'

describe 'wu-deploy' do

  before {`rm -rf #{examples_dir('*')}` }
  after  {`rm -rf #{examples_dir('*')}` }

  context "creating a deploy pack" do
    
    subject { command('wu-deploy', 'new', examples_dir("deploy_pack")) }
    it { should exit_with(0) }
    it "prints the files its creating" do
      should have_stdout(/create.*config/, /create.*Gemfile/, /create.*\.gitignore/)
    end
    it "creates files on disk" do
      subject.run!
      Dir[examples_dir('deploy_pack', '*')].should_not be_empty
    end
    
    context "with the --dry_run flag" do
      subject { command('wu-deploy', 'new', examples_dir("deploy_pack"), '--dry_run') }
      it { should exit_with(0) }
      it "prints the files its creating" do
        should have_stdout(/create.*config/, /create.*Gemfile/, /create.*\.gitignore/)
      end
      it "doesn't create files on disk" do
        subject.run!
        Dir[examples_dir('deploy_pack', '*')].should be_empty
      end
    end

    context "on top of an existing deploy pack" do
      before {command('wu-deploy', 'new', examples_dir("deploy_pack")).run! }
      it { should exit_with(0) }
      it "prints the files its creating and which ones are the same" do
        should have_stdout(/create.*config/, /same.*Gemfile/, /same.*\.gitignore/)
      end
      context "with conflicts" do
        before do
          File.open(examples_dir("deploy_pack", "Gemfile"), 'w') { |f| f.puts "new content" }
        end
        context "that are skipped" do
          subject { command('wu-deploy', 'new', examples_dir("deploy_pack")) < "n" }
          it { should exit_with(0) }
          it "prints the files it skipped" do
            should have_stdout(/create.*config/, /skip.*Gemfile/, /same.*\.gitignore/)
          end
        end
        context "that are replaced" do
          subject { command('wu-deploy', 'new', examples_dir("deploy_pack")) < "y" }
          it { should exit_with(0) }
          it "prints the files it replaced" do
            should have_stdout(/create.*config/, /replace.*Gemfile/, /same.*\.gitignore/)
          end
        end
      end
    end
  end
end

