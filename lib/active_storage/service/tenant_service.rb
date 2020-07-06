# require "active_storage/service/disk_service"
#
# module ActiveStorage
#   class Service::TenantService < Service::DiskService
#     def path_for(key)
#       current_tenant = Apartment::Tenant.current
#       File.join root, current_tenant, folder_for(key), key
#     end
#   end
# end
