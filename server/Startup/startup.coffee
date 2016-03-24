Meteor.startup( ->
#  Migrations.migrateTo 0
  Migrations.migrateTo('1,rerun')
)