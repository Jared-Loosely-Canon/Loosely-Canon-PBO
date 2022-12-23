Integer len = 100;

Lead[] leadInsert = new List<Lead>();
for(Integer i=0;i<len;i++){
    String phone = '';
    while(phone.length() < 10){
        phone += String.valueOf(Integer.valueof(Math.random()*10));
    }
    Lead lead = new Lead();
    lead.FirstName = 'Lead';
    lead.LastName = 'Test'+i;
    lead.Company = 'Test'+i;
    lead.Email = '';
    lead.Phone = phone;
    leadInsert.add(lead);
}
insert leadInsert;