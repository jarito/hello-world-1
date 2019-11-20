import { LightningElement , track } from 'lwc';

export default class SkillSet extends LightningElement {
    @track openmodel = false;
    @track skillSetId = false;
    
    handleClick(event){
        this.openmodel = true;
        this.skillSetId = true;
    }

    closeModal() {
        this.openmodel = false;
    }

    handleSubmit(){
        this.openmodel = false;
        const message = "Fired"; 
        const modalEvent = new CustomEvent('filterchange', {
            detail: { message },
        });
        // Fire the custom event
        this.dispatchEvent(modalEvent); 
    }


}