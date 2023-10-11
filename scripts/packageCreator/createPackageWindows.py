import sys

def setupFileName(filename):
    # remove folder name from filename
    filename = filename.split('/')[-1]

    # remove file extension from filename
    filename = filename.split('.')[0]

    return filename

def setupFileNameCmdt(filename):
    # remove folder name from filename
    filename = filename.split('/')[-1]

    # remove file extension from filename
    filename = ".".join(filename.split('.')[0:2])
    print(filename)

    return filename

def setupFileNameWithObjectName(filename):
    # remove folder name from filename
    objectName = filename.split('/')[-3]
    filename = filename.split('/')[-1]

    # remove file extension from filename
    filename = filename.split('.')[0]

    return objectName + '.' + filename

def writeTypeToPackage(arr, type):
    p = "    <types>\n"
    for i in arr:
        p += f"        <members>{i}</members>\n"
    p += f"        <name>{type}</name>\n"
    p += "    </types>\n"
    return p

newFiles = sys.argv[1]
modifiedFiles = sys.argv[2]
branchName = sys.argv[3]
pathToOutput = './manifest/'

filesToHandle = [newFiles.split(' '), modifiedFiles.split(' ')]
print(filesToHandle)
# Open the package.xml file for writing

with open(pathToOutput + branchName+'.xml', 'w') as packageFile:
    # Write the XML header and opening tag
    packageFile.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')
    packageFile.write('<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n')

    arrs = {'ApexClass': [], 'ApexTrigger': [], 'CustomField': [],
            'Layout': [],
            'Profile': [], 'RecordType': [], 'CustomPermission': [],
            'Workflow': [],
            'Flow': [], 'CustomObject': [], 'LightningComponentBundle': [],
            'FlexiPage': [], 'ValidationRule': [], 'AssignmentRules': [],
            'StandardValueSet': [], 'FieldSet': [], 'GlobalValueSet': [],
            'PermissionSet': [], 'CompactLayout': [], 'Queue': [],
            'QueueRoutingConfig': [], 'QuickAction': [],
            'ReportType': [], 'CustomMetadata': [], 'BusinessProcess': [],
            'ApexPage': [], 'LeadConvertSettings': [], 'CustomApplication': [],
            'ExternalCredential': [], 'NamedCredential': [], 'ListView': [],
            'ConnectedApp': [], 'CustomTab': [], 'PathAssistant': [],
            'ApprovalProcess': []}

    # Iterate over each line of input from stdin
    for file in filesToHandle:
        for filename in file:
            filename = filename.strip()

            # Debugging output
            # print(f'Processing {filename}...')

            # Determine the metadata type based on the file extension
            if filename.endswith('.cls') and not filename.startswith('.sfdx/tools/sobjects'):
                arrs['ApexClass'].append(setupFileName(filename))
            elif filename.endswith('.trigger'):
                metadataType = 'ApexTrigger'
                arrs['ApexTrigger'].append(setupFileName(filename))
            elif filename.endswith('.field-meta.xml'):
                metadataType = 'CustomField'
                arrs['CustomField'].append(setupFileNameWithObjectName(filename))
            elif filename.endswith('.layout-meta.xml'):
                metadataType = 'Layout'
                arrs['Layout'].append(setupFileName(filename))
            elif filename.endswith('.flow-meta.xml'):
                metadataType = 'Flow'
                arrs['Flow'].append(setupFileName(filename))
            elif filename.endswith('.object-meta.xml'):
                metadataType = 'CustomObject'
                arrs['CustomObject'].append(setupFileName(filename))
            elif filename.endswith('.js') or filename.endswith('.html') or filename.endswith('.css') or filename.endswith('.js-meta.xml'):
                metadataType = 'LightningComponentBundle'
                if setupFileName(filename) not in arrs['LightningComponentBundle']:
                    arrs['LightningComponentBundle'].append(setupFileName(filename))
            elif filename.endswith('.flexipage-meta.xml'):
                metadataType = 'FlexiPage'
                arrs['FlexiPage'].append(setupFileName(filename))
            elif filename.endswith('.standardValueSet-meta.xml'):
                metadataType = 'StandardValueSet'
                arrs['StandardValueSet'].append(setupFileName(filename))
            elif filename.endswith('.fieldSet-meta.xml'):
                metadataType = 'FieldSet'
                arrs['FieldSet'].append(setupFileName(filename))
            elif filename.endswith('.globalValueSet-meta.xml'):
                metadataType = 'GlobalValueSet'
                arrs['GlobalValueSet'].append(setupFileName(filename))
            elif filename.endswith('.permissionset-meta.xml'):
                metadataType = 'PermissionSet'
                arrs['PermissionSet'].append(setupFileName(filename))
            elif filename.endswith('.profile-meta.xml'):
                metadataType = 'Profile'
                arrs['Profile'].append(setupFileName(filename))
            elif filename.endswith('.recordType-meta.xml'):
                metadataType = 'RecordType'
                arrs['RecordType'].append(setupFileNameWithObjectName(filename))
            elif filename.endswith('.validationRule-meta.xml'):
                metadataType = 'ValidationRule'
                arrs['ValidationRule'].append(setupFileNameWithObjectName(filename))
            elif filename.endswith('.compactLayout-meta.xml'):
                metadataType = 'CompactLayout'
                arrs['CompactLayout'].append(setupFileName(filename))
            elif filename.endswith('.customPermission-meta.xml'):
                metadataType = 'CustomPermission'
                arrs['CustomPermission'].append(setupFileName(filename))
            elif filename.endswith('.assignmentRules-meta.xml'):
                metadataType = 'AssignmentRules'
                arrs['AssignmentRules'].append(setupFileName(filename))
            elif filename.endswith('.queue-meta.xml'):
                metadataType = 'Queue'
                arrs['Queue'].append(setupFileName(filename))
            elif filename.endswith('.queueRoutingConfig-meta.xml'):
                metadataType = 'QueueRoutingConfig'
                arrs['QueueRoutingConfig'].append(setupFileName(filename))
            elif filename.endswith('.reportType-meta.xml'):
                metadataType = 'ReportType'
                arrs['ReportType'].append(setupFileName(filename))
            elif filename.endswith('.workflow-meta.xml'):
                metadataType = 'Workflow'
                arrs['Workflow'].append(setupFileName(filename))
            elif filename.endswith('.md-meta.xml'):
                metadataType = 'CustomMetadata'
                arrs['CustomMetadata'].append(setupFileNameCmdt(filename))
            elif filename.endswith('.businessProcess-meta.xml'):
                metadataType = 'BusinessProcess'
                arrs['BusinessProcess'].append(setupFileNameWithObjectName(filename))
            elif filename.endswith('.page'):
                metadataType = 'ApexPage'
                arrs['ApexPage'].append(setupFileName(filename))
            elif filename.endswith('.LeadConvertSetting-meta.xml'):
                metadataType = 'LeadConvertSettings'
                arrs['LeadConvertSettings'].append(setupFileName(filename))
            elif filename.endswith('.app-meta.xml'):
                metadataType = 'CustomApplication'
                arrs['CustomApplication'].append(setupFileName(filename))
            elif filename.endswith('.externalCredential-meta.xml'):
                metadataType = 'ExternalCredential'
                arrs['ExternalCredential'].append(setupFileName(filename))
            elif filename.endswith('.namedCredential-meta.xml'):
                metadataType = 'NamedCredential'
                arrs['NamedCredential'].append(setupFileName(filename))
            elif filename.endswith('.connectedApp-meta.xml'):
                metadataType = 'ConnectedApp'
                arrs['ConnectedApp'].append(setupFileName(filename))
            elif filename.endswith('.tab-meta.xml'):
                metadataType = 'CustomTab'
                arrs['CustomTab'].append(setupFileName(filename))
            elif filename.endswith('.pathAssistant-meta.xml'):
                metadataType = 'PathAssistant'
                arrs['PathAssistant'].append(setupFileName(filename))
            elif filename.endswith('.approvalProcess-meta.xml'):
                metadataType = 'ApprovalProcess'
                arrs['ApprovalProcess'].append(setupFileNameWithObjectName(filename))
            elif filename.endswith('.listView-meta.xml'):
                metadataType = 'ListView'
                arrs['ListView'].append(setupFileNameWithObjectName(filename))
            elif filename.endswith('.quickAction-meta.xml'):
                metadataType = 'QuickAction'
                arrs['QuickAction'].append(setupFileNameWithObjectName(filename))
            else:
                continue

    for k in arrs:
        if (len(arrs[k]) != 0):
            packageFile.write(writeTypeToPackage(arrs[k], k))

    # Write the XML closing tag and version number
    packageFile.write('    <version>55.0</version>\n')
    packageFile.write('</Package>\n')