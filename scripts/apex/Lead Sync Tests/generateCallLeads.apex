
List<String> phones = new List<String>{'1-800-935-9935', '1-800-432-3117', '1-800-242-7338', 
    '1 (800) 432-1000', '888.550.6433', '888.635.6000', '800.732.9194', '1-888-751-9000', '800-669-3900', '(877) 700-2913'};
Lead[] leadInsert = new List<Lead>();

Integer i = 0;
for(String phone : phones){
    Lead lead = new Lead();
    lead.FirstName = 'Lead';
    lead.LastName = 'Test'+i;
    lead.Company = 'Bank'+i;
    lead.Email = '';
    lead.Phone = phone;
    leadInsert.add(lead);
    i++;
}

insert leadInsert;