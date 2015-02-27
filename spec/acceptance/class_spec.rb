require 'spec_helper_acceptance'

describe 'cloudinit::script define' do



  context 'minimal parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      ::cloudinit::script{'test_script':
        content => 'test_content',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/var/lib/cloud/scripts/per-instance/test_script') do
      it { is_expected.to be_file }
    end

  end
end
