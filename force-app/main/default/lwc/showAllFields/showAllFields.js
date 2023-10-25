import { LightningElement,api,track,wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
 
export default class ShowAllFields extends LightningElement {
    @track objectNameToGetFields = 'Account';
    @track lstFields =[];
    @wire(getObjectInfo, { objectApiName: '$objectNameToGetFields' })
    
    getObjectInfo({ error, data }) {
        if (data) {
            this.lstFields = [];
            for (let key in data.fields) {
                if (data.fields.hasOwnProperty(key)) {
                    this.lstFields.push({ value: key, label:key});
                }
            }
        }
        else if (error) {
            console.log('Error while get fields');
            this.lstFields = [];
        }
    }
}