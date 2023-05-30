sfdx force:source:deploy -x manifest/package.xml



sfdx force:source:deploy -x manifest/CC-Demo-Setup.xml 
sfdx force:source:deploy -p "force-app/main/default" -l RunLocalTests -c

sfdx force:source:deploy -p "force-app/main/default/reports"

sfdx project:deploy:start -x manifest/Canon-Emails-V1.0.xml -l RunLocalTests