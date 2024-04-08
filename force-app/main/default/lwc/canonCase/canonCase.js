import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CanonCase extends LightningElement {
    subject = '';
    priority = 'Medium';
    description = '';
    url = window.location.href;

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handlePriorityChange(event) {
        this.priority = event.target.value;
    }

    handleDescriptionChange(event) {
        this.description = event.target.value;
    }

    handleUrlChange(event) {
        this.url = event.target.value;
    }

    handleAddCurrentURL() {
        // Get the current URL using the window.location object
        this.url = window.location.href;
    }

    handleSubmit(){
        if(this.subject == '' || this.subject == null || this.subject == undefined
            || this.description == '' || this.description == null || this.description == undefined
            || this.url == '' || this.url == null || this.url == undefined
            || this.priority == '' || this.priority == null || this.priority == undefined){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Please fill all the required fields',
                    variant: 'error'
                })
            );
            return;
        }
        const data = {
            subject: this.subject,
            description: this.description,
            url: this.url,
            priority: this.priority
        };
        console.log(JSON.stringify(data));
    }

    // You can add further logic to handle form submission or data processing here.
}
