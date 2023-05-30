/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 05-26-2023
 * @last modified by  : Jared Simpson
**/
public class CampaignMemberDetails {
    public CampaignMember campaignMember { get; set; }
    public Contact contact { get; set; }
    public Lead lead { get; set; }
    
    public CampaignMemberDetails(CampaignMember cm, Contact c) {
        campaignMember = cm;
        contact = c;
    }
    
    public CampaignMemberDetails(CampaignMember cm, Lead l) {
        campaignMember = cm;
        lead = l;
    }
}