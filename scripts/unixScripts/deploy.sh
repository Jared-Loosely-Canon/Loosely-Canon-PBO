sfdx force:source:deploy -x manifest/package.xml



sfdx force:source:deploy -x manifest/CC-Demo-Setup.xml 
sfdx force:source:deploy -p "force-app/main/default" -l RunLocalTests -c