import { LightningElement , api , track , wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation'
import findOpportunities from '@salesforce/apex/serverRecordList.findOpportunities';
import { registerListener } from 'c/pubsub';

export default class MyRecords extends LightningElement {
    @api opportunityObject = false;
    @api objectName ;
    @track recId;
    @track items;
    @track index;
    @track message;
    @track msg;
    @track iconName = "utility:right";
    @track opportunityId;
    @wire(CurrentPageReference) pageRef ;
    @wire(findOpportunities , { recId : '$recId' } )opportunityList;

    connectedCallback(){
        registerListener('accountId' , this.displayRelatedOpportunities , this );
    }

    displayRelatedOpportunities(accountId){
        console.log("level 1");
        if(this.objectName === 'Opportunity'){
            console.log("level 2");
            this.opportunityObject = true;
            this.recId = accountId;
        }
    }
    recordDetailPage(event){
        this.opportunityId = event.target.value;
        var baseURL = 'https://shruti-kulkarni-dev-ed.lightning.force.com/lightning/r/Opportunity/';
        var baseView = '/view';
        var recordId = this.opportunityId;
        var finalUrl = baseURL+recordId+baseView;
        window.open(finalUrl,'_blank');
    }
   /* toggle(event){
        this.items = this.opportunityList;
        this.index = event.target.name;
        this.msg = event.target.name;
        var checkId = event.target.value;
        console.log("checkId--> "+checkId);
        console.log("**"+this.index);


    }*/
}