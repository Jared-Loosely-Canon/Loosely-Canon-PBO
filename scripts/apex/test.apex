String query = Utilities.queryAllFields(describeResult, 'Campaign') + ' FROM Campaign WHERE Id = 701DC000000UQTiYAO';
Campaign c = Database.query(query);
