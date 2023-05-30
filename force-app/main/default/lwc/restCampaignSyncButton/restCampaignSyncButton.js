import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import syncCampaign from '@salesforce/apex/RestCampaignSyncController.syncCampaign';

export default class RestCampaignSyncButton extends LightningElement {
  @api recordId;

  handleSyncCampaign() {
    syncCampaign({ id: this.recordId })
      .then(result => {
        // Handle success response
        this.showToast('Success', 'Sync Campaign', 'Successfully started the sync', 'success');
      })
      .catch(error => {
        // Handle error response
        this.showToast('Error', 'Sync Campaign', 'Failed to start the sync', 'error');
      });
  }

    showToast(title, message, variant, mode = 'dismissable') {
        const toastEvent = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
        mode: mode
        });
        this.dispatchEvent(toastEvent);
    }
}