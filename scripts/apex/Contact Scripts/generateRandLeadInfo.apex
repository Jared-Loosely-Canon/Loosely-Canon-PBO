Integer len = 100;

Contact[] ContactInsert = new List<Contact>();
for(Integer i=0;i<len;i++){
    String phone = '';
    while(phone.length() < 10){
        phone += String.valueOf(Integer.valueof(Math.random()*10));
    }
    // Integer randomNumber1 = Integer.valueof((Math.random() * 1000));
    // Integer randomNumber2 = Integer.valueof((Math.random() * 1000));
    // Integer randomNumber3 = Integer.valueof((Math.random() * 10000));

    // String num = String.valueOf(randomNumber1) + ' ' + String.valueOf(randomNumber2) + ' ' + String.valueOf(randomNumber3);
    Contact Contact = new Contact();
    Contact.FirstName = 'Contact';
    Contact.LastName = 'Test'+i;
    Contact.Email = '';
    Contact.Phone = phone;
    ContactInsert.add(Contact);
}
Database.insert(ContactInsert, false);