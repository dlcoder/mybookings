admin = User.create({ email: 'skuark@gmail.com', password: '12345678' })

admin.roles = [:admin]
admin.save!

resource_type_vp = ResourceType.create({ name: 'Virtual PC' })
resource_type_acmr = ResourceType.create({ name: 'Adobe Connect Meeting Room' })

resources = Resource.create([
  { name: 'PC1', resource_type: resource_type_vp },
  { name: 'PC2', resource_type: resource_type_vp },
  { name: 'AC2', resource_type: resource_type_acmr },
  { name: 'AC1', resource_type: resource_type_acmr }
])
