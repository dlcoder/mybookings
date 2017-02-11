admin = Mybookings::User.create({ email: 'user@example.com', password: '12345678' })

admin.roles = [:admin]
admin.save!

resource_type_vp = Mybookings::ResourceType.create({ name: 'Virtual PC', extension: 'DefaultExtension', roles_mask: 0 })
resource_type_acmr = Mybookings::ResourceType.create({ name: 'Adobe Connect Meeting Room', extension: 'DefaultExtension', roles_mask: 14 })

resources = Mybookings::Resource.create([
  { name: 'PC1', resource_type: resource_type_vp },
  { name: 'PC2', resource_type: resource_type_vp },
  { name: 'AC2', resource_type: resource_type_acmr },
  { name: 'AC1', resource_type: resource_type_acmr }
])
