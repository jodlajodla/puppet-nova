require 'spec_helper'

describe 'nova::ironic::common' do

  shared_examples_for 'nova-ironic-common' do

    context 'with default parameters' do
      it 'configures ironic in nova.conf' do
        is_expected.to contain_nova_config('ironic/auth_plugin').with_value('password')
        is_expected.to contain_nova_config('ironic/username').with_value('admin')
        is_expected.to contain_nova_config('ironic/password').with_value('ironic')
        is_expected.to contain_nova_config('ironic/auth_url').with_value('http://127.0.0.1:35357/')
        is_expected.to contain_nova_config('ironic/project_name').with_value('services')
        is_expected.to contain_nova_config('ironic/api_endpoint').with_value('http://127.0.0.1:6385/v1')
        is_expected.to contain_nova_config('ironic/api_max_retries').with('value' => '<SERVICE DEFAULT>')
        is_expected.to contain_nova_config('ironic/api_retry_interval').with('value' => '<SERVICE DEFAULT>')

        is_expected.to contain_nova_config('ironic/admin_username').with_value('admin')
        is_expected.to contain_nova_config('ironic/admin_password').with_value('ironic')
        is_expected.to contain_nova_config('ironic/admin_url').with_value('http://127.0.0.1:35357/')
        is_expected.to contain_nova_config('ironic/admin_tenant_name').with_value('services')
      end
    end

    context 'with parameters' do
      let :params do
        {
          :username           => 'ironic',
          :password           => 's3cr3t',
          :auth_url           => 'http://10.0.0.10:35357/',
          :project_name       => 'services2',
          :api_endpoint       => 'http://10.0.0.10:6385/v1',
          :api_max_retries    => 60,
          :api_retry_interval => 2,
        }
      end

      it 'configures ironic in nova.conf' do
        is_expected.to contain_nova_config('ironic/auth_plugin').with_value('password')
        is_expected.to contain_nova_config('ironic/username').with_value('ironic')
        is_expected.to contain_nova_config('ironic/password').with_value('s3cr3t')
        is_expected.to contain_nova_config('ironic/auth_url').with_value('http://10.0.0.10:35357/')
        is_expected.to contain_nova_config('ironic/project_name').with_value('services2')
        is_expected.to contain_nova_config('ironic/api_endpoint').with_value('http://10.0.0.10:6385/v1')
        is_expected.to contain_nova_config('ironic/api_max_retries').with('value' => '60')
        is_expected.to contain_nova_config('ironic/api_retry_interval').with('value' => '2')

        is_expected.to contain_nova_config('ironic/admin_username').with_value('ironic')
        is_expected.to contain_nova_config('ironic/admin_password').with_value('s3cr3t')
        is_expected.to contain_nova_config('ironic/admin_url').with_value('http://10.0.0.10:35357/')
        is_expected.to contain_nova_config('ironic/admin_tenant_name').with_value('services2')
      end
    end

    context 'with deprecated parameters' do
      let :params do
        {
          :admin_username    => 'ironic',
          :admin_password    => 's3cr3t',
          :admin_url         => 'http://10.0.0.10:35357/v2.0',
          :admin_tenant_name => 'services2',
          :api_endpoint      => 'http://10.0.0.10:6385/v1',
        }
      end

      it 'configures ironic in nova.conf' do
        is_expected.to contain_nova_config('ironic/username').with_value('ironic')
        is_expected.to contain_nova_config('ironic/password').with_value('s3cr3t')
        is_expected.to contain_nova_config('ironic/auth_url').with_value('http://10.0.0.10:35357/v2.0')
        is_expected.to contain_nova_config('ironic/project_name').with_value('services2')
        is_expected.to contain_nova_config('ironic/api_endpoint').with_value('http://10.0.0.10:6385/v1')

        is_expected.to contain_nova_config('ironic/admin_username').with_value('ironic')
        is_expected.to contain_nova_config('ironic/admin_password').with_value('s3cr3t')
        is_expected.to contain_nova_config('ironic/admin_url').with_value('http://10.0.0.10:35357/v2.0')
        is_expected.to contain_nova_config('ironic/admin_tenant_name').with_value('services2')
      end
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts)
      end
      it_configures 'nova-ironic-common'
    end
  end
end
