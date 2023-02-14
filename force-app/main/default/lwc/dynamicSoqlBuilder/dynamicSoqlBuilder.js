import { LightningElement, track } from 'lwc';

export default class DynamicSoqlBuilder extends LightningElement {
  @track query = '';
  @track fields = [{ name: 'field1', value: '' }];
  options = [
    { label: 'Id', value: 'Id' },
    { label: 'Name', value: 'Name' },
    { label: 'Email', value: 'Email' },
    { label: 'Phone', value: 'Phone' },
    // ... add more options
  ];

  addField() {
    this.fields = [...this.fields, { name: `field${this.fields.length + 1}`, value: '' }];
  }

  removeField(event) {
    this.fields = this.fields.filter(field => field.name !== event.target.name);
  }

  handleFieldSelection(event) {
    const fields = this.fields.map(field => {
      if (field.name === event.target.name) {
        return { ...field, value: event.detail.value };
      }
      return field;
    });
    this.fields = fields;
  }

  generateQuery() {
    const selectedFields = this.fields
      .filter(field => field.value)
      .map(field => field.value)
      .join(', ');
    this.query = `SELECT ${selectedFields} FROM Account`;
  }

}