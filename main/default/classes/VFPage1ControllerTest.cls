/**
 * Test class to verify working of all the wizards and controller logic
 */
@isTest
public with sharing class VFPage1ControllerTest {
	/**
	 * Method to verify whether selected attachment is getting deleted
	 */
	static testMethod void checkDeleteMethod(){
		List<Account> accountList = TestDataFactory.createAccount(1);
		insert accountList;
		List<Id> accountIds = new List<Id>();
		for(Account eachId : accountList){
			accountIds.add(eachId.Id);
		}
		Attachment attachObj = new Attachment();
		VFPage1Controller objectPM51Controller = new VFPage1Controller( new ApexPages.StandardController(accountList[0]));
		List<Attachment> attachList = TestDataFactory.createAttachment(accountIds , 3);
		insert attachList;
		test.startTest();
		objectPM51Controller.accountID = attachList[0].Id;
		PageReference pageRef = objectPM51Controller.deleteAttachment();
		system.debug('--------> '+pageRef);
		List<Attachment> attachObject = [Select Name  From Attachment];
		system.debug('No of Attachments remaining-->' + attachObject.size());
		test.stopTest();
		/** 
		 * Asserts to verify the count of attachments after the method call
		 * And check whether correct attachment is getting deleted 
		 */
		system.assertEquals(2,attachObject.size(),'Check the value of "AccountID" ');	
		for(Attachment eachAttachment : attachObject){
			system.assert(!eachAttachment.Name.contains(accountList[0].Name));
		}	
 	}

	/**
	 * Method to verifty whether current page is getting redirected to appropriate page
	 * Here, VFPage1 should get redirected to VFPage2 on clicking "Edit" button
	 */
	static testMethod void checkPage1Redirection(){
		List<Account> accountList = TestDataFactory.createAccount(1);
		insert accountList;
		VFPage1Controller objectPM51Controller = new VFPage1Controller( new ApexPages.StandardController(accountList[0]));
		test.startTest();
		PageReference checkReference = ApexPages.currentPage();
		system.debug('----Current PAGE Ref----> '+checkReference);
		PageReference pageRef = objectPM51Controller.VFStep2();
		system.debug('----Redirection from VFPage1 to VFPage2 on clicking "Edit" button----> '+pageRef);
		test.stopTest();
		system.assertNotEquals(checkReference , pageRef);

 	}

	/**
	 * Method to verifty whether current page is getting redirected to appropriate page
	 * Here, VFPage2 should get redirected to VFPage3 on clicking "Next" button
	 */
	static testMethod void checkPage2Redirection(){
		List<Account> accountList = TestDataFactory.createAccount(1);
		insert accountList;
		VFPage1Controller objectPM51Controller = new VFPage1Controller( new ApexPages.StandardController(accountList[0]));
		test.startTest();
		PageReference checkReference = ApexPages.currentPage();
		system.debug('----Current PAGE Ref----> '+checkReference);		
		PageReference pageRef = objectPM51Controller.VFStep3();
		system.debug('----Redirection from VFPage2 to VFPage3 on clicking "Next" button----> '+pageRef);
		test.stopTest();
		system.assertNotEquals(checkReference , pageRef);
 	}
	/**
	 * Method the test whether new Attachment is getting attached 
	 * Note : Account is not edited
	 */
	static testMethod void checkAttachmentOnly(){
		List<Account> accountList = TestDataFactory.createAccount(1);
		insert accountList;
		VFPage1Controller objectPM51Controller = new VFPage1Controller( new ApexPages.StandardController(accountList[0]));
		test.startTest();
	  	PageReference pageReference = Page.VFPage3; // Add your VF page Name here
  		pageReference.getParameters().put('id', String.valueOf(accountList[0].Id));
  		Test.setCurrentPage(pageReference);
		system.debug('----Current PAGE ----> '+pageReference);

		objectPM51Controller.attachment.Name = 'New Test Attachment';
        Blob bodyBlob=Blob.valueOf('New Test Attachment Body');
        objectPM51Controller.attachment.body=bodyBlob;
		objectPM51Controller.attachment.description = 'Test this Attachment';
		PageReference pageRef = objectPM51Controller.save();
		system.debug('----Redirection   to VFPage2 ----> '+pageRef);
		test.stopTest();
		List<Attachment> checkList = [Select Name From Attachment];
		system.debug('---Check Attachment----> '+checkList);		
		system.assert(checkList[0].Name.contains('New Test Attachment'));
 	}
	/**
	 * Method the test whether new Attachment is getting attached along with 
	 * the changes made in Account details
	 * Note : Account is  edited
	 */
	static testMethod void checkAttachmentAndAccount(){
		List<Account> accountList = TestDataFactory.createAccount(1);
		insert accountList;
		VFPage1Controller objectPM51Controller = new VFPage1Controller( new ApexPages.StandardController(accountList[0]));
		test.startTest();
		accountList[0].Industry = 'Banking';
	  	PageReference pageReference = Page.VFPage3; // Add your VF page Name here
  		pageReference.getParameters().put('id', String.valueOf(accountList[0].Id));
  		Test.setCurrentPage(pageReference);
		system.debug('----Current PAGE ----> '+pageReference);

		objectPM51Controller.attachment.Name = 'New Test Attachment';
        Blob bodyBlob=Blob.valueOf('New Test Attachment Body');
        objectPM51Controller.attachment.body=bodyBlob;
		objectPM51Controller.attachment.description = 'Test this Attachment';
		PageReference pageRef = objectPM51Controller.save();
		system.debug('----Redirection   to VFPage2 ----> '+pageRef);
		test.stopTest();
		List<Attachment> checkList = [Select Name From Attachment];
		system.debug('---Check Attachment----> '+checkList);		
		system.assert(checkList[0].Name.contains('New Test Attachment'));
		List<Account> checkAccountIndustry = [Select Industry From Account];
		system.debug('---Check Account Industry----> '+checkAccountIndustry[0].Industry);		
		system.assert(checkAccountIndustry[0].Industry.contains('Banking'));
 	}
	/**
	 * Method to test whether changes made in account details are saved when attachment is not added
	 * Note : Attachment is not added
	 */
	static testMethod void checkAccountUpdatesNoAttachment(){
		List<Account> accountList = TestDataFactory.createAccount(1);
		insert accountList;
		VFPage1Controller objectPM51Controller = new VFPage1Controller( new ApexPages.StandardController(accountList[0]));
		test.startTest();
		accountList[0].Industry = 'Banking';
	  	PageReference pageReference = Page.VFPage3; // Add your VF page Name here
  		pageReference.getParameters().put('id', String.valueOf(accountList[0].Id));
  		Test.setCurrentPage(pageReference);
		system.debug('----Current PAGE ----> '+pageReference);

		objectPM51Controller.attachment.Name = ' ';
        Blob bodyBlob=Blob.valueOf(' ');
        objectPM51Controller.attachment.body=bodyBlob;
		objectPM51Controller.attachment.description = '';
		PageReference pageRef = objectPM51Controller.save();
		system.debug('----Redirection   to VFPage2 ----> '+pageRef);
		test.stopTest();
		List<Attachment> checkList = [Select Name From Attachment];
		system.debug('---Check Attachment----> '+checkList);		
		system.assert(checkList.Size() == 0);
 	}
}