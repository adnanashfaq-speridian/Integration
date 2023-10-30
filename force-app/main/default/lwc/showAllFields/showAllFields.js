import { LightningElement,api,track,wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import upsertMetadata from '@salesforce/apex/MetadataService.upsertMetadata';
 
export default class ShowAllFields extends LightningElement {
    @track objectNameToGetFields = 'Account';
    @track lstFields =[];
    @api selectedfields;
    @api metaApiName='LWC_Lookup_Field__mdt';
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
            console.log('Error while getting fields');
            this.lstFields = [];
        }
    }

    handleChange(e) {
        this.value = e.detail.value;
        this.selectedfields = e.detail.value;
    }

    doSearch() {
        upsertMetadata({ selectedFields: JSON.stringify(this.selectedfields) })
            .then(result => {
                console.log('result here == '+ JSON.stringify(result));
            })
            .catch(error => {
                console.log('error here == '+ JSON.stringify(error));
            });
    }
    

    saveClick(e){
        var fieldValues=[];
        for(const element of this.records) {
            var obj = {};
            obj[element.name] = element.value;
            fieldValues.push(obj);
        }

        updateMetadata({
            fullName:this.metaApiName, 
            label:this.recordName, 
            fieldWithValues:JSON.stringify(fieldValues)
        }).then(result =>{
            console.log('result:'+result);
            this.template.querySelector('c-common-toast').showToast('success', 'Deployment is in progress for metadata update');
            return
        }).catch(error =>{
            console.log('Error in getSelectedCustomer Method :: ',JSON.stringify(error));
            this.isLoading =false;
            this.template.querySelector('c-common-toast').showToast('error', JSON.stringify(error));
            return
        })
    }
}