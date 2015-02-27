require 'spec_helper'

common_facts = {
  concat_basedir: '/tmp',
  memorysize: '2 GB',
  processorcount: '2',
}

supported_os = [
  {
    kernel: 'Linux',
    osfamily: 'RedHat',
    operatingsystem: 'redhat',
    operatingsystemrelease: '7.0',
  }
]

#unsupported_os = [
#  {
#    kernel: 'Solaris',
#    osfamily: 'Solaris',
#    operatingsystem: 'Nexenta',
#  }
#]

valid_script_types = [
  'per-boot',
  'per-instance',
  'per-once',
]

describe '::cloudinit::script', :type => :define do
  let :default_resource_title do 'rspec_test_script' end
  let :default_script_base do '/var/lib/cloud/scripts' end
  let :default_script_type do 'per-instance' end
  let :default_params do
    {
      :content => 'test_content'
    }
  end
  supported_os.each do |os|
    let :facts do os.merge(common_facts) end
    let :title do default_resource_title end
    describe "::cloudinit::script define with no parameters on #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
      let :params do {} end
      it {
        expect {
          should contain_cloudinit__script(default_resource_title)
        }.to raise_error(Puppet::Error, /^Must specify exactly one of/)
      }
    end
    describe "::cloudinit::script define with source and content #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
      let :params do
        {
          :content => 'test_content',
          :source  => 'puppet:///test/source',
        }
      end
      it {
        expect {
          should contain_cloudinit__script(default_resource_title)
        }.to raise_error(Puppet::Error, /^Must specify exactly one of/)
      }
    end
    describe "::cloudinit::script define with minimal parameters on #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
      let :params do default_params end

      it { should compile.with_all_deps }
      it { should contain_cloudinit__script(default_resource_title) }
      it { should contain_file(File.join(default_script_base, default_script_type, title)) }

    end
    valid_script_types.each do |script_type|
      describe "::cloudinit::script define with script-type: #{script_type} on #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
        let :params do default_params.merge({ :script_type => script_type }) end
        it { should compile.with_all_deps }
        it { should contain_file(File.join(default_script_base, script_type, title)) }
      end
    end
    [ 'bad-script-type' ].each do |script_type|
      describe "::cloudinit::script define with script_type: #{script_type} on #{os[:operatingsystem]} #{os[:operatingsystemrelease]}" do
        let :params do default_params.merge({ :script_type => script_type }) end
        it {
          expect {
            should contain_cloudinit__script(default_resource_title)
          }.to raise_error(Puppet::Error, /^validate_re\(\): "bad-script-type" does not match/)
        }
      end
    end
  end
end
