Integer len = 10;
List<String> firstNames = new List<String>{'Emma', 'Olivia', 'Ava', 'Isabella', 'Sophia', 'Mia', 'Charlotte', 'Amelia', 'Harper', 'Evelyn', 'Abigail', 'Emily', 'Elizabeth', 'Mila', 'Ella', 'Avery', 'Sofia', 'Camila', 'Aria', 'Scarlett'};
List<String> lastNames = new List<String>{'Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Perez', 'Taylor', 'Anderson', 'Wilson', 'Moore', 'Jackson', 'Martin'};
List<String> companyNames = new List<String>{'Acme', 'Apex', 'Cosmo', 'Delta', 'Echo', 'Gamma', 'Innovate', 'Lion', 'Momentum', 'Neon', 'Omega', 'Pinnacle', 'Quantum', 'Spectrum', 'Synergy', 'Titan', 'Velocity', 'Vortex', 'Zenith', 'Zephyr'};

Lead[] leadInsert = new List<Lead>();
for(Integer i=0;i<len;i++){
    String phone = '';
    String mobile = '';
    while(phone.length() < 10){
        phone += String.valueOf(Integer.valueof(Math.random()*10));
        mobile += String.valueOf(Integer.valueof(Math.random()*10));
    }
    Lead lead = new Lead();
    lead.FirstName = firstNames[Math.mod(i, firstNames.size())];
    lead.LastName = lastNames[Math.mod(i, lastNames.size())];
    lead.Company = companyNames[Math.mod(i, companyNames.size())];
    lead.Email = lead.FirstName+lead.LastName+'@'+lead.Company+'.com';
    lead.Phone = phone;
    lead.MobilePhone = mobile;
    leadInsert.add(lead);
}
insert leadInsert;
