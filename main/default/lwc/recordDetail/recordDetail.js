import { LightningElement , api, wire , track } from 'lwc';
import { registerListener } from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class RecordDetail extends LightningElement {
    @api objectName ; 
    @track accountId;
    @track accDisplay;
    @track objectBool = false;
    @track openmodel = false;
    @wire(CurrentPageReference) pageRef ;

    connectedCallback(){
        registerListener('accountId' , this.displayAccountDetails , this );
    }

    displayAccountDetails(accountId){
        this.accountId = accountId;
        if(this.objectName === 'Account'){
            this.accDisplay = 'Hello Account !';
            this.objectBool = true;
        }
    }
    
    editAccount(event){
        this.openmodel = true;
        this.accountId = event.target.value
    }

    closeModal() {
        this.openmodel = false;
    }

    handleSubmit(){
        this.openmodel = false;  
    }
}