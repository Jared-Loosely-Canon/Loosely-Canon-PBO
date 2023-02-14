import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import validateEmailController from '@salesforce/apex/MailboxlayerEmailValidation.validateEmailController';

export default class ValidateEmailComponent extends LightningElement {
    @api recordId;
    @api recordIds;

    handleValidateEmail() {
        if(this.recordIds === undefined && this.recordId !== undefined) {
            let o = [];
            o.push(this.recordId);
            this.recordIds = o;
        }
        validateEmailController({ ids: this.recordIds })
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Email validated',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error validating email',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}