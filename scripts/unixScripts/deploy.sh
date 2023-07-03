sfdx force:source:deploy -x manifest/package.xml



sfdx force:source:deploy -x manifest/CC-Demo-Setup.xml 
sfdx force:source:deploy -p "force-app/main/default" -l RunLocalTests -c

sfdx force:source:deploy -p "force-app/main/default/reports"

sfdx project:deploy:start -x manifest/Canon-Emails-V1.0.xml -l RunLocalTests

sfdx project:deploy:start -x manifest/Prod-Align-7-3.xml
sfdx project:deploy:start -x manifest/LCC-247.xml