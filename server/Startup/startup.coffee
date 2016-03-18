Meteor.startup( ->
#  Migrations.migrateTo 0
  Migrations.migrateTo('latest')
)