import { LightningElement,track,wire,api } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation'
//import Pubsub from '@salesforce/resourceUrl/pubsub';
//import {  loadScript } from 'lightning/platformResourceLoader';
import {fireEvent} from 'c/pubsub'
import findAccounts from '@salesforce/apex/serverRecordList.findAccounts';
const DELAY = 300;
export default class MyFirstWebComponent extends LightningElement {
    @track searchKey ;
    @api selectedRecordId;
    @wire(findAccounts , { searchKey : '$searchKey' } )accountList;
    @wire(CurrentPageReference) pageRef ;
/*    renderedCallback() {
        Promise.all([
            loadScript(this, Pubsub + '/pubsub.js'),
        ])
    }*/

    handleChange(event){
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
    selectedRecord(event){
        //this.selectedRecordId = event.target.getAttribute('id');
        this.selectedRecordId = event.target.getAttribute('value');
        fireEvent(this.pageRef , 'accountId' , this.selectedRecordId );
        this.accountList = '';
        console.log(this.selectedRecordId);
    }
}