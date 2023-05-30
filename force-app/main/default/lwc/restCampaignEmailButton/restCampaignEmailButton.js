import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import emaill from '@salesforce/apex/RestCampaignEmailButtonController.sendCampaignEmail';

export default class RestCampaignEmailButton extends LightningElement {
    @api recordId;

    handleButton() {
        emaill({ id: this.recordId })
        .then(result => {
            // Handle success response
            this.showToast('Success', 'Send Email', 'Successfully started queued the email', 'success');
        })
        .catch(error => {
            // Handle error response
            this.showToast('Error', 'Send Campaign', 'Failed to queue the email', 'error');
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